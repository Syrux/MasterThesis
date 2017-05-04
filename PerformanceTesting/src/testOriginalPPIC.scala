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

// scalastyle:off
object testOriginalPPIC {

  //def getCurrentDirectory = new File("/home/ucl/ingi/cdvog/Transfert").getCanonicalPath
  def getCurrentDirectory = new File("..").getCanonicalPath

  def run(testName: String, datasetsToConsider: Array[String]) {

    //Setting up datasets list
    val datasets =
    if (datasetsToConsider.isEmpty) {
      Array("BIBLE", "protein", "Kosarak", "LEVIATHAN", "PubMed", "FIFA")
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
      pw.print(fileName + ".txt : c(")
      pw.flush()

      //Iter on support list
      val listSupport = minSupList.get(fileName).get
      listSupport.foreach(curSupport => {

        //Measure execution time
        val startTime = System.nanoTime()

        val args = Array(currentPath, "1", "0", "-s", curSupport.toString)
        cp4d.spm.examples.PPmain.main(args)

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
