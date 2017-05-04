/**
  * Created by Cyril on 17-10-16.
  */
object Exec {

  def main(args: Array[String]) {
    //testOriginalPPIC.run(args(0), args.drop(1))
    testOriginalSpark.run(args(0), args(1).toInt, args(2).toLong, args.drop(3))
    //baseTestRunner.run(args(0), args(1).toBoolean, args(2).toInt, args(3).toLong, args.drop(4))
    /*
    localTestRunner.run(args(0), args(1).toBoolean, args(2).toInt, args(3).toInt, args(4)
      .toLong, args(5).toInt, args(6).toInt, args.drop(7))
      */
    /*
    automatedTestRunner.run(args(0), args(1).toInt, args(2).toInt, args(3).toLong, args(4)
      .toInt, args(5).toInt, args.drop(6))
      */
  }
}