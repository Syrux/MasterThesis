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
 * @param prefix the current prefix
 * @param minSup minimal support for a frequent pattern
 * @param minPatternLength min pattern length for a frequent pattern
 * @param maxPatternLength max pattern length for a frequent pattern
 * @param outPutItemSetPermutation A boolean value that define whether running the algorithm
 *                                 on <(1,2) 3> should output (1,2) 3; 1 3; 2 3 or just the
 *                                 last two ...
 */
private[fpm] class SparkCPRunner(val prefix: Array[Int],
                              val minSup: Long,
                              val minPatternLength: Int,
                              val maxPatternLength: Int,
                              val outPutItemSetPermutation: Boolean)
  extends CPModel with App with Logging with Serializable{

  // Define separator
  var separator = 0
  var epsilon = -1

  var lenSeqMax = 0
  var nbSequences = 0

  var itemSupportCounter: scala.collection.mutable.Map[Int, Int] =
    scala.collection.mutable.Map[Int, Int]()

  def getLastItemFromPrefix(): Array[Int] = {
    prefix.drop(prefix.lastIndexOf(separator) + 1)
  }

  /**
   * Removes first element before first 0
   * Then count support for each item, so that unsupported item can be removed in the future.
   *
   * @return the inputed postfixes, desencapsulated and with the first elem removed
   */
  def preProcessPostfixes(postfixes: Array[Postfix]):
    Array[scala.collection.mutable.Map[Int, ReversibleArrayStack[Int]]] = {

    val preprocessed = scala.collection.mutable.ArrayBuffer
      .empty[scala.collection.mutable.Map[Int, ReversibleArrayStack[Int]]]
    itemSupportCounter = collection.mutable.Map[Int, Int]()

    // Count support for each item
    val itemSupportedByThisSequence = collection.mutable.Map[Int, Int]()
    for (postfix <- postfixes) {
      var firstZeroNotEncountered = true

      postfix.items.foreach(x => {
        if (!outPutItemSetPermutation && firstZeroNotEncountered) {
          if (x == separator) firstZeroNotEncountered = false
        }
        else itemSupportedByThisSequence.update(x, 1)
      })

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
      val curPostfix = scala.collection.mutable.Map.empty[Int, ReversibleArrayStack[Int]]
      var lastItemWasSeparator = false

      var lenSeq = 0
      var pos = postfix.items.length - 1
      var addedSomethingElseThanZero = false
      // Start position of the sequence, allow removal of first/ useless item
      val startPos = if (outPutItemSetPermutation) 1
                     else postfix.items.indexOf(separator)

      // We build the sequence in reverse
      while (pos >= startPos) {
        val x = postfix.items(pos)

        if (x == 0) {
          if (!lastItemWasSeparator) {
            lastItemWasSeparator = true
            curPostfix.getOrElseUpdate(x, new ReversibleArrayStack[Int](solver)).push(pos)
            lenSeq += 1
          }
        }
        else if (itemSupportCounter.getOrElse(x, 0) >= minSup) {
          lastItemWasSeparator = false
          addedSomethingElseThanZero = true
          curPostfix.getOrElseUpdate(x, new ReversibleArrayStack[Int](solver)).push(pos)
          lenSeq += 1
        }
        pos -= 1
      }
      // If sequence is useful, add it
      if (addedSomethingElseThanZero) {
        // Check if larger than current lenSeqMax
        if (lenSeq > lenSeqMax) lenSeqMax = lenSeq
        // Append and continue (We append an immutable version for optimisation)
        preprocessed.append(curPostfix)
      }
      // Else, let it's content dissapear into oblivion
    }
    preprocessed.toArray
  }

  def initCPVariables(maxPatternLength: Int,
                      itemSet : scala.collection.Set[Int],
                      outPutItemSetPermutation: Boolean):
    Array[CPIntVar] = {

    val nonZeroSet = itemSet -- Set(separator)
    val nonZeroEpsilonSet = nonZeroSet ++ Set(epsilon)
    val epsilonSet = itemSet ++ Set(epsilon)
    val specialValSet = Set(separator, epsilon)

    val maxLength = {
      if (!outPutItemSetPermutation && maxPatternLength < lenSeqMax) {
        math.min((maxPatternLength*2) + 1, lenSeqMax)
      }
      else lenSeqMax
    }

    // TODO : actual min pattern length calculation
    val minLength = if (outPutItemSetPermutation) 2
    else 3

    val CPVariables = new Array[CPIntVar](maxLength)
    for (i <- CPVariables.indices) {
      CPVariables(i) = {
        if (outPutItemSetPermutation) {
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

    // INIT sdb
    val sdb = preProcessPostfixes(postfixes)
    // IF we only have epsilon and separator, no need to search
    if(sdb.length < minSup) return Iterator()

    val itemSet = itemSupportCounter.keySet

    // Init CPvariables
    val CPVariables = initCPVariables(maxPatternLength, itemSet, outPutItemSetPermutation)

    // Setup max pattern length
    val amongItem = (itemSet -- Set(separator)).toSet
    if (maxPatternLength <= math.floor(lenSeqMax/2)) {
      add(atMost(maxPatternLength, CPVariables, amongItem))
    }

    val lastPrefixItemElems = if (outPutItemSetPermutation) getLastItemFromPrefix()
                              else Array[Int]()

    // PRINT
    /*
    println("START")
    println(itemSet)
    println("Postfixes")
    postfixes.foreach(x => {x.items.foreach(x=> {print(x); print(" ")}); println()})
    println("sdb")
    sdb.foreach(x => {x.keys.foreach( y => {
      print(y +  " : ")
      for (elem <- x.getOrElse(y, new ReversibleArrayStack[Int](solver))) {
        print(elem)
        print(" ")
      }; println()}); println()})
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
    val c = new SparkCPOptimised(CPVariables, sdb, lastPrefixItemElems, minSup)
    add(c)

    this.solver.onSolution {
      val curSol = scala.collection.mutable.ArrayBuffer.empty[Int]
      CPVariables.foreach(x => {
        if (x.value != epsilon)curSol += x.value
      })
      solutions += ((curSol.toArray, c.curPrefixSupport))
    }

    this.solver.search(binaryStatic(CPVariables))
    this.solver.start()

    solutions.toIterator
  }
}

class SparkCPOptimised(val P: Array[CPIntVar],
              val SDB: Array[scala.collection.mutable.Map[Int, ReversibleArrayStack[Int]]],
              val prefixOfLastItem: Array[Int],
              val minsup : Long)
  extends Constraint(P(0).store, "SPARK - CP") {

  // Define separator
  val separator = 0
  val epsilon = -1

  // Support for current prefix
  var curPrefixSupport : Int = 0

  // current position in P $P_i = P[curPosInP.value]$
  private[this] val curPosInP = new ReversibleInt(s, 0)

  // Map containing unsupported elements
  private[this] val supportMap = scala.collection.mutable.Map.empty[Int, Int]

  private[this] val itemSupportedByThisSequence = collection.mutable.Map[Int, Int]()

  // Array with start position in each sequence
  private[this] val posList = Array.fill[ReversibleInt](SDB.length)(new ReversibleInt(s, 0))

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

    while (v < P.length && P(v).isBound && P(v).min != epsilon) {

      // Project prefix
      if (!project(v)) {
        // println("false : " + P.mkString(" "))
        return Failure
      }
      // println("true : " + P.mkString(" "))

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
          if (P(v + 1).removeValue(separator) == Failure) return Failure
          if (P(v + 1).isBoundTo(epsilon)) enforceEpsilonFrom(v + 1)
        }
      }

      // println("removed : " + P.mkString(" "))

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
    else if (prefixOfLastItem.length > -posInPrefix - 1) {
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

      // Get current index for that sequence
      val index = posList(sequenceIndex)
      // Search cur sequence
      val i = index.value
      val curSeq = SDB(sequenceIndex)

      // Find start of next item
      val separatorPos = curSeq.getOrElse(separator, new ReversibleArrayStack[Int](s))
      while (!separatorPos.isEmpty && separatorPos.top < i) separatorPos.pop()

      if (separatorPos.isEmpty) {
        // Do nothing, all hope is lost for this sequence
      }
      else if (soughtItem == separator) {
        // If separator empty => unsupported
        // Else supported, move index of sequence
        index.setValue(separatorPos.pop() + 1)
        curPrefixSupport += 1
      }
      else {
        // Find next sought item, if in current item Success
        // Else, search all items until found or unsupported
        val soughtPos = curSeq.getOrElse(soughtItem, new ReversibleArrayStack[Int](s))
        while (!soughtPos.isEmpty && soughtPos.top < i) soughtPos.pop()

        // If no pos, don't even look for it, it's unsupported
        if (! soughtPos.isEmpty) {
          // Else, search all items until found or unsupported
          if (soughtPos.top < separatorPos.top) {

            index.setValue(soughtPos.pop() + 1)
            curPrefixSupport += 1
          }
          else {
            // Search from that item on, nothing before anyway
            // Find current prefix boundaries
            var posInP = v - 1
            while (posInP >= 0 && P(posInP).value != separator) posInP -= 1
            if (posInP == -1) posInP = -prefixOfLastItem.length
            else posInP += 1

            if (posInP == v) {
              // No prefix to search for, just put pos to next item found
              index.setValue(soughtPos.pop() + 1)
              curPrefixSupport += 1
            }
            else {
              // Find least present item in comming sequence
              // Iter on that item, to shorten computation time
              var minSize = soughtPos.size
              var minSizePos = v - posInP
              var curPosInPrefixArray = 0

              val prefixSearcherArray = Array.fill[ReversibleArrayStack[Int]](v - posInP + 1) {
                // Find itemMap
                val item = getElemOfP(posInP)
                val itemMap = curSeq.getOrElse(item, new ReversibleArrayStack[Int](s))
                // Advance it as much as possible
                while (!itemMap.isEmpty && itemMap.top < i) itemMap.pop()
                // Find min size map
                if (itemMap.size < minSize) {
                  minSize = itemMap.size
                  minSizePos = curPosInPrefixArray
                }
                // Iter on next
                curPosInPrefixArray += 1
                posInP += 1
                itemMap
              }

              var isFound = false
              while (!isFound && minSize > 0) {
                // Get next pos and reduce minsize
                val nextPosToCheck = prefixSearcherArray(minSizePos).top
                minSize -= 1 // Elem removed at the end, if nothing found in iter
                // If something is found, we remove it after changing the index pos
                // Find LB, UB is next pos to check
                var LB = separatorPos.top
                while(separatorPos.top < nextPosToCheck) LB = separatorPos.pop()
                // Check if, for all other item, there exist an element between LB and UB
                isFound = true
                var posInPrefixArray = 0
                val savedPos = minSizePos
                // Check pos lower than minSize first
                while (isFound && posInPrefixArray < prefixSearcherArray.length) {

                  if (posInPrefixArray != savedPos) {
                    val prefixItem = prefixSearcherArray(posInPrefixArray)
                    while (!prefixItem.isEmpty && prefixItem.top < LB) prefixItem.pop()
                    // Determing if we should keep seaching in that item
                    // If empty, no chance
                    if (prefixItem.isEmpty) isFound = false
                    // Else, IF next item larger than UB, drop it
                    else if (prefixItem.top >= nextPosToCheck) isFound = false
                    else prefixItem.pop()
                    // Update reference item to minsize
                    if (prefixItem.size < minSize) {
                      minSize = prefixItem.size
                      minSizePos = posInPrefixArray
                    }
                  }
                  posInPrefixArray += 1
                }
                // If not found : Remove item, so we don't loop indefinitly
                // If found, keep it so we can update index !
                if (!isFound && !prefixSearcherArray(savedPos).isEmpty) {
                  prefixSearcherArray(savedPos).pop()
                }
              }
              if(isFound) {
                // Prefix supported, last pos cannot be empty, so we simply take what's in it
                index.setValue(prefixSearcherArray(prefixSearcherArray.length - 1).pop() + 1)
                curPrefixSupport += 1
              }
              else {
                // IF not foung, kill sequence
                while (separatorPos.size > 1) separatorPos.pop()
                index.setValue(separatorPos.pop() + 1)
              }
            }
          }
        }
        else {
          // IF soughtPos doesn't exist, kill sequence for future iter
          while (separatorPos.size > 1) separatorPos.pop()
          index.setValue(separatorPos.pop() + 1)
        }
      }
      // Recalculate support map
      if (soughtItem == separator && !separatorPos.isEmpty) {
        curSeq.foreach{
          case (key: Int, stack: ReversibleArrayStack[Int]) =>
            // Clean uneeded elements
            val i = index.value
            while (!stack.isEmpty && stack.top < index.value) stack.pop()
            // Add to support map if necessary
            if (!stack.isEmpty) supportMap.update(key, supportMap.getOrElse(key, 0) + 1)
        }
      }
    }
    // Return result
    curPrefixSupport >= minsup
  }
}