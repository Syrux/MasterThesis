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

import java.{lang => jl, util => ju}
import java.util.concurrent.atomic.AtomicInteger

import scala.collection.JavaConverters._
import scala.collection.mutable
import scala.reflect.ClassTag
import scala.reflect.runtime.universe._

import org.json4s.DefaultFormats
import org.json4s.JsonDSL._
import org.json4s.jackson.JsonMethods.{compact, render}

import org.apache.spark.SparkContext
import org.apache.spark.annotation.Since
import org.apache.spark.api.java.JavaRDD
import org.apache.spark.api.java.JavaSparkContext.fakeClassTag
import org.apache.spark.internal.Logging
import org.apache.spark.mllib.util.{Loader, Saveable}
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{DataFrame, Row, SparkSession}
import org.apache.spark.sql.catalyst.ScalaReflection
import org.apache.spark.sql.types._
import org.apache.spark.storage.StorageLevel

/**
 * A parallel PrefixSpan algorithm to mine frequent sequential patterns.
 * The PrefixSpan algorithm is described in J. Pei, et al., PrefixSpan: Mining Sequential Patterns
 * Efficiently by Prefix-Projected Pattern Growth
 * (see <a href="http://doi.org/10.1109/ICDE.2001.914830">here</a>).
 *
 * @param minSupport the minimal support level of the sequential pattern, any pattern that
 *                   appears more than (minSupport * size-of-the-dataset) times will be output
 *
 * @param maxPatternLength the maximal length of the sequential pattern, any pattern that appears
 *                         less than maxPatternLength will be output
 *
 * @param minPatternLength the minimal length of the sequential pattern, any pattern that appears
 *                         with a larger or equal length, will be output
 *
 * @param subProblemLimit The SOFT limit on the number of subProblems that should be created
 *                        before switching to a local execution. This may improve performances
 *                        in network of very capable machine, or when dealing with
 *                        small problems.
 *
 *                        The recommended value would be AT LEAST the number of available
 *                        machines squared. Since the slowest subProblem will determine
 *                        the total computation time !
 *
 *                        If put to 0, the parameter will be ignored.
 *                        If put to 1, the algorithm directly switch to a local exec
 *
 *                        Basically just a more precise way of managing subproblems number than
 *                        maxLocalProjDBSize.
 *
 * @param maxLocalProjDBSize The maximum number of items (including delimiters used in the internal
 *                           storage format) allowed in a projected database before local
 *                           processing. If a projected database exceeds this size, another
 *                           iteration of distributed prefix growth is run.
 *
 * @see <a href="https://en.wikipedia.org/wiki/Sequential_Pattern_Mining">Sequential Pattern Mining
 * (Wikipedia)</a>
 */
