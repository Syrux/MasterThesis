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
 * @param isMultiItemPattern A boolean value that define whether running the algorithm
 *                                 on <(1,2) 3> should output (1,2) 3; 1 3; 2 3 or just the
 *                                 last two ...
 */
private[fpm] class PPICSpark( val prefix: Array[Int],
                              val minSup: Long,
                              val minPatternLength: Int,
                              val maxPatternLength: Int,
                              val isMultiItemPattern: Boolean)
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
  def preProcessPostfixes(postfixes: Array[Postfix]):
    (Array[Array[Int]], Array[ReversibleArrayStack[Set[Int]]],
      Array[Array[Int]], Array[Array[Int]]) = {

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
    itemSupportCounter = itemSupportCounter.retain((k, v) => v >= minSup)

    // Remove unsupported item
    for (postfix <- postfixes) {
      // Create SDB postfix
      var lastItemWasEpsilon = false
      var partialAddedSinceLastZero = false
      var nbItemAdded = 0
      val curPostfix = scala.collection.mutable.ArrayBuilder.make[Int]
      val partialProjections = scala.collection.mutable.Stack[Int]()
      val firstItemPosInSeq = Array.fill(itemSupportCounter.size)(0)
      val lastItemPosInSeq = Array.fill(itemSupportCounter.size)(0)

      for (i <- Range(1, postfix.items.length)) {
        val x = postfix.items(i)
        if (x == 0) {
          if (!lastItemWasEpsilon) {
            partialAddedSinceLastZero = false
            lastItemWasEpsilon = true
            curPostfix += x
            nbItemAdded += 1
          }
          else if (partialAddedSinceLastZero && partialProjections.size > 0) {
            // If item emptied, remove partial start
            partialProjections.pop()
          }
        }
        else if (itemSupportCounter.getOrElse(x, 0) >= minSup) {
          val trans = translationMap.getOrElseUpdate(x, updateTranslationMap(x))
          lastItemWasEpsilon = false
          nbItemAdded += 1
          curPostfix += trans
          // Update pos lists
          lastItemPosInSeq(trans) = nbItemAdded
          // If necessary, update first pos in current sequence for current item
          if (firstItemPosInSeq(trans) == 0) {
            firstItemPosInSeq(trans) = nbItemAdded
          }
        }
        // Correct partial start
        if (postfix.partialStarts.contains(i) && nbItemAdded > 0) {
          partialProjections.push(nbItemAdded - 1)
          partialAddedSinceLastZero = true
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
        val partialProj = new ReversibleArrayStack[Set[Int]](solver, 11)
        partialProj.push(partialProjections.toSet)
        newPartialProjection += partialProj
        // Append pos lists
        lastItemPosInSeq(0) = nbItemAdded
        firstItemPosInSid += firstItemPosInSeq
        lastItemPosInSid += lastItemPosInSeq
      }
    }
    (preprocessedSequence.result(), newPartialProjection.result(),
      firstItemPosInSid.result(), lastItemPosInSid.result())
  }

  def initCPVariables(maxPatternLength: Int,
                      itemSet : scala.collection.Set[Int],
                      isMultiItemPattern: Boolean):
    Array[CPIntVar] = {

    val nonZeroSet = itemSet -- Set(separator)
    val nonZeroEpsilonSet = nonZeroSet ++ Set(epsilon)
    val epsilonSet = itemSet ++ Set(epsilon)
    val specialValSet = Set(separator, epsilon)

    val maxLength = {
      if (!isMultiItemPattern && maxPatternLength < lenSeqMax) {
        math.min((maxPatternLength*2) + 1, lenSeqMax)
      }
      else lenSeqMax
    }

    // TODO : actual min pattern length calculation
    val minLength =
      if (!isMultiItemPattern) 3
      else 2

    val CPVariables = new Array[CPIntVar](maxLength)
    for (i <- CPVariables.indices) {
      CPVariables(i) = {
        if (isMultiItemPattern) {
          if (i < minLength) {
            CPIntVar.sparse(itemSet)
          }
          else CPIntVar.sparse(epsilonSet)
        }
        else {
          if (i % 2 == 0) {
            if (i < minLength) CPIntVar.apply(separator)
            else CPIntVar.sparse(specialValSet)
          }
          else if (i < minLength) CPIntVar.sparse(nonZeroSet)
          else CPIntVar.sparse(nonZeroEpsilonSet)
        }
      }
    }

    return CPVariables
  }

  def run(postfixes: Array[Postfix]): Iterator[(Array[Int], Long)] = {

    // If nothing to find, nothing to search
    if (maxPatternLength < 1) return Iterator()

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
    // IF we only have epsilon and separator, no need to search
    if(sdb.length < minSup) return Iterator()

    val itemSet = translationMapReverse.keySet

    // Init CPvariables
    val CPVariables = initCPVariables(maxPatternLength, itemSet, isMultiItemPattern)

    // Setup max pattern length
    val amongItem = (itemSet -- Set(separator)).toSet
    if (maxPatternLength <= math.floor(lenSeqMax/2)) {
      add(atMost(maxPatternLength, CPVariables, amongItem))
    }

    // Get last item in prefix, doesn't need to be translated to work, we don't check the value
    // only use their count
    val lastPrefixItemElems = getLastItemFromPrefix()

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
    println("cp var")
    println(CPVariables.mkString(" "))
    println()
    */

    // RUN

    val solutions = scala.collection.mutable.ArrayBuffer.empty[(Array[Int], Long)]
    val c = new sparkCP(CPVariables, sdb, newPartialProjection, lastPrefixItemElems, minSup,
      isMultiItemPattern, firstPosList, lastPosList)
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
          curSol += translationMapReverse.getOrElse(x.value, -1)
        }
      })
      solutions += ((curSol.toArray, c.curPrefixSupport))
    }


    this.solver.search(binaryStatic(CPVariables))
    this.solver.start()
    solutions.toIterator
  }
}

