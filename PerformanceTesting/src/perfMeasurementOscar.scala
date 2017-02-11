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

import breeze.generic.UFunc
import cp4d.spm.Main

// scalastyle:off
object perfMeasurementOscar {

  def getCurrentDirectory = new java.io.File(".").getCanonicalPath

  def main(args: Array[String]) {

    val startDataSet = args(0).toInt

    //Setting up datasets list
    //val datasets = Array("test")
    val datasets = Array("test", "BIBLE", "protein", "Kosarak", "LEVIATHAN", "PubMed", "FIFA").drop(startDataSet)
    val generalPath = getCurrentDirectory + "\\dataset\\"
    /*
    val minSupList = collection.immutable.HashMap(
      "BIBLE" -> Array(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10).reverse,
      "FIFA" -> Array(0.0001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22).reverse,
      "Kosarak" -> Array(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01).reverse,
      "LEVIATHAN" -> Array(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1).reverse,
      "protein" -> Array(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99, 0.999, 0.9999).reverse,
      "PubMed" -> Array(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05).reverse,
      "test" -> Array(1, 0.21, 0.19))
     */

    val minSupList = collection.immutable.HashMap(
      "BIBLE" -> Array(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01).reverse,
      "FIFA" -> Array(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14).reverse,
      "Kosarak" -> Array(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030).reverse,
      "LEVIATHAN" -> Array(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1).reverse,
      "protein" -> Array(0.9998, 0.99982, 0.99984, 0.99986, 0.99988, 0.9999).reverse,
      "PubMed" -> Array(0.005, 0.01, 0.02, 0.03, 0.04, 0.05).reverse,
      "test" -> Array(1, 0.21, 0.19).reverse)

    //Start a printwriter to write results
    val pw = new PrintWriter(new File(getCurrentDirectory + "\\results\\cp4dPerfMesurement.txt" ))
    pw.println("PPIC Original : ")
    pw.flush()
    //Iter on datasets
    datasets.foreach(fileName => {
      //Find path to file
      val currentPath = generalPath + fileName + ".txt"
      //Get list of support ot use
      val listSupport = minSupList.get(fileName).get

      pw.print(fileName + ".txt : c(")
      pw.flush()
      //Iter on support list
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
    pw.close
  }
}