@Since("1.5.0")
class PrefixSpan private (
                           private  var canUsePPIC: Boolean,
                           private var minSupport: Double,
                           private var maxPatternLength: Int,
                           private var minPatternLength: Int,
                           private var maxItemPerItemSet: Int,
                           private var subProblemLimit: Long,
                           private var maxLocalProjDBSize: Long) extends Logging with Serializable {
  import PrefixSpan._

  /**
   * Constructs a default instance with default parameters
   * {minSupport: `0.1`, maxPatternLength: `0`, minPatternLength: `1`,
   *   maxItemPerItemSet: `0`, subProblemLimit: `0`, maxLocalProjDBSize: `32000000L`}.
   */
  @Since("1.5.0")
  def this() = this(false, 0.1, 0, 1, 0, 0, 32000000L)

  def getCanUsePPIC: Boolean = canUsePPIC

  def setCanUsePPIC(canUsePPIc: Boolean): this.type = {
    this.canUsePPIC = canUsePPIc
    this
  }

  /**
   * Get the minimal support (i.e. the frequency of occurrence before a pattern is considered
   * frequent).
   */
  @Since("1.5.0")
  def getMinSupport: Double = minSupport

  /**
   * Sets the minimal support level (default: `0.1`).
   */
  @Since("1.5.0")
  def setMinSupport(minSupport: Double): this.type = {
    require(minSupport >= 0 && minSupport <= 1,
      s"The minimum support value must be in [0, 1], but got $minSupport.")
    this.minSupport = minSupport
    this
  }

  /**
   * Gets the maximal pattern length
   * (i.e. the length of the longest sequential pattern to consider.
   */
  @Since("1.5.0")
  def getMaxPatternLength: Int = maxPatternLength

  /**
   * Sets maximal pattern length (default: `0`).
   */
  @Since("1.5.0")
  def setMaxPatternLength(maxPatternLength: Int): this.type = {
    require(maxPatternLength >= 0,
      s"The maximum pattern length value cannot be negative, but got $maxPatternLength.")
    this.maxPatternLength = maxPatternLength
    this
  }

  /**
   * Gets the minimal pattern length
   * (i.e. the length of the smallest sequential pattern to consider.
   */
  @Since("1.5.0")
  def getMinPatternLength: Int = minPatternLength

  /**
   * Sets minimal pattern length (default: `1`).
   */
  @Since("1.5.0")
  def setMinPatternLength(minPatternLength: Int): this.type = {
    require(minPatternLength >= 1,
      s"The minimum pattern length value cannot be less than one, but got $minPatternLength.")
    this.minPatternLength = minPatternLength
    this
  }

  /**
   * Gets the maximum number of item and ItemSet can have in the solutions
   */
  @Since("1.5.0")
  def getMaxItemPerItemSet: Int = maxItemPerItemSet

  /**
   * Sets the maximum number of item and ItemSet can have in the solutions
   *
   * If put to 0, no limit will be imposed
   */
  @Since("1.5.0")
  def setMaxItemPerItemSet(maxItemPerItemSet: Int): this.type = {
    require(maxItemPerItemSet >= 0,
      s"MaxItemPerItemSet cannot be less than zero, but got $maxItemPerItemSet.")
    this.maxItemPerItemSet = maxItemPerItemSet
    this
  }

  /**
   * Gets the soft subProblem limit
   * (i.e. the number of subProblems created after which we force a local exec)
   */
  @Since("1.5.0")
  def getSubProblemLimit: Long = subProblemLimit

  /**
   * Sets the soft subProblem limit (default: `0`).
   *
   * If put to 0, the parameter will be ignored.
   * If put to 1, the algorithm directly switch to a local exec
   */
  @Since("1.5.0")
  def setSubProblemLimit(subProblemLimit: Long): this.type = {
    require(subProblemLimit >= 0,
      s"The soft subProblem limit cannot be less than zero, but got $subProblemLimit.")
    this.subProblemLimit = subProblemLimit
    this
  }

  /**
   * Gets the maximum number of items allowed in a projected database before local processing.
   */
  @Since("1.5.0")
  def getMaxLocalProjDBSize: Long = maxLocalProjDBSize

  /**
   * Sets the maximum number of items (including delimiters used in the internal storage format)
   * allowed in a projected database before local processing (default: `32000000L`).
   */
  @Since("1.5.0")
  def setMaxLocalProjDBSize(maxLocalProjDBSize: Long): this.type = {
    require(maxLocalProjDBSize >= 0L,
      s"The maximum local projected database size must be nonnegative, but got $maxLocalProjDBSize")
    this.maxLocalProjDBSize = maxLocalProjDBSize
    this
  }

  /**
   * Finds the complete set of frequent sequential patterns in the input sequences of itemsets.
   * @param data sequences of itemsets.
   * @return a [[PrefixSpanModel]] that contains the frequent patterns
   */
  @Since("1.5.0")
  def run[Item: ClassTag](data: RDD[Array[Array[Item]]]): PrefixSpanModel[Item] = {
    if (data.getStorageLevel == StorageLevel.NONE) {
      logWarning("Input data is not cached.")
    }

    val totalCount = data.count()
    logInfo(s"number of sequences: $totalCount")
    val minCount = math.ceil(minSupport * totalCount).toLong
    logInfo(s"minimum count for a frequent pattern: $minCount")

    // Find frequent items.
    val freqItemAndCounts = data.flatMap { itemsets =>
      val uniqItems = mutable.Set.empty[Item]
      itemsets.foreach { _.foreach { item =>
        uniqItems += item
      }}
      uniqItems.toIterator.map((_, 1L))
    }.reduceByKey(_ + _)
      .filter { case (_, count) =>
        count >= minCount
      }.collect()
    val freqItems = freqItemAndCounts.sortBy(-_._2).map(_._1)
    logInfo(s"number of frequent items: ${freqItems.length}")

    // Convert freqItemArray
    val itemToInt = freqItems.zipWithIndex.toMap
    val frequentItemsAndCounts = freqItemAndCounts.map(x => (itemToInt(x._1) + 1, x._2) )

    // Keep only frequent items from input sequences and convert them to internal storage.
    val dataInternalRepr: RDD[(Array[Int], mutable.Map[Int, Int], mutable.Map[Int, Int])] = data.flatMap { itemsets =>
      val lastPosMap = mutable.Map.empty[Int, Int]
      val firstPosMap = mutable.Map.empty[Int, Int]
      val allItems = mutable.ArrayBuilder.make[Int]
      var containsFreqItems = false
      var positionInArray = 1
      allItems += 0
      itemsets.foreach { itemsets =>
        val items = mutable.ArrayBuilder.make[Int]
        itemsets.foreach { item =>
          if (itemToInt.contains(item)) {
            val curItem = itemToInt(item) + 1 // using 1-indexing in internal format
            items += curItem
            if (!firstPosMap.contains(curItem)) {
              firstPosMap.update(curItem, positionInArray-1)
            }
            lastPosMap.update(curItem, positionInArray)
            positionInArray += 1
          }
        }
        val result = items.result()
        if (result.nonEmpty) {
          containsFreqItems = true
          allItems ++= result.sorted
          allItems += 0
        }
        positionInArray += 1
      }
      if (containsFreqItems) {
        Some((allItems.result(), firstPosMap, lastPosMap))
      } else {
        None
      }
    }.persist(StorageLevel.MEMORY_AND_DISK)

    val results = genFreqPatterns(dataInternalRepr, canUsePPIC, frequentItemsAndCounts, minCount,
      maxPatternLength, minPatternLength, maxItemPerItemSet, subProblemLimit, maxLocalProjDBSize)

    def toPublicRepr(pattern: Array[Int]): Array[Array[Item]] = {
      val sequenceBuilder = mutable.ArrayBuilder.make[Array[Item]]
      val itemsetBuilder = mutable.ArrayBuilder.make[Item]
      val n = pattern.length
      var i = 1
      while (i < n) {
        val x = pattern(i)
        if (x == 0) {
          sequenceBuilder += itemsetBuilder.result()
          itemsetBuilder.clear()
        } else {
          itemsetBuilder += freqItems(x - 1) // using 1-indexing in internal format
        }
        i += 1
      }
      sequenceBuilder.result()
    }

    val freqSequences = results.map { case (seq: Array[Int], count: Long) =>
      new FreqSequence(toPublicRepr(seq), count)
    }
    new PrefixSpanModel(freqSequences)
  }

  /**
   * A Java-friendly version of `run()` that reads sequences from a `JavaRDD` and returns
   * frequent sequences in a [[PrefixSpanModel]].
   * @param data ordered sequences of itemsets stored as Java Iterable of Iterables
   * @tparam Item item type
   * @tparam Itemset itemset type, which is an Iterable of Items
   * @tparam Sequence sequence type, which is an Iterable of Itemsets
   * @return a [[PrefixSpanModel]] that contains the frequent sequential patterns
   */
  @Since("1.5.0")
  def run[Item, Itemset <: jl.Iterable[Item], Sequence <: jl.Iterable[Itemset]](
     data: JavaRDD[Sequence]): PrefixSpanModel[Item] = {
    implicit val tag = fakeClassTag[Item]
    run(data.rdd.map(_.asScala.map(_.asScala.toArray).toArray))
  }

}

