/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.spark.mllib.fpm

import oscar.algo.reversible._
import PrefixSpan.Sequence
import oscar.cp._
import oscar.cp.CPIntVar
import oscar.cp.core._
import oscar.cp.core.CPOutcome._

import org.apache.spark.internal.Logging
import org.apache.spark.mllib.fpm.PrefixSpan.Postfix

// Array implementation

/**
 * Calculate all patterns of a projected database in local mode.
 *
 * @param prefix the current prefix
 * @param minSup minimal support for a frequent pattern
 * @param minPatternLength min pattern length for a frequent pattern
 * @param maxPatternLength max pattern length for a frequent pattern
 */
private[fpm] class MultiItemPPICRunner( val prefix: Array[Int],
                                        val minSup: Long,
                                        val minPatternLength: Int,
                                        val maxPatternLength: Int,
                                        val maxItemPerItemset: Int,
                                        val spaceRemainingInCurrentItem: Int,
                                        val itemConstraints: Array[(Int, String, Int)],
                                        val bannedItem: Array[Int])
  extends CPModel with App with Logging with Serializable{

  // Define separator
  var separator = 0
  var epsilon = -1

  var numItems = 0
  var lenSeqMax = 0
  var nbSequences = 0

  var itemSupportCounter: scala.collection.mutable.Map[Int, Int] =
    scala.collection.mutable.Map[Int, Int]()

  // One to one translation map
  var translationMap = collection.mutable.Map[Int, Int]()
  var translationMapReverse = collection.mutable.Map[Int, Int]()

  def getLastItemFromPrefix(): Array[Int] = {
    prefix.drop(prefix.lastIndexOf(separator) + 1)
  }

  /**
   * Adds an entry to the translation map.
   *
   * @param value : An item supported by the sequences
   * @return the new representation of the old value, which
   *         will be used as a substitute for the actual
   *         value in the algorithm.
   *         (The new reprensentation is an Int > 0)
   */
  def updateTranslationMap(value: Int): Int = {

    // Add new value in reverse map
    numItems += 1
    translationMapReverse.update(numItems, value)
    // Return the new representation
    numItems
  }

  /**
   * Removes first element before first 0
   * Then count support for each item, so that unsupported item can be removed in the future.
   *
   * @return the inputed postfixes, desencapsulated and with the first elem removed
   */
  def preProcessPostfixes(postfixes: Array[Sequence]):
  (Array[Array[Int]], Array[ReversibleArrayStack[Set[Int]]],
    Array[Array[Int]], Array[Array[Int]], Boolean) = {

    val preprocessedSequence = scala.collection.mutable.ArrayBuilder
      .make[Array[Int]]
    val newPartialProjection = scala.collection.mutable.ArrayBuilder
      .make[ReversibleArrayStack[Set[Int]]]
    var firstItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
    var lastItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
    itemSupportCounter = collection.mutable.Map[Int, Int]()

    // Count support for each item
    val itemSupportedByThisSequence = collection.mutable.Map[Int, Int]()
    for (postfix <- postfixes) {
      for (i <- Range(1, postfix.items.length)) {
        itemSupportedByThisSequence.update(postfix.items(i), 1)
      }
      itemSupportedByThisSequence.keysIterator.foreach(x =>
        itemSupportCounter.update(x, itemSupportCounter.getOrElse(x, 0) + 1)
      )
      itemSupportedByThisSequence.clear()
    }

    // Filter unsupported item, make sure there are no consecutive zeros
    itemSupportCounter = itemSupportCounter.retain((k, v) => v >= minSup && !bannedItem.contains(k))

    val seqStart = // If prefix is empty, we keep first elem, else we remove
      if (prefix.isEmpty) 0
      else 1
    // Boolean to check if we should use single item PPIC instead
    var shouldUseSingleItemPPIC = true
    // Remove unsupported item
    for (postfix <- postfixes) {
      // Create SDB postfix
      var partialAddedSinceLastZero = 0
      var nbItemAdded = 0
      var nbItemAddedSinceLastZero = 1 // Start at one so that first 0 always in
                                       // No problem for singleItem sequences
      val curPostfix = scala.collection.mutable.ArrayBuilder.make[Int]
      val partialProjections = scala.collection.mutable.Stack[Int]()
      val firstItemPosInSeq = Array.fill(itemSupportCounter.size)(0)
      val lastItemPosInSeq = Array.fill(itemSupportCounter.size)(0)

      for (i <- Range(seqStart, postfix.items.length)) {
        val x = postfix.items(i)
        if (x == 0) {
          if (nbItemAddedSinceLastZero > 0) {
            partialAddedSinceLastZero = 0
            if (nbItemAddedSinceLastZero > 1) shouldUseSingleItemPPIC = false
            nbItemAddedSinceLastZero = 0
            curPostfix += x
            nbItemAdded += 1
          }
          else while (partialAddedSinceLastZero > 0) {
            // If item emptied, remove partial start for that item
            partialProjections.pop()
            partialAddedSinceLastZero -= 1
          }
        }
        else if (itemSupportCounter.getOrElse(x, 0) >= minSup) {
          val trans = translationMap.getOrElseUpdate(x, updateTranslationMap(x))
          nbItemAdded += 1
          nbItemAddedSinceLastZero += 1
          curPostfix += trans
          // Update pos lists
          lastItemPosInSeq(trans) = nbItemAdded
          // If necessary, update first pos in current sequence for current item
          if (firstItemPosInSeq(trans) == 0) {
            firstItemPosInSeq(trans) = nbItemAdded
          }
        }
        // Correct partial start
        if (postfix.partialStarts.contains(i)) {
          partialProjections.push(math.max(nbItemAdded - 1, 0)) // max important to avoid -1
          partialAddedSinceLastZero +=1
        }
      }
      // If sequence is useful
      if (nbItemAdded > 1) {
        val resSequence = curPostfix.result()
        // Check if larger than current lenSeqMax
        if (resSequence.length > lenSeqMax) lenSeqMax = resSequence.length
        // Append and continue
        preprocessedSequence += resSequence
        // Append partial projection
        val partialProj = new ReversibleArrayStack[Set[Int]](solver, 20) // The 20 is size
        partialProj.push(partialProjections.toSet)
        newPartialProjection += partialProj
        // Append pos lists
        lastItemPosInSeq(0) = nbItemAdded
        firstItemPosInSid += firstItemPosInSeq
        lastItemPosInSid += lastItemPosInSeq
      }
    }
    (preprocessedSequence.result(), newPartialProjection.result(),
      firstItemPosInSid.result(), lastItemPosInSid.result(), shouldUseSingleItemPPIC)
  }

  /**
   * Create the constraint variables (aka, the value
   * each item of a prefix can take for each position)
   * needed to define the search space.
   *
   * @param supportedItemCounter
   * @return A Array of constraint variables
   */
  def initCPVariables(supportedItemCounter: Array[ReversibleInt]): Array[CPIntVar] = {

    // Create item List
    val listOfitem = new scala.collection.mutable.Stack[Int]
    for(i <- supportedItemCounter.indices) {
      if (supportedItemCounter(i).value >= minSup) listOfitem.push(i)
    }

    // Create list of CPIntVar
    val CPVariables = new Array[CPIntVar](lenSeqMax)
    for (i <- Range(0, minPatternLength)) { // Before minpatlength -> No epsilon
      CPVariables(i) = CPIntVar.sparse(listOfitem) // Item that cannot be epsilon (0)
    }
    listOfitem.push(-1) // Add epsilon as a possibility
    for (i <- Range(math.max(0, minPatternLength), lenSeqMax)) {
      CPVariables(i) = CPIntVar.sparse(listOfitem) // Item that can be epsilon
    }

    // Return
    CPVariables
  }

  /**
   * Enforce the item constraints through a GCC constraint
   * @param itemConstraints The item constraints to enforce
   */
  def enforceItemConstraints(itemConstraints: Array[(Int, String, Int)],
                             CPVariables : Array[CPIntVar]): CPOutcome = {

    // Recalculate max Pattern Length
    val recalculatedMPL = {
      if (maxPatternLength == 0) lenSeqMax
      else maxPatternLength
    }
    val valueOccurence = collection.mutable.ArrayBuilder.make[(Int, CPIntVar)]

    // Fill valueOccurence array
    for ((itemName: Int, operator: String, count: Int) <- itemConstraints) {

      if (! translationMap.contains(itemName)) {
        if (count > 0 && operator.matches("^(>=|==|>|=)$")) {
          return Failure // Impossible to satisfy, since item missing
        }
        else if (count == 0 && operator.matches("^(!=|>|<)$")) {
          return Failure // Impossible to satisfy, item missing + nonsense (< 0 item)
        }
        else if (count < 0 && operator.matches("^(<=|==|<|=)$")) {
          return Failure // Impossible to satisfy, received nonsense
        }
        // Else continue iter : Constraint is already enforced
      }
      else {
        val translatedName = translationMap.get(itemName).get

        operator match {
          case "==" | "=" =>
            valueOccurence += ((translatedName, CPIntVar(count)))
          case "<=" =>
            valueOccurence += ((translatedName, CPIntVar(0 to count)))
          case ">=" =>
            if (count > recalculatedMPL) return Failure
            valueOccurence += ((translatedName, CPIntVar(count to recalculatedMPL)))
          case "<" =>
            valueOccurence += ((translatedName, CPIntVar(0 until count)))
          case ">" =>
            if (count + 1 > recalculatedMPL) return Failure
            valueOccurence += ((translatedName, CPIntVar((count + 1) to recalculatedMPL)))
          case "!=" =>
            if (count > 0 && count < recalculatedMPL) {
              valueOccurence += ((translatedName, CPIntVar((0 until count) ++
                ((count + 1) to recalculatedMPL))))
            }
            else if (count == 0) {
              if (recalculatedMPL == 0) return Failure
              valueOccurence += ((translatedName, CPIntVar((count + 1) to recalculatedMPL)))
            }
            else if (count == recalculatedMPL) {
              if (recalculatedMPL - 1 < 0) return Failure
              valueOccurence += ((translatedName, CPIntVar(0 until recalculatedMPL)))
            }
          case _ =>
            require(false, s"Illegal operator in itemConstraints. Received $operator.")
        }
      }
    }
    // Get resulting array
    val resultingInput = valueOccurence.result()

    // Add GCC constraint if necessary
    if (resultingInput.isEmpty) Success
    else {
      try {
        this.solver.add(gcc(CPVariables, valueOccurence.result()), Strong)
      } catch {
        case noSol: oscar.cp.core.NoSolutionException => Failure
        case e: Exception => throw e
      }
    }
  }

  def run(postfixes: Array[Sequence]): Iterator[(Array[Int], Long)] = {

    // If nothing to find, nothing to search
    if (maxPatternLength < 0) return Iterator()
    if (maxItemPerItemset > 0 && spaceRemainingInCurrentItem < 0) return Iterator()

    // Init class variables
    separator = 0
    epsilon = -1
    lenSeqMax = 0
    itemSupportCounter = scala.collection.mutable.Map[Int, Int]()
    // Init translation maps
    translationMap = collection.mutable.Map[Int, Int]()
    translationMapReverse = collection.mutable.Map[Int, Int]()
    translationMapReverse.put(0, 0)

    // INIT sdb
    val preprocessed = preProcessPostfixes(postfixes)
    val sdb = preprocessed._1
    val newPartialProjection = preprocessed._2
    val firstPosList = preprocessed._3
    val lastPosList = preprocessed._4
    val shouldUseSingleItemPPIC = preprocessed._5

    // IF we only have epsilon and separator, no need to search
    if(sdb.length < minSup || lenSeqMax < minPatternLength) return Iterator()

    // IF should switch to single Item PPIC, see if worth it
    if (shouldUseSingleItemPPIC &&
      ((lenSeqMax > 5 && nbSequences > 10000) || (lenSeqMax > 15 && nbSequences > 1000))) {
      // IF Those conditions are satisfied, switching to PPIC is worth it
      // Execution is restarted from nearly the beginning
      // (only frequent items and translation are kept)
      val localPrefixSpan = new PPICRunner(minSup, minPatternLength, maxPatternLength,
        itemConstraints, bannedItem)

      return localPrefixSpan.switch(sdb, itemSupportCounter, translationMap, translationMapReverse)
    }

    val itemSet = translationMapReverse.keySet
    val itemSupport = Array.tabulate(itemSet.size)(i => i).map(i =>
      new ReversibleInt(solver, itemSupportCounter.getOrElse(translationMapReverse.get(i).get, 0)))

    // Init CPvariables
    val CPVariables = initCPVariables(itemSupport)

    // Enforce min/max pattern length
    val amongItem = (itemSet -- Set(separator)).toSet // separator and epsion == not item
    try {
      if (maxPatternLength > 0) add(atMost(maxPatternLength, CPVariables, amongItem))
      if (minPatternLength > 1) add(atLeast(minPatternLength, CPVariables, amongItem))
    } catch {
      case noSol: oscar.cp.core.NoSolutionException => return Iterator()
      case e: Exception => throw e
    }

    // Init items constraints
    if (enforceItemConstraints(itemConstraints, CPVariables) == Failure) {
      // No matter what, a solution cannot be found, abort
      return Iterator()
    }

    // Get last item in prefix, doesn't need to be translated to work, we don't check the value
    // only use their count
    val lastPrefixItemElems = getLastItemFromPrefix()
    // Get space remaining in current itemset
    val spaceRemaining = new ReversibleInt(solver, spaceRemainingInCurrentItem)

    // PRINT
    /*
    println(itemSet)
    println("Prefix")
    println(prefix.mkString(","))
    println("Postfixes")
    postfixes.foreach(x => {x.items.foreach(x=> {print(x); print(" ")}); println()})
    println("Original partial")
    postfixes.foreach(x => {x.partialStarts.foreach(x=> {print(x); print(" ")}); println()})
    println("sdb")
    sdb.foreach(x => {x.foreach(x=> {print(x); print(" ")}); println()})
    println("new partial")
    newPartialProjection.foreach(x => {x.top.foreach(x=> {print(x); print(" ")}); println()})
    println("support")
    println(itemSet.mkString(",") + "  |  " + itemSupport.mkString(","))
    println("firstItemPosInSid")
    firstPosList.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("lastItemPosInSid")
    lastPosList.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("itemSupportCounter")
    for(elem <- itemSet){
      println(elem + " : " + itemSupportCounter.getOrElse(elem, 0))
    }
    println("Variables")
    println("LenSeqMax : " + lenSeqMax)
    println("MinSup : " + minSup)
    println("Pattern Length : " + maxPatternLength + " || " + minPatternLength)
    println("MaxItemPerItemset : " + maxItemPerItemset + " || " + spaceRemainingInCurrentItem)
    println("cp var")
    println(CPVariables.mkString(" "))
    println()
    */

    // RUN
    val solutions = scala.collection.mutable.ArrayBuffer.empty[(Array[Int], Long)]
    val c = new MultiItemPPIC(CPVariables, sdb, firstPosList, lastPosList, newPartialProjection,
      itemSupport, lastPrefixItemElems, spaceRemaining, maxItemPerItemset, minSup)
    try {
      add(c)
    } catch {
      case noSol: oscar.cp.core.NoSolutionException => return Iterator()
      case e: Exception => throw e
    }

    this.solver.onSolution {
      val curSol = scala.collection.mutable.ArrayBuffer.empty[Int]
      CPVariables.foreach(x => {
        if (x.value != epsilon) {
          curSol += translationMapReverse.get(x.value).get
        }
      })
      solutions += ((curSol.toArray, c.curPrefixSupport))
    }


    this.solver.search(binaryStatic(CPVariables))
    this.solver.start()
    solutions.toIterator
  }
}

