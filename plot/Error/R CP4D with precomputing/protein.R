

#DATA
xLabel <- c("2", "4", "6", "8", "10")
x <- c(1:5)

cp4d <- c(388.204, 218.849, 124.911, 71.952, 54.870)
spark1 <- c(100000, 100000, 100000, 6659.712, 1088.813)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(5, 7000))
lines(x,spark1, col="red")

#Pretty up
title(main="Protein", font.main=4)
legend("bottomleft", legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()