@Since("1.5.0")
object PrefixSpan extends Logging {

  /**
   * Generate the firstPosMap of a sequence.
   * This map contains the first position of each different item.
   * Allowing immediate jump to that position
   */
  private[fpm] def genFirstPosMap(items : Array[Int]): mutable.Map[Int, Int] = {

    val firstPosMap = mutable.Map.empty[Int, Int]
    for (i <- items.indices) {
      val item = items(i)
      if (item != 0 && !firstPosMap.contains(item)) {
        firstPosMap.update(item, i-1)
      }
    }
    firstPosMap
  }

  /**
   * Generate the lastPosMap of a sequence.
   * This map contains the last position of each different item.
   * Allowing fast verification on whether to check the sequence or not
   */
  private[fpm] def genLastPosMap(items : Array[Int]): mutable.Map[Int, Int] = {

    val lastPosMap = mutable.Map.empty[Int, Int]
    for (i <- items.indices) {
      val item = items(i)
      if (item != 0) {
        lastPosMap.update(item, i)
      }
    }
    lastPosMap
  }

  /**
   * Find the complete set of frequent sequential patterns in the input sequences.
   * @param data ordered sequences of itemsets. We represent a sequence internally as Array[Int],
   *             where each itemset is represented by a contiguous sequence of distinct and ordered
   *             positive integers. We use 0 as the delimiter at itemset boundaries, including the
   *             first and the last position.
   * @return an RDD of (frequent sequential pattern, count) pairs,
   * @see [[Postfix]]
   */
  private[fpm] def genFreqPatterns(
                                    data: RDD[Array[Int]],
                                    minCount: Long,
                                    maxPatternLength: Int,
                                    maxLocalProjDBSize: Long): RDD[(Array[Int], Long)] = {

    genFreqPatterns(data.map(seq => (seq, genFirstPosMap(seq), genLastPosMap(seq))), false,
      Array(), minCount, maxPatternLength, 0, 0, 0, maxLocalProjDBSize)
  }

