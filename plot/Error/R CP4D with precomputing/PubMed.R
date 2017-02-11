

#DATA
xLabel <- c("1", "2", "3", "4", "5")
x <- c(1:5)

cp4d <- c(95.263, 91.984, 93.220, 90.379, 90.256)
spark1 <- c(638.488, 239.774, 137.777, 87.342, 62.884)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(25, 650))
lines(x,spark1, col="red")

#Pretty up
title(main="PubMed", font.main=4)
legend("topright", legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()