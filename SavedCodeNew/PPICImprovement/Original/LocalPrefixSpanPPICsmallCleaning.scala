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

/**
 * Calculate all patterns of a projected database in local mode.
 *
 * @param minSup minimal support for a frequent pattern
 * @param minPatternLength min pattern length for a frequent pattern
 * @param maxPatternLength max pattern length for a frequent pattern
 * @param outPutItemSetPermutation A boolean value that define whether running the algorithm
 *                                 on <(1,2) 3> should output (1,2) 3; 1 3; 2 3 or just the
 *                                 last two ...
 */
private[fpm] class LocalPrefixSpanPPICsmallCleaning( val minSup: Long,
                                                      val minPatternLength: Int,
                                                      val maxPatternLength: Int,
                                                      val outPutItemSetPermutation: Boolean)
  extends CPModel with App with Logging with Serializable{

  // One to one translation map
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

  def updateTranslationMap(value: Int): Int = {

    // Add new value in reverse map
    numItems += 1
    translationMapReverse.update(numItems, value)
    // Create new support counter
    itemSupportCounter += 0
    // Add value in translation map
    numItems
  }

  def preProcessArrayToSDB(array: Array[Int], index: Int): Array[Int] = {

    // Current index (+1 shift)
    var firstZeroEncoutered = false
    var curIndex = 0
    // Filter zero items
    val itemEncountered = scala.collection.mutable.Map[Int, Int]()
    val res = array.flatMap(x => {
      if (firstZeroEncoutered && x != epsilon) {
        // Update cur index
        curIndex +=1
        // Get word translation
        val trans = translationMap.getOrElseUpdate(x, updateTranslationMap(x))
        if (itemEncountered.getOrElse(trans, 0) == 0) {
          itemEncountered.update(trans, 1)
          itemSupportCounter(trans) += 1
        }
        Some(trans)
      }
      else if (x == epsilon) {
        firstZeroEncoutered = true
        None
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
        if(itemSupportCounter(cur) >= minSup) {
          currentSequence.append(cur)
          // Update PosInSid lists and itemSupportCounter
          lastItemPosInSid(cur)(i) = currentSequence.length
          if (firstItemPosInSid(cur)(i) == 0) {
            firstItemPosInSid(cur)(i) = currentSequence.length
          }
        }
      }
      if (currentSequence.length > 0) {
        if (currentSequence.length > lenSeqMax) lenSeqMax = currentSequence.length
        finalSdb.append(currentSequence.toArray)
      }
      else finalSdb.append(Array(0))
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
    val partialSDB: Array[Array[Int]] = postfixes.flatMap(x => {
      // Find list of non-empty sequences
      // Find Sequence
      curIndex+=1
      val resSeq = preProcessArrayToSDB(x.items, curIndex)
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
