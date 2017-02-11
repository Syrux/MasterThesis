

#DATA
xLabel <- c("2", "4", "6", "8", "10")
x <- c(1:5)

cp4d <- c(21.840, 19.239, 17.379, 16.824, 16.694)
spark1 <- c(228.016, 72.690, 38.427, 25.575, 17.443)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(10, 230))
lines(x,spark1, col="red")

#Pretty up
title(main="Leviathan", font.main=4)
legend("topright", legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()