  private[fpm] def genFreqPatterns(
                                    data: RDD[Array[Int]],
                                    minCount: Long,
                                    maxPatternLength: Int,
                                    minPatternLength: Int,
                                    maxLocalProjDBSize: Long): RDD[(Array[Int], Long)] = {

    genFreqPatterns(data.map(seq => (seq, genFirstPosMap(seq), genLastPosMap(seq))), false,
      Array(), minCount, maxPatternLength, minPatternLength, 0, 0, maxLocalProjDBSize)
  }

  private[fpm] def genFreqPatterns(
           data: RDD[(Array[Int], mutable.Map[Int, Int], mutable.Map[Int, Int])],
           canUsePPIC: Boolean,
           freqItems: Array[(Int, Long)],
           minCount: Long,
           maxPatternLength: Int,
           minPatternLength: Int,
           maxItemPerItemSet: Int,
           subProblemLimit: Long,
           maxLocalProjDBSize: Long): RDD[(Array[Int], Long)] = {

    val sc = data.sparkContext

    if (data.getStorageLevel == StorageLevel.NONE) {
      logWarning("Input data is not cached.")
    }

    val postfixes = data.map(items => new Postfix(items._1, items._2, items._3))

    // Local frequent patterns (prefixes) and their counts.
    val localFreqPatterns = mutable.ArrayBuffer.empty[(Array[Int], Long)]
    // Prefixes whose projected databases are small.
    val smallPrefixes = mutable.Map.empty[Int, Prefix]
    // Prefixes whose projected databases are large.
    var largePrefixes = mutable.Map.empty[Int, Prefix]// (emptyPrefix.id -> emptyPrefix)

    // If no known prefixes or immediate local exec required.
    if (freqItems.isEmpty || subProblemLimit == 1) {
      val emptyPrefix = Prefix.empty
      largePrefixes += emptyPrefix.id -> emptyPrefix
    }
    else {
      // Use known start prefixes if available
      for ((item, count) <- freqItems) {
        // Create prefix from item
        val prefix = Prefix.create(item)
        // Add to prefix to process
        largePrefixes += prefix.id -> prefix
        // If respect condition, add to solutions
        if (prefix.length >= minPatternLength) {
          // If pattern longer than minPatternLength, add it to sol list
          localFreqPatterns += ((prefix.items :+ 0, count))
        }
        // TODO : Find a way to calculate their projected database un-expensively, if possible
        // TODO : IF already small enough, put them in small prefixes instead
      }
    }

    // Solve in cloud
    while (largePrefixes.nonEmpty) {
      // Warning for too many subProblems created
      val numLocalFreqPatterns = localFreqPatterns.length
      logInfo(s"number of local frequent patterns: $numLocalFreqPatterns")
      if (numLocalFreqPatterns > 1000000) {
        logWarning(
          s"""
             | Collected $numLocalFreqPatterns local frequent patterns. You may want to consider:
             |   1. increasing minSupport,
             |   2. decreasing maxPatternLength,
             |   3. increasing maxLocalProjDBSize.
             |   4. setting a smaller subProblemLimit
           """.stripMargin)
      }
      logInfo(s"number of small prefixes: ${smallPrefixes.size}")
      logInfo(s"number of large prefixes: ${largePrefixes.size}")
      // Check subProblemLimit
      if (subProblemLimit > 0 && smallPrefixes.size + largePrefixes.size >= subProblemLimit) {
        // Enforce limit by transfering all large prefixes to the small prefix array
        largePrefixes.values.foreach(prefix => smallPrefixes += prefix.id -> prefix)
        largePrefixes.clear()
      }
      else {
        // Limit hasn't been reached, divide in further subProblems
        val largePrefixArray = largePrefixes.values.toArray
        val freqPrefixes = postfixes.flatMap { postfix =>
          largePrefixArray.flatMap { prefix =>
            // Determine whether to search in current item
            // This is determined through maxItemPerItemSet
            val shouldSearchInCurItem =
              if (maxItemPerItemSet > 0 &&
                prefix.items.length - prefix.items.lastIndexOf(0) - 1 >= maxItemPerItemSet) {
                false
              }
              else true
            // Enforce maxItemPerItemSet through search
            postfix.project(prefix)
              .genPrefixItems(shouldSearchInCurItem).map { case (item, postfixSize) =>
              ((prefix.id, item), (1L, postfixSize))
            }
          }
        }.reduceByKey { case ((c0, s0), (c1, s1)) =>
          (c0 + c1, s0 + s1)
        }.filter { case (_, (c, _)) => c >= minCount }.collect()

        val newLargePrefixes = mutable.Map.empty[Int, Prefix]
        freqPrefixes.foreach { case ((id, item), (count, projDBSize)) =>
          val newPrefix = largePrefixes(id) :+ item
          // If pattern longer than minPatternLength, add it to sol list
          if (newPrefix.length >= minPatternLength) {
            localFreqPatterns += ((newPrefix.items :+ 0, count))
          }
          // Consider pattern only if valid
          if (maxPatternLength == 0 || newPrefix.length < maxPatternLength) {
            // Add new prefix to prefixes to explore
            if (projDBSize > maxLocalProjDBSize) {
              newLargePrefixes += newPrefix.id -> newPrefix
            } else {
              smallPrefixes += newPrefix.id -> newPrefix
            }
          }
        }
        largePrefixes = newLargePrefixes
      }
    }

    // Solve using local exec
    var freqPatterns = sc.parallelize(localFreqPatterns, 1)

    val numSmallPrefixes = smallPrefixes.size
    logInfo(s"number of small prefixes for local processing: $numSmallPrefixes")
    if (numSmallPrefixes > 0) {
      // Switch to local processing.
      val bcSmallPrefixes = sc.broadcast(smallPrefixes)
      val distributedFreqPattern = postfixes.flatMap { postfix =>
        bcSmallPrefixes.value.values.map { prefix =>
          (prefix.id, postfix.project(prefix).compressed)
        }.filter(_._2.nonEmpty)
      }.groupByKey().flatMap { case (id, projPostfixes) =>
        val prefix = bcSmallPrefixes.value(id)
        val newMaxPatternLength =
          if (maxPatternLength == 0) 0
          else maxPatternLength - prefix.length
        val newMinPatternLength = minPatternLength - prefix.length
        val spaceRemainingInCurrentItem = maxItemPerItemSet -
          (prefix.items.length - prefix.items.lastIndexOf(0) - 1)

        // TODO: We collect projected postfixes into memory. We should also compare the performance
        // TODO: of keeping them on shuffle files.
        if (canUsePPIC) {
          val localPrefixSpan = new PPICRunner(minCount, newMinPatternLength,
            newMaxPatternLength)
          localPrefixSpan.run(projPostfixes.toArray).map { case (pattern, count) =>
            (prefix.items ++ pattern, count)
          }
        }
        else {
          // Spark
          val localPrefixSpan = new LocalPrefixSpan(minCount, newMinPatternLength,
            newMaxPatternLength, maxItemPerItemSet, spaceRemainingInCurrentItem)
          localPrefixSpan.run(projPostfixes.toArray).map { case (pattern, count) =>
            (prefix.items ++ pattern, count)
          }
        }
      }
      // Union local frequent patterns and distributed ones.
      freqPatterns = freqPatterns ++ distributedFreqPattern
    }

    // Return frequent patterns after filtering small ones
    // Check must be here, since we need to check pattern obtained outside of local exec too !
    /*
    if (minPatternLength == 1) freqPatterns
    else freqPatterns.filter {case (x, _) => x.count(_ == 0) > minPatternLength}
    */
    freqPatterns
  }

