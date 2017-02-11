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
                              val maxPatternLength: Int)
  extends CPModel with App with Logging with Serializable{

  // One to one translation map
  var postfixSupport = collection.mutable.Map[Int, Int]()
  var translationMap = collection.mutable.Map[Int, Int]()
  var translationMapReverse = collection.mutable.Map[Int, Int]()
  // Support for each value
  var itemSupportCounter = scala.collection.mutable.ArrayBuffer.empty[Int]
  var firstItemPosInSid: Array[Array[Int]] = Array(Array(0))
  var lastItemPosInSid: Array[Array[Int]] = Array(Array(0))
  // Variables
  var lenSeqMax = 0
  var numItems = 0
  var epsilon = 0
  var nbSequences = 0

  def preProcessPostfixes(postfixes: Array[Postfix]): Array[Array[Int]] = {

    val preprocessed = scala.collection.mutable.ArrayBuffer.empty[Array[Int]]
    postfixSupport = collection.mutable.Map[Int, Int]()
    val itemSupportedByThisSequence = collection.mutable.Map[Int, Boolean]()

    for (postfix <- postfixes) {
      var firstZeroEncoutered = false

      preprocessed.append(postfix.items.flatMap(x => {
        if (firstZeroEncoutered && x != epsilon) {
          if (!itemSupportedByThisSequence.contains(x)) {
            itemSupportedByThisSequence.put(x, true)
          }
          Some(x)
        }
        else if (x == epsilon) {
          firstZeroEncoutered = true
          None
        }
        else None
      }))

      itemSupportedByThisSequence.keys.foreach(x =>
        postfixSupport.update(x, postfixSupport.getOrElse(x, 0) + 1)
      )
      itemSupportedByThisSequence.clear()
    }

    preprocessed.toArray
  }

  def updateTranslationMap(value: Int): Int = {

    // Add new value in reverse map
    numItems += 1
    translationMapReverse.update(numItems, value)
    // Create new support counter
    itemSupportCounter += postfixSupport.getOrElseUpdate(value, 0)
    // Add value in translation map
    numItems
  }

  def preProcessArrayToSDB(array: Array[Int], index: Int): Array[Int] = {

    // Current index (+1 shift)
    var curIndex = 0
    // Filter zero items
    val res = array.flatMap(x => {
      if (postfixSupport.getOrElse(x, 0) >= minSup) {
        // Update cur index
        curIndex +=1
        // Get word translation
        val trans = translationMap.getOrElseUpdate(x, updateTranslationMap(x))
        Some(trans)
      }
      else None
    })
    // Compute lenSeqMax
    res
  }

  def createPosLists(sdb : Array[Array[Int]]): Array[Array[Int]] = {

    // Create result sdb
    val finalSdb = scala.collection.mutable.ArrayBuffer.empty[Array[Int]]
    // Parse old sdb, sequence by sequence
    for (i <- sdb.indices) {
      // Parse a sequence
      val currentSequence = scala.collection.mutable.ArrayBuffer.empty[Int]
      for (j <- sdb(i).indices) {
        // Current item
        val cur = sdb(i)(j)
        currentSequence.append(cur)
        // Update PosInSid lists and itemSupportCounter
        lastItemPosInSid(cur)(i) = currentSequence.length
        if (firstItemPosInSid(cur)(i) == 0) {
          firstItemPosInSid(cur)(i) = currentSequence.length
        }
      }
      if (currentSequence.length > 0) {
        if (currentSequence.length > lenSeqMax) lenSeqMax = currentSequence.length
        finalSdb.append(currentSequence.toArray)
      }
    }
    finalSdb.toArray
  }

  /**
   * Build a matrix whose content are the next last position of items,
   * this can take quite a bit of time to compute but, when usefull,
   * allows an effective speed up.
   *
   * @param lastPosOfItem
   *
   * LAST POS SID
   * 0 0
   * 3 2
   * 7 0
   * 5 3
   * 6 4
   *
   * @return
   *
   * LAST POS DB
   * 3 3 5 5 6 7 0
   * 2 3 4 0
   */
  def createSdbPosList(lastPosOfItem : Array[Array[Int]]): Array[Array[Int]] = {

    // Transpose lastPosOfItem list while filtering out 1 and 0,
    // then sort each line In increasing order
    val transposedBuilder = Array.fill(nbSequences)(scala.collection.mutable.ArrayBuffer.empty[Int])
    for (item <- lastPosOfItem) {
      var i = 0
      while (i < item.length) {
        if (item(i) > 1) transposedBuilder(i) +=  item(i)
        i += 1
      }
    }
    val transposedMatrix = transposedBuilder.map(_.toArray.sorted)

    // Build last pos matrix
    val result = scala.collection.mutable.ArrayBuffer.empty[Array[Int]]
    for(sequence <- transposedMatrix) {
      var i = 0 // Indice for next last pos to add
      var j = 1 // Position in sequence
      val resultLine = scala.collection.mutable.ArrayBuffer.empty[Int]
      while (i < sequence.length) {
        if (j < sequence(i)) {
          // Add position of next last pos to list
          resultLine += sequence(i)
          j += 1
        }
        else i += 1
      }
      // Finish line with a 0 for termination
      resultLine += 0
      // Append line
      result.append(resultLine.toArray)
    }

    // Return resulting last pos List
    result.toArray
  }

  def initCPVariables(): Array[CPIntVar] = {

    // Create and fill stack
    val listOfitem = new scala.collection.mutable.Stack[Int]
    for(i <- itemSupportCounter.indices) {
      if (itemSupportCounter(i) >= minSup) listOfitem.push(i)
    }
    // Put 0 elem
    listOfitem.push(0)

    // Create list of CPIntVar
    val CPVariables = Array.fill (
      math.min(lenSeqMax, maxPatternLength))(CPIntVar.sparse(listOfitem))
    listOfitem.pop()
    for (i <- 0 until minPatternLength)
      CPVariables(i) = CPIntVar.sparse(listOfitem)

    // Return
    CPVariables
  }

  def run(postfixes: Array[Postfix]): Iterator[(Array[Int], Long)] = {

    // INIT (+To avoid null reference)
    translationMap = collection.mutable.Map[Int, Int]()
    translationMapReverse = collection.mutable.Map[Int, Int]()
    itemSupportCounter = scala.collection.mutable.ArrayBuffer.empty[Int]
    itemSupportCounter += 0

    // INIT SDB
    var curIndex = -1
    val partialSDB: Array[Array[Int]] = preProcessPostfixes(postfixes).flatMap(x => {
      // Find list of non-empty sequences
      // Find Sequence
      curIndex+=1
      val resSeq = preProcessArrayToSDB(x, curIndex)
      // Return resulting sequence if non empty
      if(resSeq.length > 0) Some(resSeq)
      else None
    })

    numItems += 1
    nbSequences = partialSDB.length
    firstItemPosInSid = Array.fill(numItems)(Array.fill(nbSequences)(0))
    lastItemPosInSid = Array.fill(numItems)(Array.fill(nbSequences)(0))
    val sdb = createPosLists(partialSDB)

    // CHECK FOR NON-EMPTY SDB
    if(lenSeqMax == 0) {
      // If empty, return empty Iterator
      return Iterator()
    }

    // INIT CONSTRAINT VARIABLE
    val supportCounter = itemSupportCounter.toArray

    val CPVariables = initCPVariables()

    val sdbPosList = createSdbPosList(lastItemPosInSid)

    // RUN
    val solutions = scala.collection.mutable.ArrayBuffer.empty[(Array[Int], Long)]
    val c = new PPIC(CPVariables, sdb, sdbPosList,
      firstItemPosInSid, lastItemPosInSid, supportCounter, minSup, numItems)
    // val c = new PPICfix413(CPVariables, sdb,
    //    firstItemPosList, lastItemPosList, supportCounter, minSup, numItems + 1)
    add(c)
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
    this.solver.search(binaryStatic(CPVariables))
    this.solver.start()

    // PRINT
    /*
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
    supportCounter.foreach(x=> {print(x); print(" ")})
    println()
    println("firstItemPosInSid")
    firstItemPosInSid.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("lastItemPosInSid")
    lastItemPosInSid.foreach(x=> {x.foreach(x=> {print(x); print(" ")}); println()})
    println("RUN STOP")
    println()
    */
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
  * @param lastPosOfItem is the last real position of an item in a sequence,
  *                      if 0 it is not present
  *                       s1  s2  s3  s4
  *                    a  1   2   1   0
  *                    b  4   3   2   1
  *                    c  5   4   0   2
  *                    d  0   0   0   3
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

      if (lastPosOfItem(prefix)(sid) != 0) {
        // here we know at least that prefix is present in sequence sid

        // search for next value "prefix" in the sequence starting from
        if (lastPosOfItem(prefix)(sid) - 1 >= pos) {
          // we are sure prefix next position is available,
          // so we add the sequence in the new projected data base

          nbAdded += 1

          // find next position of prefix
          if (start == -1) {

            pos = firstPosOfItem(prefix)(sid) - 1

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