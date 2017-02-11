
#DATA
xLabel <- c("100", "21", "19")
x <- c(1, 2, 3)

cp4d <- c(483, 24, 4)
spark1 <- c(6667, 2104, 1687)
spark3 <- c(3307, 1154, 951)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (ms logscale)", col="blue", xaxt='n', ylim=c(1, 10000))
lines(x,spark1, col="red")
lines(x,spark3, col="green")

#Pretty up
title(main="Test", font.main=4)
legend("bottomleft", legend=c("CP4D", "Spark - 1 thread", "Spark - 3 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red","green"))
axis(1, at=1:3, lab=xLabel)
box()