  /**
   * Represents a prefix.
   * @param items items in this prefix, using the internal format
   * @param length length of this prefix, not counting 0
   */
  private[fpm] class Prefix private (val items: Array[Int], val length: Int) extends Serializable {

    /** A unique id for this prefix. */
    val id: Int = Prefix.nextId

    /** Expands this prefix by the input item. */
    def :+(item: Int): Prefix = {
      require(item != 0)
      if (item < 0) {
        new Prefix(items :+ -item, length + 1)
      } else {
        new Prefix(items ++ Array(0, item), length + 1)
      }
    }
  }

  private[fpm] object Prefix {
    /** Internal counter to generate unique IDs. */
    private val counter: AtomicInteger = new AtomicInteger(-1)

    /** Gets the next unique ID. */
    private def nextId: Int = counter.incrementAndGet()

    /** Create a new prefix from received item. */
    def create(item: Int): Prefix = new Prefix(Array(0, item), 1)

    /** An empty [[Prefix]] instance. */
    val empty: Prefix = new Prefix(Array.empty, 0)
  }

  /**
   * An internal representation of a postfix from some projection.
   * We use one int array to store the items, which might also contains other items from the
   * original sequence.
   * Items are represented by positive integers, and items in each itemset must be distinct and
   * ordered.
   * we use 0 as the delimiter between itemsets.
   * For example, a sequence `(12)(31)1` is represented by `[0, 1, 2, 0, 1, 3, 0, 1, 0]`.
   * The postfix of this sequence w.r.t. to prefix `1` is `(_2)(13)1`.
   * We may reuse the original items array `[0, 1, 2, 0, 1, 3, 0, 1, 0]` to represent the postfix,
   * and mark the start index of the postfix, which is `2` in this example.
   * So the active items in this postfix are `[2, 0, 1, 3, 0, 1, 0]`.
   * We also remember the start indices of partial projections, the ones that split an itemset.
   * For example, another possible partial projection w.r.t. `1` is `(_3)1`.
   * We remember the start indices of partial projections, which is `[2, 5]` in this example.
   * This data structure makes it easier to do projections.
   *
   * @param items a sequence stored as `Array[Int]` containing this postfix
   * @param start the start index of this postfix in items
   * @param partialStarts start indices of possible partial projections, strictly increasing
   */
  private[fpm] class Postfix(
                              val items: Array[Int],
                              val firstPosMap: mutable.Map[Int, Int],
                              val lastPosMap: mutable.Map[Int, Int],
                              val start: Int = 0,
                              val partialStarts: Array[Int] = Array.empty
                            ) extends Serializable {

    // Run check on new object
    require(items.last == 0, s"The last item in a postfix must be zero, but got ${items.last}.")
    if (partialStarts.nonEmpty) {
      require(partialStarts.head >= start,
        "The first partial start cannot be smaller than the start index," +
          s"but got partialStarts.head = ${partialStarts.head} < start = $start.")
    }

    /**
     * Start index of the first full itemset contained in this postfix.
     */
    private[this] def fullStart: Int = {
      var i = start
      while (items(i) != 0) {
        i += 1
      }
      i
    }

    /**
     * Generates length-1 prefix items of this postfix with the corresponding postfix sizes.
     * There are two types of prefix items:
     *   a) The item can be assembled to the last itemset of the prefix. For example,
     *      the postfix of `<(12)(123)>1` w.r.t. `<1>` is `<(_2)(123)1>`. The prefix items of this
     *      postfix can be assembled to `<1>` is `_2` and `_3`, resulting new prefixes `<(12)>` and
     *      `<(13)>`. We flip the sign in the output to indicate that this is a partial prefix item.
     *   b) The item can be appended to the prefix. Taking the same example above, the prefix items
     *      can be appended to `<1>` is `1`, `2`, and `3`, resulting new prefixes `<11>`, `<12>`,
     *      and `<13>`.
     * @return an iterator of (prefix item, corresponding postfix size). If the item is negative, it
     *         indicates a partial prefix item, which should be assembled to the last itemset of the
     *         current prefix. Otherwise, the item should be appended to the current prefix.
     */
    def genPrefixItems(shouldSearchInCurItem: Boolean): Iterator[(Int, Long)] = {
      val n1 = items.length - 1
      // For each unique item (subject to sign) in this sequence, we output exactly one split.
      // TODO: use PrimitiveKeyOpenHashMap
      val prefixes = mutable.Map.empty[Int, Long]
      // a) items that can be assembled to the last itemset of the prefix
      if (shouldSearchInCurItem) {
        partialStarts.foreach { start =>
          var i = start
          var x = -items(i)
          while (x != 0) {
            if (!prefixes.contains(x)) {
              prefixes(x) = n1 - i
            }
            i += 1
            x = -items(i)
          }
        }
      }
      // b) items that can be appended to the prefix
      var i = fullStart
      while (i < n1) {
        val x = items(i)
        if (x != 0 && !prefixes.contains(x)) {
          prefixes(x) = n1 - i
        }
        i += 1
      }
      prefixes.toIterator
    }

    /** Tests whether this postfix is non-empty. */
    def nonEmpty: Boolean = items.length > start + 1

    /**
     * Projects this postfix with respect to the input prefix item.
     * @param prefix prefix item. If prefix is positive, we match items in any full itemset; if it
     *               is negative, we do partial projections.
     * @return the projected postfix
     */
    def project(prefix: Int): Postfix = {
      require(prefix != 0)
      val n1 = items.length - 1
      var matched = false
      var newStart = n1
      val newPartialStarts = mutable.ArrayBuilder.make[Int]
      // Check if it is worth to project that prefix
      if (lastPosMap.getOrElse(math.abs(prefix), -1) <= start) {
        // It isn't, since we are past it's last pos
        new Postfix(items, firstPosMap, lastPosMap, newStart, newPartialStarts.result())
      }
      else {
        // It is, we search the sequence accordingly
        if (prefix < 0) {
          // Search for partial projections.
          val target = -prefix
          partialStarts.foreach { start =>
            var i = start
            var x = items(i)
            while (x != target && x != 0) {
              i += 1
              x = items(i)
            }
            if (x == target) {
              i += 1
              if (!matched) {
                newStart = i
                matched = true
              }
              if (items(i) != 0) {
                newPartialStarts += i
              }
            }
          }
        }
        else {
          // Search for items in full itemsets.
          // Though the items are ordered in each itemsets, they should be small in practice.
          // So a sequential scan is sufficient here, compared to bisection search.
          val target = prefix
          var i = math.max(fullStart, firstPosMap.getOrElse(target, -1))
          while (i < n1) {
            val x = items(i)
            if (x == target) {
              if (!matched) {
                newStart = i
                matched = true
              }
              if (items(i + 1) != 0) {
                newPartialStarts += i + 1
              }
            }
            i += 1
          }
        }
        new Postfix(items, firstPosMap, lastPosMap, newStart, newPartialStarts.result())
      }
    }

    /**
     * Projects this postfix with respect to the input prefix.
     */
    private def project(prefix: Array[Int]): Postfix = {
      var partial = true
      var cur = this
      var i = 0
      val np = prefix.length
      while (i < np && cur.nonEmpty) {
        val x = prefix(i)
        if (x == 0) {
          partial = false
        } else {
          if (partial) {
            cur = cur.project(-x)
          } else {
            cur = cur.project(x)
            partial = true
          }
        }
        i += 1
      }
      cur
    }

    /**
     * Projects this postfix with respect to the input prefix.
     */
    def project(prefix: Prefix): Postfix = project(prefix.items)

    /**
     * Returns the same sequence with compressed storage if possible.
     */
    def compressed: Postfix = {
      if (start > 0) {
        // Recalculate items
        val compressedSeq = items.slice(start, items.length)
        // Recalculate first and last pos map
        val newFirstPosMap = mutable.Map.empty[Int, Int]
        val newLastPosMap = mutable.Map.empty[Int, Int]
        for (i <- compressedSeq.indices) {
          val item = compressedSeq(i)
          if (item != 0) {
            if (! firstPosMap.contains(item)) {
              firstPosMap.update(item, i-1)
            }
            newLastPosMap.update(item, i)
          }
        }
        // Return compressed Postfix
        new Postfix(compressedSeq, newFirstPosMap, newLastPosMap, 0, partialStarts.map(_ - start))
      } else {
        this
      }
    }
  }