class sparkCP(val P: Array[CPIntVar],
              val SDB: Array[Array[Int]],
              val partialProjection: Array[ReversibleArrayStack[Set[Int]]],
              val prefixOfLastItem: Array[Int],
              val minsup : Long,
              val lookingForMultiItemPatterns : Boolean,
              val firstPosList : Array[Array[Int]],
              val lastPosList : Array[Array[Int]])
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
  private[this] val supportMap = scala.collection.mutable.Map.empty[Int, Int]

  /**
   * Entry in constraint, function for all init
   *
   * @param l
   * @return The outcome of the first propagation and consistency check
   */
  final override def setup(l: CPPropagStrength): CPOutcome = {
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
      if (v-1 <= 0) return Failure
      if (!P(v-1).isBoundTo(separator)) return Failure
      else {
        enforceEpsilonFrom(v)
        return Success
      }
    }

    if (v > 0 && P(v-1).min == epsilon) {
      return Failure
    }

    while (v < P.length && P(v).isBound && P(v).min != epsilon) {

      // Project prefix
      if (!project(v)) {
        // println("FAIL : " + P.mkString(","))
        // println()
        return Failure
      }
      // println("SUCCESS : " + P.mkString(","))
      // println()

      // Clean next V
      if(v < P.length - 1) {
        // Remove unsupported item in next V
        if (!supportMap.isEmpty) {
          for (value <- P(v + 1)) {
            if (value != separator &&
              value != epsilon &&
              supportMap.getOrElse(value, 0) < minsup) {

              if (P(v + 1).removeValue(value) == Failure) return Failure
            }
          }
          supportMap.clear()
        }
        // IF v != separator, v+1 != epsilon
        if (P(v).value != separator) {
          if (P(v + 1).removeValue(epsilon) == Failure) return Failure
        }
        // If v == separator, v+1 != separator
        else {
          if (v + 1 == P.length) return Success
          else {
            if (P(v + 1).removeValue(separator) == Failure) return Failure
          }
        }
      }

      // Search next item
      curPosInP.incr()
      v = curPosInP.value
    }
    Suspend
  }

  /**
   * when $P_i = epsilon$, then $P_i+1 = epsilon$
   * @param i current position in P
   */
  def enforceEpsilonFrom(i: Int): Unit = {
    var j = i
    while (j < P.length) {
      P(j).assign(epsilon)
      j += 1
    }
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

    // Check strictly increasing value in building item
    if (soughtItem != separator && soughtItem < getElemOfP(v-1)) return false

    // Start search
    for (sequenceIndex <- SDB.indices) {
      // Init
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
        // No need to look for that item, not present
        i = curSeq.length
      }
      else if (soughtItem == separator) {
        // If we look for a separator, simply find next one
        while (i < curSeq.length && curSeq(i) != separator) i += 1
        // Update partial Proj
        partialProjection(sequenceIndex).push(Set.empty[Int])
        // Update item support
        var checker = i + 1
        while (checker < curSeq.length) {
          itemSupportedByThisSequence.update(curSeq(checker), 1)
          checker += 1
        }
        // Update support map
        for (item <- itemSupportedByThisSequence.keys) {
          supportMap.update(item, supportMap.getOrElse(item, 0) + 1)
        }
        itemSupportedByThisSequence.clear()
      }
      else if (checkElemOfP(v - 1, separator)) {
        // If last elem was a separator, find projection anywhere
        val newPartialProj = collection.mutable.Set.empty[Int]
        // Special case for first item
        if (i < firstPos(soughtItem)) i = firstPos(soughtItem) - 1
        else while (i < lastPos(soughtItem) && curSeq(i) != soughtItem) i += 1
        // Find all other items
        if (i < curSeq.length && lookingForMultiItemPatterns) {
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
          // Update support map
          for (item <- itemSupportedByThisSequence.keys) {
            supportMap.update(item, supportMap.getOrElse(item, 0) + 1)
          }
          itemSupportedByThisSequence.clear()
        }
        partialProjection(sequenceIndex).push(newPartialProj.toSet)
        // Don't update item support
      }
      else {
        // Else, search only partial projections
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
          supportMap.update(item, supportMap.getOrElse(item, 0) + 1)
        }
        itemSupportedByThisSequence.clear()
        // Update partial proj
        partialProjection(sequenceIndex).push(newPartialProj.toSet)
        // IF not supported, put i to end of sequence
        if (!supported) i = curSeq.length
        // Don't update item support
      }

      // Update start position in sequence
      if (i >= curSeq.length) {
        index.setValue(i)
      }
      else {
        // Supported
        i += 1
        index.setValue(i)
        curPrefixSupport += 1
      }
    }
    // Return result
    if (curPrefixSupport >= minsup) return true
    else false
  }
}