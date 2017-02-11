

#DATA
xLabel <- c("1", "2", "3", "4", "5")
x <- c(1:5)

cp4d <- c(95.263, 91.984, 93.220, 90.379, 90.256)
spark1 <- c(238.432, 102.439, 69.099, 50.578, 46.052)
spark3 <- c(135.144, 63.451, 49.058, 31.638, 27.555)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(25, 250))
lines(x,spark1, col="red")
lines(x,spark3, col="green")

#Pretty up
title(main="PubMed", font.main=4)
legend("topright", legend=c("CP4D", "Spark - 1 thread", "Spark - 3 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red","green"))
axis(1, at=1:5, lab=xLabel)
box()