  /**
   * Represents a frequent sequence.
   * @param sequence a sequence of itemsets stored as an Array of Arrays
   * @param freq frequency
   * @tparam Item item type
   */
  @Since("1.5.0")
  class FreqSequence[Item] @Since("1.5.0") (
                                             @Since("1.5.0") val sequence: Array[Array[Item]],
                                             @Since("1.5.0") val freq: Long) extends Serializable {
    /**
     * Returns sequence as a Java List of lists for Java users.
     */
    @Since("1.5.0")
    def javaSequence: ju.List[ju.List[Item]] = sequence.map(_.toList.asJava).toList.asJava
  }
}

/**
 * Model fitted by [[PrefixSpan]]
 * @param freqSequences frequent sequences
 * @tparam Item item type
 */
@Since("1.5.0")
class PrefixSpanModel[Item] @Since("1.5.0") (
   @Since("1.5.0") val freqSequences: RDD[PrefixSpan.FreqSequence[Item]])
  extends Saveable with Serializable {

  /**
   * Save this model to the given path.
   * It only works for Item datatypes supported by DataFrames.
   *
   * This saves:
   *  - human-readable (JSON) model metadata to path/metadata/
   *  - Parquet formatted data to path/data/
   *
   * The model may be loaded using `PrefixSpanModel.load`.
   *
   * @param sc  Spark context used to save model data.
   * @param path  Path specifying the directory in which to save this model.
   *              If the directory already exists, this method throws an exception.
   */
  @Since("2.0.0")
  override def save(sc: SparkContext, path: String): Unit = {
    PrefixSpanModel.SaveLoadV1_0.save(this, path)
  }

  override protected val formatVersion: String = "1.0"
}

