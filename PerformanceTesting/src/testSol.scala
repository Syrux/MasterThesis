import org.apache.spark.rdd.RDD

/**
  * Created by Cyril on 11-11-16.
  */
object testSol {

  import java.io._
  import org.apache.spark.{SparkConf, SparkContext}
  import org.apache.log4j.{Level, Logger}
  import org.apache.spark.mllib.fpm.PrefixSpan

  def getCurrentDirectory = new java.io.File(".").getCanonicalPath

  def main(args: Array[String]) {

    //Spark - original - no permutation

    // Properties
    System.setProperty("hadoop.home.dir", getCurrentDirectory + "\\fix")
    // Windows bug fix
    Logger.getLogger("org").setLevel(Level.ERROR) // Control log data shown - Show only error in log
    Logger.getLogger("akka").setLevel(Level.ERROR) // Control log data shown - Show only error in log

    // Delete old output folder
    // FileUtils.deleteDirectory(new File(outputFile))

    // Setting up Spark
    val conf = new SparkConf().setAppName("fpmPS").setMaster("local[1]")
    //val conf = new SparkConf().setAppName("fpmPS").setMaster("spark://master:7077")
    conf.set("spark.hadoop.validateOutputSpecs", "false") // Allow outputDir overwrite
    val sc = new SparkContext(conf)

    //Iter on datasets
    val generalPath = getCurrentDirectory + "\\dataset\\"
    val fileName = "BIBLE"
    //val fileName = "test"
    val currentPath = generalPath + fileName + ".txt"
    val curSupport = 0.1

    //SPARK
    //Get Array(Array(char)) from file
    val seq = scala.io.Source.fromFile(currentPath).getLines().toSeq.map(x => x.split(" ").map(x=> Array(x)))
    val sequences = sc.parallelize(seq, 2)

    //Run algorithm
    val prefixSpan = new PrefixSpan()
      .setMinSupport(curSupport)
      .setMaxPatternLength(0)
      .setMaxLocalProjDBSize(6400000000L)
      .setOutPutItemSetPermutation(false)


    val pw = new PrintWriter(new File(getCurrentDirectory + "\\results\\sparkTestSol.txt"))
    pw.println(new PrefixSpan().getVersion)
    pw.flush()

    //Something else for local execution
    val model = prefixSpan.run(sequences)
    model.freqSequences.collect().foreach { freqSequence =>
      pw.println(
        freqSequence.sequence.map(_.mkString("[", ", ", "]")).mkString("[", ", ", "]") +
          ", " + freqSequence.freq)
    }
    pw.flush()
    pw.close()

    val args = Array(currentPath, "1", "0", "-s", "0.1", "-v")
    cp4d.spm.examples.PPmain.main(args)
  }
}