class MultiItemPPIC(val P: Array[CPIntVar],
                    val SDB: Array[Array[Int]],
                    val firstPosList : Array[Array[Int]],
                    val lastPosList : Array[Array[Int]],
                    val partialProjection: Array[ReversibleArrayStack[Set[Int]]],
                    val itemSupportCounter: Array[ReversibleInt],
                    val prefixOfLastItem: Array[Int],
                    val spaceRemainingInCurrentItem: ReversibleInt,
                    val maxItemPerItemset: Int,
                    val minsup : Long)
  extends Constraint(P(0).store, "PPIC-SPARK") {

  // Define separator
  val separator = 0
  val epsilon = -1

  // Support for current prefix
  var curPrefixSupport : Int = 0

  // current position in P $P_i = P[curPosInP.value]$
  private[this] val curPosInP = new ReversibleInt(s, 0)
  // Array with start position in each sequence
  private[this] val posList = Array.fill[ReversibleInt](SDB.length)(new ReversibleInt(s, 0))
  // Map containing unsupported elements
  private[this] val itemSupportedByThisSequence = collection.mutable.Map[Int, Int]()

  // DB size
  private[this] val lenSDB = SDB.size
  // Init psdb
  // representation of pseudo-projected-database
  private[this] var innerTrailSize = lenSDB * 5
  private[this] var psdb = Array.tabulate(innerTrailSize)(i => if (i < lenSDB) i else -1)
  // Init position in psdb and psdb total size
  private[this] val psdbStart = new ReversibleInt(s, 0)
  private[this] val psdbSize = new ReversibleInt(s, lenSDB) // current position in trail

  // when psdb is full, this method allows to double it's size.
  @inline private def growInnerTrail(): Unit = {
    val newPsdb = Array.fill[Int](innerTrailSize*2)(-1)
    System.arraycopy(psdb, 0, newPsdb, 0, innerTrailSize)
    psdb = newPsdb
    innerTrailSize *= 2
  }

  /**
   * Entry in constraint, function for all init
   *
   * @param l
   * @return The outcome of the first propagation and consistency check
   */
  final override def setup(l: CPPropagStrength): CPOutcome = {
    if (maxItemPerItemset > 0 && spaceRemainingInCurrentItem.value == 0 && P.length > 0) {
      P(0).assign(separator)
    }
    if (propagate() == Failure) Failure
    else {
      var i = P.length
      while (i > 0) {
        i -= 1
        P(i).callPropagateWhenBind(this)
      }
      Suspend
    }
  }

  /**
   * propagate
   * @return the outcome i.e. Failure, Success or Suspend
   */
  final override def propagate(): CPOutcome = {
    var v = curPosInP.value
    // println("START : " + P.mkString(","))

    // IF v > P.length, check is sequence is correct
    if (v >= P.length) {
      if (P(P.length-1).isBoundTo(separator) || P(P.length-1).isBoundTo(epsilon)) {
        return Success
      }
      else return Failure
    }

    // A valid postfix always finishes by a 0
    // And contain at least one, non zero, elem
    if (P(v).isBoundTo(epsilon)) {
      // println("EPSILON : " + P.mkString(","))
      if (v-1 <= 0) return Failure
      if (!P(v-1).isBoundTo(separator)) return Failure
      else {
        if (enforceEpsilonFrom(v) == Failure) return Failure
        // println("END : " + P.mkString(","))
        return Success
      }
    }

    if (v > 0 && P(v-1).min == epsilon) {
      return Failure
    }

    while (v < P.length && P(v).isBound && P(v).min != epsilon) {

      // Project prefix
      if (!project(v)) {
        return Failure
      }

      // Reset maxItemPerItemset
      if (P(v).value == separator) spaceRemainingInCurrentItem.setValue(maxItemPerItemset)
      else spaceRemainingInCurrentItem.decr() // decrement space remaining if different from 0

      // Clean next V
      if(v < P.length - 1) {
        // spaceRemainingInCurrentItem.decr() // decrement space remaining if different from 0
        if (maxItemPerItemset > 0 && spaceRemainingInCurrentItem.value == 0) {
          if (P(v + 1).assign(separator) == Failure) return Failure
          // If no more space, next value is a separator
        }
        else {
          // Remove unsupported item in next V
          for (value <- P(v + 1)) {
            if (value != separator && value != epsilon && itemSupportCounter(value).value < minsup)
            {
              if (P(v + 1).removeValue(value) == Failure) return Failure
            }
          }
        }
        // IF v != separator, v+1 != epsilon
        if (P(v).value != separator) {
          if (P(v + 1).removeValue(epsilon) == Failure) return Failure
        }
        // If v == separator, v+1 != separator
        else {
          if (P(v + 1).removeValue(separator) == Failure) return Failure
        }
      }

      // Search next item
      curPosInP.incr()
      v = curPosInP.value
      // println("AFTER : " + P.mkString(","))
    }
    Suspend
  }

  /**
   * when $P_i = epsilon$, then $P_i+1 = epsilon$
   * @param i current position in P
   */
  def enforceEpsilonFrom(i: Int): CPOutcome = {
    var j = i
    while (j < P.length) {
      if (P(j).assign(epsilon) == Failure) return Failure
      j += 1
    }
    return Success
  }

  def getElemOfP(posInPrefix: Int): Int = {
    if (posInPrefix >= 0) P(posInPrefix).value
    else if (prefixOfLastItem.length > -posInPrefix) {
      prefixOfLastItem(-(posInPrefix + prefixOfLastItem.length))
    }
    else 0
  }

  def checkElemOfP(posInPrefix: Int, currentItem: Int): Boolean = {
    if (posInPrefix >= 0) currentItem == P(posInPrefix).value
    else if (prefixOfLastItem.length < -(posInPrefix + prefixOfLastItem.length)) return false
    else currentItem == prefixOfLastItem(-(posInPrefix + prefixOfLastItem.length))
  }

  /**
   * Project a prefix and recalculate supportMap
   *
   * @param v, the position in P
   * @return true if prefix is supported, false otherwise
   */
  def project(v: Int): Boolean = {

    // Init var
    curPrefixSupport = 0
    val soughtItem = P(v).value
    val nbSupportForSoughtItem = itemSupportCounter(soughtItem).value

    // Find index to write new sequences + keep track of number of sequence added
    var writeIndex = psdbSize.value
    var nbAdded = 0
    // Clean itemSupportCounter, they need to be recalculated
    for (i <- itemSupportCounter.indices) itemSupportCounter(i).setValue(0)
    // Init stat index for searhc in psdb
    var sequenceIndexInPSDB = psdbStart.value

    // Start search
    while (sequenceIndexInPSDB < psdbSize.value) {
      // Init sequence index
      val sequenceIndex = psdb(sequenceIndexInPSDB)
      // println(sequenceIndexInPSDB + "  |  " + sequenceIndex)
      // Get partialprojections of that sequence
      val partialProj = partialProjection(sequenceIndex).top
      // Get current index for that sequence
      val index = posList(sequenceIndex)
      var i = index.value
      // Get cursequence
      val curSeq = SDB(sequenceIndex)
      // Get cur postlists
      val firstPos = firstPosList(sequenceIndex)
      val lastPos = lastPosList(sequenceIndex)

      // Project prefix
      if (i >= lastPos(soughtItem)) {
        // No need to look for that item in this sequence, it's not present
        i = curSeq.length
      }
      else if (soughtItem == separator) {
        // If we look for a separator, simply find the next one
        while (i < curSeq.length && curSeq(i) != separator) i += 1
        // Update partial Proj to empty set
        partialProjection(sequenceIndex).push(Set.empty[Int])
        // Update support map if necessary
        if (v + 1 < P.length) {
          for (item <- P(v + 1)) {
            if (item > 0 && lastPos(item) > i) {
              itemSupportCounter(item) += 1
            }
          }
        }
      }
      else if (checkElemOfP(v - 1, separator)) {
        // If last elem was a separator, find projection anywhere
        val newPartialProj = collection.mutable.Set.empty[Int]
        // Special case for first item
        if (i < firstPos(soughtItem)) i = firstPos(soughtItem) - 1
        else while (i < lastPos(soughtItem) && curSeq(i) != soughtItem) i += 1
        // Find all other items
        if (i < curSeq.length) {
          // Add partial proj to cur if necessary
          if (curSeq(i + 1) != separator) newPartialProj += i + 1
          var checker = i + 1
          var shouldUpdateItemSupport = true
          // Search partial projections
          while (checker < lastPos(soughtItem)) {
            if (shouldUpdateItemSupport) {
              if (curSeq(checker) == separator) shouldUpdateItemSupport = false
              else itemSupportedByThisSequence.update(curSeq(checker), 1)
            }
            if (curSeq(checker) == soughtItem && curSeq(checker + 1) != separator) {
              // Partial proj found, add it
              newPartialProj += checker + 1
              shouldUpdateItemSupport = true
            }
            checker += 1
          }
          // Add to itemSupported by sequence until end of cur item
          while (curSeq(checker) != separator) {
            itemSupportedByThisSequence.update(curSeq(checker), 1)
            checker += 1
          }
          // Update support map
          for (item <- itemSupportedByThisSequence.keys) {
            itemSupportCounter(item) += 1
          }
          itemSupportedByThisSequence.clear()
        }
        partialProjection(sequenceIndex).push(newPartialProj.toSet)
        // Don't update item support
      }
      else {
        // Else, search only partial projections
        i = -1
        var supported = false
        val newPartialProj = collection.mutable.Set.empty[Int]
        for (position <- partialProj) {
          var checker = position
          // Find searched item
          while (checker < lastPos(soughtItem) &&
            curSeq(checker) != separator &&
            curSeq(checker) != soughtItem) checker += 1

          // If found sequence support
          if (curSeq(checker) == soughtItem) {
            supported = true
            if (i == -1) i = checker // Update i
            else i = math.min(checker, i) // Update i
            // If found and extensible, add to new partial proj.
            if (curSeq(checker + 1) != separator) {
              checker += 1
              newPartialProj += (checker)
              // Update support map
              while (curSeq(checker) != separator) {
                itemSupportedByThisSequence.update(curSeq(checker), 1)
                checker += 1
              }
            }
          }
        }
        // Update support map
        for (item <- itemSupportedByThisSequence.keys) {
          itemSupportCounter(item) += 1
        }
        itemSupportedByThisSequence.clear()
        // Update partial proj
        partialProjection(sequenceIndex).push(newPartialProj.toSet)
        // IF not supported, put i to end of sequence
        if (!supported) i = curSeq.length
        // Don't update item support
      }

      // Update start position in sequence
      if (i > curSeq.length) {
        index.setValue(i)
      }
      else {
        // Supported
        i += 1
        index.setValue(i)
        curPrefixSupport += 1
        // Write link to this seq in psdb if necessary
        if (i < curSeq.length) {
          if (writeIndex >= innerTrailSize) growInnerTrail()
          psdb(writeIndex) = sequenceIndex
          writeIndex += 1
          nbAdded += 1
        }
      }
      // Next iter
      sequenceIndexInPSDB += 1
    }
    // Change psdb indexes for next iter
    psdbStart.setValue(psdbSize.value)
    psdbSize.setValue(writeIndex)
    // Item support for 0 == number of item added
    itemSupportCounter(0).setValue(nbAdded)
    // Debug prints
    // Return result
    if (curPrefixSupport >= minsup) return true
    else false
  }
}