@Since("2.0.0")
object PrefixSpanModel extends Loader[PrefixSpanModel[_]] {

  @Since("2.0.0")
  override def load(sc: SparkContext, path: String): PrefixSpanModel[_] = {
    PrefixSpanModel.SaveLoadV1_0.load(sc, path)
  }

  private[fpm] object SaveLoadV1_0 {

    private val thisFormatVersion = "1.0"

    private val thisClassName = "org.apache.spark.mllib.fpm.PrefixSpanModel"

    def save(model: PrefixSpanModel[_], path: String): Unit = {
      val sc = model.freqSequences.sparkContext
      val spark = SparkSession.builder().sparkContext(sc).getOrCreate()

      val metadata = compact(render(
        ("class" -> thisClassName) ~ ("version" -> thisFormatVersion)))
      sc.parallelize(Seq(metadata), 1).saveAsTextFile(Loader.metadataPath(path))

      // Get the type of item class
      val sample = model.freqSequences.first().sequence(0)(0)
      val className = sample.getClass.getCanonicalName
      val classSymbol = runtimeMirror(getClass.getClassLoader).staticClass(className)
      val tpe = classSymbol.selfType

      val itemType = ScalaReflection.schemaFor(tpe).dataType
      val fields = Array(StructField("sequence", ArrayType(ArrayType(itemType))),
        StructField("freq", LongType))
      val schema = StructType(fields)
      val rowDataRDD = model.freqSequences.map { x =>
        Row(x.sequence, x.freq)
      }
      spark.createDataFrame(rowDataRDD, schema).write.parquet(Loader.dataPath(path))
    }

    def load(sc: SparkContext, path: String): PrefixSpanModel[_] = {
      implicit val formats = DefaultFormats
      val spark = SparkSession.builder().sparkContext(sc).getOrCreate()

      val (className, formatVersion, metadata) = Loader.loadMetadata(sc, path)
      assert(className == thisClassName)
      assert(formatVersion == thisFormatVersion)

      val freqSequences = spark.read.parquet(Loader.dataPath(path))
      val sample = freqSequences.select("sequence").head().get(0)
      loadImpl(freqSequences, sample)
    }

    def loadImpl[Item: ClassTag](freqSequences: DataFrame, sample: Item): PrefixSpanModel[Item] = {
      val freqSequencesRDD = freqSequences.select("sequence", "freq").rdd.map { x =>
        val sequence = x.getAs[Seq[Seq[Item]]](0).map(_.toArray).toArray
        val freq = x.getLong(1)
        new PrefixSpan.FreqSequence(sequence, freq)
      }
      new PrefixSpanModel(freqSequencesRDD)
    }
  }
}
