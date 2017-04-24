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
import oscar.cp.core._
import oscar.cp.core.CPOutcome._
import oscar.cp.core.variables.CPIntVar


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


/**
 * PPDC [Constraint Programming & Sequential Pattern Mining with Prefix projection method]
 * is the CP version of Prefix projection method of Sequential Pattern Mining
 * (with several improvements) which is based on projected database
 * (We use here pseudo-projected-database \{ (sid, pos) \}).
 *
 * This constraint generate all available solution given such parameters
 *
 * @param P, is pattern where $P_i$ is the item in position $i$ in $P$
 * @param SDB, [sequence database] it is a set of sequences. Each line $SDB_i$ or
 *           $t_i$ represent a sequence
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
 * @param itemsSupport is the initial support (number of sequences
 *                     where an item appeared) of all items
 *                     a : 3, b : 4, c : 3, d : 1
 * @param minsup is a threshold support, item must appear in at least
 *               minsup sequences $support(item)>=minsup$
 * @param nItems is the number of items in SDB
 *
 * @author John Aoga (johnaoga@gmail.com) and Pierre Schaus (pschaus@gmail.com)
 */
class PPDC(val P: Array[CPIntVar],
           val SDB: Array[Array[Int]],
           val SDBlastPos: Array[Array[Int]],
           val firstPosOfItem: Array[Array[Int]],
           val lastPosOfItem : Array[Array[Int]],
           val itemsSupport : Array[Int],
           val minsup : Long,
           val nItems : Int)
  extends Constraint(P(0).store, "PPDC") {

  idempotent = true

  private[this] val epsilon = 0  // this is for empty item
  private[this] val lenSDB = SDB.size
  private[this] val patternSeq = P.clone()
  private[this] val lenPatternSeq = P.length

  // representation of pseudo-projected-database
  private[this] var innerTrailSize = lenSDB*5
  // the Num of Sequence (sid)
  private[this] var psdbSeqId = Array.tabulate(innerTrailSize)(i => i)
  // position of prefix in this sid
  private[this] var psdbPosInSeq = Array.tabulate(innerTrailSize)(i => 0)
  // current size of trail
  private[this] val psdbStart = new ReversibleInt(s, 0)
  // current position in trail
  private[this] val psdbSize = new ReversibleInt(s, lenSDB)


  // when InnerTrail is full, it allows to double size of trail
  @inline private def growInnerTrail(): Unit = {
    val newPsdbSeqId = new Array[Int](innerTrailSize*2)
    val newPsdbPosInSeq = new Array[Int](innerTrailSize*2)
    System.arraycopy(psdbSeqId, 0, newPsdbSeqId, 0, innerTrailSize)
    System.arraycopy(psdbPosInSeq, 0, newPsdbPosInSeq, 0, innerTrailSize)
    psdbSeqId = newPsdbSeqId
    psdbPosInSeq = newPsdbPosInSeq
    innerTrailSize *= 2
  }

  // support counter contain support for each item, it is reversible for efficient backtrack
  val supportCounter : Array[ReversibleInt] =
    Array.tabulate(itemsSupport.length)(e => new ReversibleInt(s, itemsSupport(e)))
  var curPrefixSupport : Int = 0

  // current position in P $P_i = P[curPosInP.value]$
  private[this] val curPosInP = new ReversibleInt(s, 0)

  // check if pruning is done successfully
  private[this] var pruneSuccess = true
  /**
   * Entry in constraint, function for all init
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
   * @return the outcome i.e. Failure, Success or Suspend
   */
  final override def propagate(): CPOutcome = {
    var v = curPosInP.value

    if (P(v).isBoundTo(epsilon)) {
      if (v == 0) return Failure
      if (!P(v-1).isBoundTo(epsilon)) enforceEpsilonFrom(v)
      return Success
    }

    while (v < P.length && P(v).isBound && P(v).min != epsilon) {

      if (!filterPrefixProjection(P(v).getMin)) return Failure
      curPosInP.incr()
      v = curPosInP.value
    }

    if (v > 0 && v< lenPatternSeq && P(v).isBoundTo(epsilon)) {
      enforceEpsilonFrom(v)
    }
    Suspend
  }



  /**
   * when $P_i = epsilon$, then $P_i+1 = epsilon$
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
   *  all the indices before (< currPosInP) are already bound
   *
   *  if prefix is not epsilon we can compute next pseudo-projected-database
   *  with projectSDB function
   *
   * @param prefix
   * @return the Boolean is to say if current prefix is a solution or not
   */
  private def filterPrefixProjection(prefix : Int) : Boolean = {
    val i = curPosInP.value + 1

    if (i >= 2 && prefix == epsilon) {
      return true
    } else {

      ///
      val sup = projectSDB(prefix)

      if ( sup < minsup) {

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
   * @param i current position in P
   */
  private def prune(i : Int) : Unit = {
    val j = i

    if (j >= lenPatternSeq) return

    var k = 0
    val len = P(j).fillArray(dom)

    while (k < len) {

      val item = dom(k)

      if (item != epsilon && supportCounter(item) < minsup) {

        if (P(j).removeValue(item) == Failure) {

          pruneSuccess = false
          return
        }
      }

      k += 1
    }
  }



  /**
   * Computing of next pseudo projected database
   * @param prefix
   * @return
   */
  private def projectSDB(prefix : Int) : Int = {
    val startInit = psdbStart.value
    val sizeInit = psdbSize.value

    // Count sequences validated for next step
    curPrefixSupport = 0

    var i = startInit
    var j = startInit + sizeInit

    while (i < startInit + sizeInit) {

      val sid = psdbSeqId(i)

      val ti = SDB(sid)
      val lti = ti.length
      val start = psdbPosInSeq(i)

      var pos = start

      if (lastPosOfItem(prefix)(sid) != 0) {
        // here we know at least that prefix is present in sequence sid

        // search for next value "prefix" in the sequence starting from
        if (lastPosOfItem(prefix)(sid) - 1 >= pos) {
          // we are sure prefix next position is available

          // find next position of prefix
          while (pos < lti && prefix != ti(pos)) {
            val item = ti(pos)
            updateSupportCounter(item, sid, pos)
            pos += 1
          }

          // check if this prefix will still available
          updateSupportCounter(prefix, sid, pos)

          // update pseudo projected database and support
          psdbSeqId(j) = sid
          psdbPosInSeq(j) = pos + 1
          j += 1
          if (j >= innerTrailSize) growInnerTrail()

          curPrefixSupport += 1

        } else {

          removeAllItemsInSid(sid, pos, lti, ti)

        }
      } else {

        removeAllItemsInSid(sid, pos, lti, ti)

      }

      i += 1
    }

    psdbStart.value = startInit + sizeInit
    psdbSize.value = curPrefixSupport

    return curPrefixSupport


  }

  /**
   * decrease value of support if we leave item
   * @param item
   * @param sid
   * @param pos
   */
  private def updateSupportCounter(item : Int, sid : Int, pos : Int) : Unit = {
    if (lastPosOfItem(item)(sid) - 1 <= pos) {
      // no need to have the exact value of the support if already below minsup
      // all what matters is to know we are below. This can save some useless trailing operations
      // if (supportCounter(item) >= minsup)
      supportCounter(item).decr()
    }
  }

  /**
   * remove all item in this sequence by decreasing supportCounter *
   * @param sid
   * @param initPos
   * @param lenOfSequence
   * @param sequence
   */
  private def removeAllItemsInSid(sid : Int,
                                  initPos : Int,
                                  lenOfSequence : Int,
                                  sequence : Array[Int]): Unit = {
    var pos = initPos
    if ( pos < lenOfSequence) {
      updateSupportCounter(sequence(pos), sid, pos)
    }

    var break = false
    val tiLast = SDBlastPos(sid)
    // println("tsid = "+ti.mkString(",")+" pos = "+pos)
    // println("tlas = "+tiLast.mkString(","))

    while (!break && pos < lenOfSequence) {
      val last = tiLast(pos)

      if ( last == 0) {
        break = true
      } else {
        val item = sequence(last-1)
        supportCounter(item).decr()
        pos = last-1
      }

    }
  }
}

/**
 * PPICfix413 [Constraint Programming & Sequential Pattern Mining with Prefix projection method]
 * is the CP version of Prefix projection method of Sequential Pattern Mining
 * (with several improvements) which is based on projected database
 * (We use here pseudo-projected-database \{ (sid, pos) \}).
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
 * @param itemsSupport is the initial support (number of sequences where a item is appeared)
 *                     of all items; a : 3, b : 4, c : 3, d : 1
 * @param minsup is a threshold support,
 *               item must appear in at least minsup sequences $support(item)>=minsup$
 * @param nItems is the number of items in SDB
 * @author John Aoga (johnaoga@gmail.com) and Pierre Schaus (pschaus@gmail.com)
 */
class PPICfix413(val P: Array[CPIntVar],
                 val SDB: Array[Array[Int]],
                 val firstPosOfItem: Array[Array[Int]],
                 val lastPosOfItem : Array[Array[Int]],
                 val itemsSupport : Array[Int],
                 val minsup : Long,
                 val nItems : Int)
  extends Constraint(P(0).store, "PPICfix413") {

  idempotent = true

  private[this] val epsilon = 0  // this is for empty item
  private[this] val lenSDB = SDB.size
  private[this] val patternSeq = P.clone()
  private[this] val lenPatternSeq = P.length

  // representation of pseudo-projected-database
  private[this] var innerTrailSize = lenSDB*5
  // the Num of Sequence (sid)
  private[this] var psdbSeqId = Array.tabulate(innerTrailSize)(i => i)
  // position of prefix in this sid
  private[this] var psdbPosInSeq = Array.tabulate(innerTrailSize)(i => -1)
  // current size of trail
  private[this] val psdbStart = new ReversibleInt(s, 0)
  // current position in trail
  private[this] val psdbSize = new ReversibleInt(s, lenSDB)

  // when InnerTrail is full, it allows to double size of trail
  @inline private def growInnerTrail(): Unit = {
    val newPsdbSeqId = new Array[Int](innerTrailSize*2)
    val newPsdbPosInSeq = new Array[Int](innerTrailSize*2)
    System.arraycopy(psdbSeqId, 0, newPsdbSeqId, 0, innerTrailSize)
    System.arraycopy(psdbPosInSeq, 0, newPsdbPosInSeq, 0, innerTrailSize)
    psdbSeqId = newPsdbSeqId
    psdbPosInSeq = newPsdbPosInSeq
    innerTrailSize *= 2
  }

  // support counter contain support for each item, it is reversible for efficient backtrack
  private[this] var supportCounter = itemsSupport
  var curPrefixSupport : Int = 0

  // current position in P $P_i = P[curPosInP.value]$
  private[this] val curPosInP = new ReversibleInt(s, 0)

  // check if pruning is done successfully
  private[this] var pruneSuccess = true

  /**
   * Entry in constraint, function for all init
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
   * @return the outcome i.e. Failure, Success or Suspend
   */
  final override def propagate(): CPOutcome = {
    var v = curPosInP.value

    if (P(v).isBoundTo(epsilon)) {
      if (v == 0) return Failure
      if (!P(v-1).isBoundTo(epsilon)) {
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
   *  all the indices before (< currPosInP) are already bound
   *
   *  if prefix is not epsilon we can compute next pseudo-projected-database
   *  with projectSDB function
   *
   * @param prefix
   * @return the Boolean is to say if current prefix is a solution or not
   */
  private def filterPrefixProjection(prefix : Int) : Boolean = {
    val i = curPosInP.value + 1
    // println("filter prefix "+prefix+" at position "+i)
    if (i >= 2 && prefix == epsilon) {
      return true
    } else {

      ///
      val sup = projectSDB(prefix)

      if ( sup < minsup) {

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
   * @param i current position in P
   */
  private def prune(i : Int) : Unit = {
    val j = i

    if (j >= lenPatternSeq) return

    var k = 0
    val len = P(j).fillArray(dom)
    // println( "-->"+dom.mkString("-")+" len = "+len)
    // print("removed = ")
    while (k < len) {

      val item = dom(k)

      if ( item != epsilon && supportCounter(item) < minsup ) {
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
   * @param prefix
   * @return
   */
  private def projectSDB(prefix : Int) : Int = {

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
          // we are sure prefix next position is available
          // so we add the sequence in the new projected data base

          val existItem = Array.fill[Boolean](nItems)(false)

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
          pos += 1
          while ( pos < lti) {
            val item = ti(pos)

            if ( !existItem(item) ) {
              supportCounter(item) += 1
              existItem(item) = true
            }
            pos += 1
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
