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

import java.io._
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.log4j.{Level, Logger}
import org.apache.spark.mllib.fpm.PrefixSpan

// scalastyle:off
object testOriginalSpark {

  def getCurrentDirectory = new File("/home/ucl/ingi/cdvog/Transfert").getCanonicalPath
  //def getCurrentDirectory = new File("..").getCanonicalPath

  def run(testName: String, maxPatLength: Int, projDatabaseSize: Long,
          datasetsToConsider: Array[String]) {

    // Properties
    //System.setProperty("hadoop.home.dir", getCurrentDirectory + "\\fix")
    Logger.getLogger("org").setLevel(Level.WARN) // Control log data shown - Show only error in log
    Logger.getLogger("akka").setLevel(Level.WARN) // Control log data shown - Show only error in log

    // Delete old output folder
    // FileUtils.deleteDirectory(new File(outputFile))

    // Setting up Spark
    val conf = new SparkConf().setAppName("testOriginal")
    //val conf = new SparkConf().setAppName("fpmPS").setMaster("spark://master:7077")
    //val conf = new SparkConf().setAppName("fpmPS").setMaster("local[*]")

    conf.set("spark.hadoop.validateOutputSpecs", "false") // Allow outputDir overwrite
    val sc = new SparkContext(conf)

    //Setting up datasets list
    val datasets =
    if (datasetsToConsider.isEmpty) {
      Array("BIBLE", "protein", "Kosarak", "LEVIATHAN", "PubMed", "FIFA", "slen1", "slen2", "slen3")
    }
    else {
      datasetsToConsider
    }

    val datasetPath = getCurrentDirectory + "/dataset/"

    val minSupList = collection.immutable.HashMap(
      "BIBLE" -> Array(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01).reverse,
      "FIFA" -> Array(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14).reverse,
      "Kosarak" -> Array(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030).reverse,
      "LEVIATHAN" -> Array(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1).reverse,
      "protein" -> Array(0.99986, 0.99987, 0.99988, 0.9999).reverse,
      "slen1" -> Array(0.0013, 0.00135, 0.0014, 0.00145, 0.0015, 0.00155, 0.0016, 0.00165, 0.0017).reverse,
      "slen2" -> Array(0.0011, 0.00115, 0.0012, 0.00125, 0.0013, 0.00135, 0.0014, 0.00145, 0.0015).reverse,
      "slen3" -> Array(0.0004, 0.0005, 0.0006, 0.0007, 0.0008, 0.0009, 0.001).reverse,
      "PubMed" -> Array(0.005, 0.01, 0.02, 0.03, 0.04, 0.05).reverse)

    val testSupList = collection.immutable.HashMap(
      "BIBLE" -> 0.1,
      "FIFA" -> 0.2,
      "Kosarak" -> 0.01,
      "LEVIATHAN" -> 0.1,
      "protein" -> 0.9999,
      "slen1" -> 0.002,
      "slen2" -> 0.002,
      "slen3" -> 0.001,
      "PubMed" -> 0.1)

    val answerList = collection.immutable.HashMap(
      "BIBLE" -> 174,
      "FIFA" -> 938,
      "Kosarak" -> 384,
      "LEVIATHAN" -> 651,
      "protein" -> 127,
      "slen1" -> 2214,
      "slen2" -> 114,
      "slen3" -> 26612,
      "PubMed" -> 558)

    val partitionList = collection.immutable.HashMap(
      "BIBLE" -> 250,
      "FIFA" -> 300,
      "Kosarak" -> 250,
      "LEVIATHAN" -> 100,
      "protein" -> 5000,
      "slen1" -> 500,
      "slen2" -> 500,
      "slen3" -> 1000,
      "PubMed" -> 200)

    //Start a printwriter to write results
    val pw = new PrintWriter(new File(getCurrentDirectory + "/results/" + testName + ".txt" ))
    pw.println(testName)
    pw.flush()

    //Iter on datasets
    datasets.foreach(fileName => {

      //Find path to file
      val currentPath = datasetPath + fileName + ".txt"
      val nbPartitions = partitionList.get(fileName).get
      val sequences =
        if (fileName != "slen1" && fileName != "slen2" && fileName != "slen3") {
          sc.parallelize(scala.io.Source.fromFile(currentPath).getLines().toSeq.map(x
          => x.split(" ").map(x=> Array(x))), nbPartitions)
        }
        else {
          sc.parallelize(scala.io.Source.fromFile(currentPath).getLines().toSeq.map(x
          => x.split(" -1 ").filter(x => !x.equals("")).map(x=> x.split(" "))), nbPartitions)
        }

      //Test
      val testSupport = testSupList.get(fileName).get
      val answer = answerList.get(fileName).get

      val testRunner = new PrefixSpan()
        .setMinSupport(testSupport)
        .setMaxPatternLength(10000)
        .setMaxLocalProjDBSize(32000000)

      val testModel = testRunner.run(sequences)
      val testResult = testModel.freqSequences.count()
      if (testResult != answer) {
        pw.println(fileName + " ERROR : found " + testResult + " instead of " + answer + " !")
        pw.print(fileName + ".txt : c(")
        pw.flush()
      }
      else {
        pw.print(fileName + ".txt : c(")
        pw.flush()
      }

      //Iter on support list
      val listSupport = minSupList.get(fileName).get
      listSupport.foreach(curSupport => {

        //Measure execution time
        val startTime = System.nanoTime()

        //Run algorithm
        val prefixSpan = new PrefixSpan()
          .setMinSupport(curSupport)
          .setMaxPatternLength(maxPatLength)
          .setMaxLocalProjDBSize(projDatabaseSize)

        //Something else for local execution
        val model = prefixSpan.run(sequences)
        model.freqSequences.collect()/*.foreach { freqSequence =>
          println(
            freqSequence.sequence.map(_.mkString("[", ", ", "]")).mkString("[", ", ", "]") +
              ", " + freqSequence.freq)
        }*/

        //End time recording
        val endTime = System.nanoTime()
        val duration = endTime - startTime

        pw.print("" + duration / 1000000 + ", ")// in ms
        pw.flush()
      })
      pw.println(")")
    })
    System.gc()
    pw.close
  }
}
