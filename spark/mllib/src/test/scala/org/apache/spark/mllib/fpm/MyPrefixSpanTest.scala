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

// scalastyle:off
import org.apache.log4j.{Level, Logger}
import org.apache.spark.{SparkConf, SparkContext}

object MyPrefixSpanTest {

  def main(args: Array[String]) {

    // Properties
    System.setProperty("hadoop.home.dir", """F:\Memoire\Code\Miscelanious\HadoopFix""")
    // Windows bug fix
    Logger.getLogger("org").setLevel(Level.WARN) // Control log data shown - Show only error in log
    Logger.getLogger("akka").setLevel(Level.WARN) // Control log data shown - Show only error in log

    // Delete old output folder
    // FileUtils.deleteDirectory(new File(outputFile))

    // Setting up Spark
    val conf = new SparkConf().setAppName("wordCount").setMaster("local[1]")
    conf.set("spark.hadoop.validateOutputSpecs", "false") // Allow outputDir overwrite
    val sc = new SparkContext(conf)

    /*
    val sequences = sc.parallelize(Seq(
      Array(Array(1, 2), Array(1), Array(2), Array(3), Array(4), Array(2)),
      Array(Array(1, 2), Array(3), Array(4))
    ), 2).cache() // ,2 = num slices
    */

    // val sequences = sc.parallelize(Seq(Array(Array(5, 6), Array(1, 2, 3), Array(1, 2, 3, 4))), 2).cache()

    /*
    val sequences = sc.parallelize(Seq(
      Array(Array(2), Array(1), Array(2), Array(3), Array(4), Array(2)),
      Array(Array(2), Array(3), Array(4))
    ), 2).cache() // ,2 = num slices
    */

    /*
    val sequences = sc.parallelize(Seq(
      Array(Array(1), Array(3), Array(4), Array(5)),
      Array(Array(2), Array(3), Array(1)),
      Array(Array(2), Array(4), Array(1)),
      Array(Array(3), Array(1), Array(3), Array(4), Array(5)),
      Array(Array(3), Array(4), Array(4), Array(3)),
      Array(Array(6), Array(5), Array(3))
    ))
    val curSupport = 0.1
    */

    /*
    val sequences = sc.parallelize(Seq(
      Array(Array(1), Array(1, 2, 3), Array(1, 3), Array(4), Array(3, 6)),
      Array(Array(1, 4), Array(3), Array(2, 3), Array(1, 5)),
      Array(Array(5, 6), Array(1, 2), Array(4, 6), Array(3), Array(2)),
      Array(Array(5), Array(7), Array(1, 6), Array(3), Array(2), Array(3))
    ), 2)
    */

    //Kosarak
    /*
    val generalPath = """F:\Memoire\dataset\Kosarak\"""
    val fileName = "Kosarak"
    val currentPath = generalPath + fileName + ".txt"
    val curSupport = 0.005
    */

    //BIBLE
    val generalPath = """F:\Memoire\dataset\BIBLE\"""
    val fileName = "BIBLE"
    val currentPath = generalPath + fileName + ".txt"
    val curSupport = 0.1
    val sequences = sc.parallelize(scala.io.Source.fromFile(currentPath).getLines().toSeq.map(x => x.split(" ").map(x=> Array(x))), 2)

    //SLEN
    /*
    val generalPath = """F:\Memoire\dataset\MultyItemSet\"""
    val fileName = "slen1"
    val currentPath = generalPath + fileName + ".txt"
    val curSupport = 0.00165 //7 or 5
    val sequences = sc.parallelize(scala.io.Source.fromFile(currentPath).getLines().toSeq.map(x => x.split(" -1 ").filter(x => !x.equals("")).map(x=> x.split(" "))), 2)
    */

    //Print checker for correct reading
    //sequences.foreach(x => println(x.deep.mkString("; ")))

    val startTime = System.nanoTime()

    val prefixSpan = new PrefixSpan()
      .setMinSupport(curSupport)
      .setMaxPatternLength(10)
      .setMaxLocalProjDBSize(6400000000L) //=> 0 for complete execution in RDD
      //Something else for local execution
    val model = prefixSpan.run(sequences)
    var counter = 0
    model.freqSequences.collect().foreach { freqSequence =>
      counter+=1
      println(
        freqSequence.sequence.map(_.mkString("[", ", ", "]")).mkString("[", ", ", "]") +
          ", " + freqSequence.freq)
    }
    println(counter)

    val endTime = System.nanoTime()
    val duration = endTime - startTime
    println()
    println("Execution time : " + duration/1000000 + " ms")
    //Execution time full RDD : 1153 ms
    //Execution time full local : 972 ms
  }
}
