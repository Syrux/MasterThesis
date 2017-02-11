/**
  * Created by Cyril on 17-10-16.
  */
object Exec {

  def main(args: Array[String]) {
    if (args.contains("test")) {
      testSol.main(Array(""))
    }
    else if (args.contains("oscar")) {
      perfMeasurementOscar.main(Array(args(args.length - 1)))
    }
    else if (args.contains("multi")) {
      perfMultiItem.main(Array(args(args.length - 1)))
    }
    else if (args.contains("all")) {
      perfMeasurementSpark.main(Array(args(args.length - 1)))
      perfMultiItem.main(Array(args(args.length - 1)))
    }
    else perfMeasurementSpark.main(Array(args(args.length - 1)))
  }
}
