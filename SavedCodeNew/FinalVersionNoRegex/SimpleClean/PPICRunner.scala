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

import oscar.algo.reversible.ReversibleInt
import oscar.cp._
import oscar.cp.CPIntVar
import oscar.cp.constraints.GCC
import oscar.cp.core._
import oscar.cp.core.CPOutcome._

import org.apache.spark.internal.Logging
import org.apache.spark.mllib.fpm.PrefixSpan.Postfix

/**
 * Calculate all patterns of a projected database in local mode.
 * PPIC can only be used when each itemSet contains at most one item inside it.
 * If the conditions are respected, it is generally much faster than the localPrefixSpan algorithm
 *
 * @param minSup minimal support for a frequent pattern
 * @param minPatternLength min pattern length for a frequent pattern
 * @param maxPatternLength max pattern length for a frequent pattern
 */
private[fpm] class PPICRunner(val minSup: Long,
                              val minPatternLength: Int,
                              val maxPatternLength: Int,
                              val itemConstraints: Array[(Int, String, Int)],
                              val bannedItem: Array[Int])
  extends CPModel with App with Logging with Serializable{

  // To know which item are supported
  var supportedOriginalItem = collection.mutable.Map[Int, Int]()
  // One to one translation map
  var translationMap = collection.mutable.Map[Int, Int]()
  var translationMapReverse = collection.mutable.Map[Int, Int]()
  // Support for each value
  var supportedItemCounter = scala.collection.mutable.ArrayBuilder.make[Int]
  var firstItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
  var lastItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
  // Variables
  var lenSeqMax = 0
  var numItems = 0
  var epsilon = 0
  var nbSequences = 0

  /**
   * This function find the frequency of each item in the postfixes.
   * Storing them in the postfixSupport map, so that un-frequent
   * items can be cleaned later.
   *
   * It also check whether the input is valid or not,
   * throwing an IllegalArgumentException if it isn't
   *
   * @param postfixes The sequences to clean
   * @return The inputed postfixes
   */
  def findFrequentItems(postfixes: Array[Postfix]): Unit = {

    supportedOriginalItem = collection.mutable.Map[Int, Int]()
    val itemSupportedByThisSequence = collection.mutable.Map[Int, Boolean]()
    var numberOfItemPerItemSetCounter = 0

    for (postfix <- postfixes) {
      // Find frequent items in the sequence (/!\ skip first item /!\)
      for (i <- Range(1, postfix.items.length)) {
        val x = postfix.items(i)
        if (x != epsilon) {
          // And item to the supported items
          if (!itemSupportedByThisSequence.contains(x)) {
            itemSupportedByThisSequence.put(x, true)
          }
          numberOfItemPerItemSetCounter += 1
        }
        else {
          // Check if PPIC can still be used
          if (numberOfItemPerItemSetCounter > 1) {
            // PPIC cannot be used
            throw new IllegalArgumentException(
              "Among the inputted postfixes, some ItemSet contain more than one item")
          }
          numberOfItemPerItemSetCounter = 0
        }
      }
      // Store frequent item of current sequence
      itemSupportedByThisSequence.keys.foreach(x =>
        supportedOriginalItem.update(x, supportedOriginalItem.getOrElse(x, 0) + 1)
      )
      // Clean Map for next iter (Avoid additional garbage collection)
      itemSupportedByThisSequence.clear()
      numberOfItemPerItemSetCounter = 0
    }
    // Filter item to keep only frequent ones
    supportedOriginalItem = supportedOriginalItem.filter(
      kv => kv._2 >= minSup && !bannedItem.contains(kv._1))
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
    // Save number of support for that item
    supportedItemCounter += supportedOriginalItem.getOrElse(value, 0)
    // Return the new representation
    numItems
  }

  /**
   * Clean a sequence to remove un-frequent item
   * (0 being un-frequent by default). Items are
   * also renamed to be conveniently used with arrays
   *
   * Example :
   * 0 89 0 104 0 104 0 72
   * 0 89 0 104
   *
   * Becomes :
   * 1 2 2
   * 1 2
   *
   * @param postfix : A sequence
   * @return The sequence cleaned from un-frequent items
   */
  def preProcessArrayToSDB(postfix: Postfix): Option[Array[Int]] = {

    // Init
    var isFirstItem = true
    val numberOfSupportedItem = supportedOriginalItem.size + 1
    val firstItemPosInSeq = Array.fill(numberOfSupportedItem)(0)
    val lastItemPosInSeq = Array.fill(numberOfSupportedItem)(0)
    var nbElemAdded = 0
    // Filter items to clean sequence
    val cleanedSequence = postfix.items.flatMap(x => {
      if (isFirstItem) {
        // Ignore first Item, it's already part of the prefixes
        isFirstItem = false
        None
      }
      else if (supportedOriginalItem.contains(x)) {
        // Item supported => Get representation (creating new repr if necessary)
        val trans = translationMap.getOrElseUpdate(x, updateTranslationMap(x))
        // Update last pos found in current sequence for current item
        nbElemAdded += 1
        lastItemPosInSeq(trans) = nbElemAdded
        // If necessary, update first pos in current sequence for current item
        if (firstItemPosInSeq(trans) == 0) {
          firstItemPosInSeq(trans) = nbElemAdded
        }
        Some(trans)
      }
      else None // Item no supported
    })

    // Return resulting sequence if non empty
    if (cleanedSequence.length > 0) {
      // Update lenSeqMax if necessary
      if (cleanedSequence.length > lenSeqMax) lenSeqMax = cleanedSequence.length
      // Update first/last pos list
      firstItemPosInSid += firstItemPosInSeq
      lastItemPosInSid += lastItemPosInSeq
      // Return cleaned sequence
      Some(cleanedSequence)
    }
    else None // Omit sequence
  }

  /**
   * Build a matrix whose cell contain the next last position of an item,
   * Allowing O(1) jump to the next interesting position and producing
   * an important speed-up !
   *
   * @param lastPosOfItem
   *
   * LAST POS SID
   * 0 3 7 5 6
   * 0 2 0 3 4
   *
   * @return
   *
   * LAST POS DB
   * 3 3 5 5 6 7 0
   * 2 3 4 0
   *
   * /!\ 0 only to indicate ends of seq /!\
   *
   */
  def createSdbPosList(lastPosOfItem : Array[Array[Int]]): Array[Array[Int]] = {

    // Build last pos matrix
    val result = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
    for(posList <- lastPosOfItem) {
      // Init
      // Filter out one and zero from sequence, then sort result
      val sortedPosList = posList.filter(_ > 1).sorted
      var i = 0 // Indice for next last pos to add
      var j = 0 // Position in sequence
      // Generate sequence
      val resultLine =
      if (sortedPosList.isEmpty) Array(0)
      else Array.ofDim[Int](sortedPosList.last)
      while (i < sortedPosList.length) {
        if (j + 1 < sortedPosList(i)) {
          // Add position of next last pos to list
          resultLine(j) = sortedPosList(i)
          j += 1
        }
        else i += 1
      }
      // Finish line with a 0 for termination
      resultLine(j) = 0
      // Append line
      result += resultLine
    }

    // Return resulting last pos List
    result.result()
  }

  /**
   * Create the constraint variables (aka, the value
   * each item of a prefix can take for each position)
   * needed to define the search space.
   *
   * @param supportedItemCounter
   * @return A Array of constraint variables
   */
  def initCPVariables(supportedItemCounter: Array[Int]): Array[CPIntVar] = {

    // Create item List
    val listOfitem = new scala.collection.mutable.Stack[Int]
    for(i <- supportedItemCounter.indices) {
      if (supportedItemCounter(i) >= minSup) listOfitem.push(i)
    }

    // Recalculate max Pattern Length
    val recalculatedMaxPatternLength = {
      if (maxPatternLength == 0) lenSeqMax
      else maxPatternLength
    }

    // Create list of CPIntVar
    val CPVariables = new Array[CPIntVar](recalculatedMaxPatternLength)
    for (i <- Range(0, minPatternLength)) {
      CPVariables(i) = CPIntVar.sparse(listOfitem) // Item that cannot be epsilon (0)
    }
    listOfitem.push(0) // Add epsilon as a possibility
    for (i <- Range(math.max(0, minPatternLength), recalculatedMaxPatternLength)) {
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
            valueOccurence += ((translatedName, CPIntVar(0  to (count - 1))))
          case ">" =>
            if (count + 1 > recalculatedMPL) return Failure
            valueOccurence += ((translatedName, CPIntVar((count + 1) to recalculatedMPL)))
          case "!=" =>
            if (count > 0 && count < recalculatedMPL) {
              valueOccurence += ((translatedName, CPIntVar((0 to (count - 1)) ++
                ((count + 1) to recalculatedMPL))))
            }
            else if (count == 0) {
              if (recalculatedMPL == 0) return Failure
              valueOccurence += ((translatedName, CPIntVar((count + 1) to recalculatedMPL)))
            }
            else if (count == recalculatedMPL) {
              if (recalculatedMPL - 1 < 0) return Failure
              valueOccurence += ((translatedName, CPIntVar(0 to (recalculatedMPL -1))))
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

  /**
   * Find the complete set of frequent sequential patterns in the input sequences.
   *
   * @param postfixes: An array of postfixes such that each ItemSet contains at most one item.
   *                 If this condition is not respected, an exception will be thrown.
   *
   * @return frequent patterns
   */
  def run(postfixes: Array[Postfix]): Iterator[(Array[Int], Long)] = {

    // Init translation maps
    translationMap = collection.mutable.Map[Int, Int]()
    translationMapReverse = collection.mutable.Map[Int, Int]()
    // Init support counter
    supportedItemCounter = scala.collection.mutable.ArrayBuilder.make[Int]
    supportedItemCounter += 0 // Add support for epsilon item
    // Init first and last pos list
    firstItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]
    lastItemPosInSid = scala.collection.mutable.ArrayBuilder.make[Array[Int]]

    // Clean postfixes, translate items, check if input is correct and
    // Create first / last pos list
    findFrequentItems(postfixes)
    val sdb: Array[Array[Int]] = postfixes.flatMap(x => preProcessArrayToSDB(x))

    // Check if a solution can be outputted
    if(lenSeqMax == 0 || lenSeqMax < minPatternLength ||
      (maxPatternLength > 0 && maxPatternLength < minPatternLength)) {
      // No matter what, a solution cannot be found, abort
      return Iterator()
    }
    numItems += 1
    nbSequences = sdb.length

    // Extract final version of pos lists
    val firstPosOfItem = firstItemPosInSid.result()
    val lastPosOfItem = lastItemPosInSid.result()

    // Init constraint variables
    val itemsSupport = supportedItemCounter.result()
    val CPVariables = initCPVariables(itemsSupport)

    // Init items constraints
    if (enforceItemConstraints(itemConstraints, CPVariables) == Failure) {
      // No matter what, a solution cannot be found, abort
      return Iterator()
    }

    // Init SDB pos matrix
    val sdbPosList = createSdbPosList(lastPosOfItem)

    // PRINT
    /*
    println("")
    println("Postfixes")
    postfixes.foreach(x => {x.items.foreach(x=> {print(x); print(" ")}); println()})
    println("Variables")
    println(lenSeqMax)
    println(numItems)
    CPVariables.foreach(print)
    println()
    println("sdb")
    sdb.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("sdbLastPos")
    sdbPosList.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("supportCounter")
    supportedItemCounter.result().foreach(x=> {print(x); print(" ")})
    println()
    println("firstItemPosInSid")
    firstItemPosInSid.result().foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("lastItemPosInSid")
    lastItemPosInSid.result().foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("MaxPatternLength ", maxPatternLength)
    println("MinPatternLength ", minPatternLength)
    println("RUN STOP")
    println()
    */

    // RUN
    val solutions = scala.collection.mutable.ArrayBuffer.empty[(Array[Int], Long)]
    val c = new PPIC(CPVariables, sdb, sdbPosList,
      firstPosOfItem, lastPosOfItem, itemsSupport, minSup, numItems)

    // In case no sol returned for inputs, catch NoSolutionException
    try {
      add(c)
    } catch {
      case noSol: oscar.cp.core.NoSolutionException => return Iterator()
      case e: Exception => throw e
    }

    // What to do with a solution
    this.solver.onSolution {
      val curSol = scala.collection.mutable.ArrayBuffer.empty[Int]
      CPVariables.foreach(x => {
        if (x.value != epsilon) {
          curSol += 0
          curSol += translationMapReverse.getOrElse(x.value, -1)
        }
      })
      curSol += 0
      solutions += ((curSol.toArray, c.curPrefixSupport))
    }

    // Search strategy
    this.solver.search(binaryStatic(CPVariables))
    // Start solver
    this.solver.start()

    solutions.toIterator
  }
}

/**
 * PPIC [Constraint Programming & Sequential Pattern Mining with Prefix projection method]
 * is the CP version of Prefix projection method of Sequential Pattern Mining
 * (with several improvements) which is based on projected database
 * (We use here pseudo-projected-database \{(sid, pos) \}).
 *
 * This constraint generate all available solution given such parameters
 *
 * @param P, is pattern where $P_i$ is the item in position $i$ in $P$
 * @param SDB, [sequence database] it is a set of sequences.
 *           Each line $SDB_i$ or $t_i$ represent a sequence
 *           s1 abcbc
 *           s2 babc
 *           s3 ab
 *           s4 bcd
 *
 * @param firstPosOfItem is the first real position of an item (a) in a sequence (s1),
 *                      if 0 it is not present
 *
 * @param lastPosOfItem is the last real position of an item (a) in a sequence (s1),
 *                      if 0 it is not present
 *
 *                           a   b   c   d
 *                       s1  1   4   5   0
 *                       s1  2   3   4   0
 *                       s1  1   2   0   0
 *                       s1  0   1   2   3
 *
 * @param itemsSupport is the initial support (number of sequences where an
 *                     item appeared) of all items a : 3, b : 4, c : 3, d : 1
 * @param minsup is a threshold support, item must appear
 *               in at least minsup sequences $support(item)>=minsup$
 * @param nItems is the number of items in SDB
 *
 * @author John Aoga (johnaoga@gmail.com) and Pierre Schaus (pschaus@gmail.com)
 */
class PPIC(val P: Array[CPIntVar],
           val SDB: Array[Array[Int]],
           val SDBlastPos: Array[Array[Int]],
           val firstPosOfItem: Array[Array[Int]],
           val lastPosOfItem : Array[Array[Int]],
           val itemsSupport : Array[Int],
           val minsup : Long,
           val nItems : Int)
  extends Constraint(P(0).store, "PPIC") {

  idempotent = true

  private[this] val epsilon = 0
  // this is for empty item
  private[this] val lenSDB = SDB.size
  private[this] val patternSeq = P.clone()
  private[this] val lenPatternSeq = P.length

  // representation of pseudo-projected-database
  private[this] var innerTrailSize = lenSDB * 5
  private[this] var psdbSeqId = Array.tabulate(innerTrailSize)(i => i)
  // the Num of Sequence (sid)
  private[this] var psdbPosInSeq = Array.tabulate(innerTrailSize)(i => -1)
  // position of prefix in this sid
  private[this] val psdbStart = new ReversibleInt(s, 0)
  // current size of trail
  private[this] val psdbSize = new ReversibleInt(s, lenSDB) // current position in trail

  // when InnerTrail is full, it allows to double size of trail
  @inline private def growInnerTrail(): Unit = {
    val newPsdbSeqId = new Array[Int](innerTrailSize * 2)
    val newPsdbPosInSeq = new Array[Int](innerTrailSize * 2)
    System.arraycopy(psdbSeqId, 0, newPsdbSeqId, 0, innerTrailSize)
    System.arraycopy(psdbPosInSeq, 0, newPsdbPosInSeq, 0, innerTrailSize)
    psdbSeqId = newPsdbSeqId
    psdbPosInSeq = newPsdbPosInSeq
    innerTrailSize *= 2
  }

  // support counter contain support for each item, it is reversible for efficient backtrack
  private[this] var supportCounter = itemsSupport
  var curPrefixSupport: Int = 0

  // current position in P $P_i = P[curPosInP.value]$
  private[this] val curPosInP = new ReversibleInt(s, 0)

  // check if pruning is done successfully
  private[this] var pruneSuccess = true

  /**
   * Entry in constraint, function for all init
   *
   * @param l
   * @return The outcome of the first propagation and consistency check
   */
  final override def setup(l: CPPropagStrength): CPOutcome = {
    if (propagate() == Failure) Failure
    else {
      var i = patternSeq.length
      while (i > 0) {
        i -= 1
        patternSeq(i).callPropagateWhenBind(this)
      }
      Suspend
    }
  }

  /**
   * propagate
   *
   * @return the outcome i.e. Failure, Success or Suspend
   */
  final override def propagate(): CPOutcome = {
    var v = curPosInP.value

    if (P(v).isBoundTo(epsilon)) {
      if (v == 0) return Failure
      if (!P(v - 1).isBoundTo(epsilon)) {
        enforceEpsilonFrom(v)
      }
      return Success
    }

    while (v < P.length && P(v).isBound && P(v).min != epsilon) {

      if (!filterPrefixProjection(P(v).getMin)) return Failure
      curPosInP.incr()
      v = curPosInP.value
    }

    if (v > 0 && v < P.length && P(v).isBoundTo(epsilon)) {
      enforceEpsilonFrom(v)
    }
    Suspend
  }


  /**
   * when $P_i = epsilon$, then $P_i+1 = epsilon$
   *
   * @param i current position in P
   */
  def enforceEpsilonFrom(i: Int): Unit = {
    var j = i
    while (j < lenPatternSeq) {
      P(j).assign(epsilon)
      j += 1
    }
  }

  /**
   * P[curPosInP.value] has just been bound to "prefix"
   * all the indices before (< currPosInP) are already bound
   *
   * if prefix is not epsilon we can compute next pseudo-projected-database
   * with projectSDB function
   *
   * @param prefix
   * @return the Boolean is to say if current prefix is a solution or not
   */
  private def filterPrefixProjection(prefix: Int): Boolean = {
    val i = curPosInP.value + 1
    // println("filter prefix "+prefix+" at position "+i)
    if (i >= 2 && prefix == epsilon) {
      return true
    } else {

      ///
      val sup = projectSDB(prefix)

      if (sup < minsup) {

        return false

      } else {
        pruneSuccess = true
        // Prune next position pattern P domain if it exists unfrequent items
        prune(i)

        return pruneSuccess

      }
    }

  }

  // initialisation of domain
  val dom = Array.ofDim[Int](nItems)

  /**
   * pruning strategy
   *
   * @param i current position in P
   */
  private def prune(i: Int): Unit = {
    val j = i

    if (j >= lenPatternSeq) return

    var k = 0
    val len = P(j).fillArray(dom)
    // println( "-->"+dom.mkString("-")+" len = "+len)
    // print("removed = ")
    while (k < len) {

      val item = dom(k)

      if (item != epsilon && supportCounter(item) < minsup) {
        if (P(j).removeValue(item) == Failure) {
          pruneSuccess = false
          return
        }
        // print(item+", ")
      }

      k += 1
    }
    // println()
  }


  /**
   * Computing of next pseudo projected database
   *
   * @param prefix
   * @return
   */
  private def projectSDB(prefix: Int): Int = {
    val startInit = psdbStart.value
    val sizeInit = psdbSize.value

    // Count sequences validated for next step
    curPrefixSupport = 0

    // allow to predict failed sid (sequence) and remove it
    val nbAddedTarget = itemsSupport(prefix)

    // reset support to 0
    supportCounter = Array.fill[Int](nItems)(0)

    //
    var i = startInit
    var j = startInit + sizeInit
    var nbAdded = 0
    // println("startInit = "+startInit+" sizeInit = "+sizeInit)
    // Tias optim: nbAdded < nbAddedTarget
    // because we know how many need to be added so we can stop when this target is reached
    while (i < startInit + sizeInit && nbAdded < nbAddedTarget) {

      val sid = psdbSeqId(i)

      val ti = SDB(sid)
      val lti = ti.length
      val start = psdbPosInSeq(i)
      // println(i+" $$ sid = "+sid+" start = "+start)
      var pos = start

      if (lastPosOfItem(sid)(prefix) != 0) {
        // here we know at least that prefix is present in sequence sid

        // search for next value "prefix" in the sequence starting from
        if (lastPosOfItem(sid)(prefix) - 1 >= pos) {
          // we are sure prefix next position is available,
          // so we add the sequence in the new projected data base

          nbAdded += 1

          // find next position of prefix
          if (start == -1) {

            pos = firstPosOfItem(sid)(prefix) - 1

          } else {

            while (pos < lti && prefix != ti(pos)) {
              pos += 1
            }

          }

          // update pseudo projected database and support
          psdbSeqId(j) = sid
          psdbPosInSeq(j) = pos + 1
          j += 1
          if (j >= innerTrailSize) growInnerTrail()

          curPrefixSupport += 1

          // recompute support
          var break = false
          val tiLast = SDBlastPos(sid)
          // println("tsid = "+ti.mkString(",")+" pos = "+pos)
          // println("tlas = "+tiLast.mkString(","))

          while (!break && pos < lti) {
            val last = tiLast(pos)

            if (last == 0) {
              break = true
            } else {
              val item = ti(last - 1)
              supportCounter(item) += 1
              pos = last - 1
            }
          }
        }
      }
      i += 1
    }
    psdbStart.value = startInit + sizeInit
    psdbSize.value = curPrefixSupport
    return curPrefixSupport
  }
}