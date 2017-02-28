/**
  * Created by Cyril on 17-10-16.
  */
object Exec {

  def main(args: Array[String]) {
    testRunner.run(args(0), args(1), args(2).toInt, args(3).toBoolean, args(4).toInt, args(5).toLong)
  }
}
