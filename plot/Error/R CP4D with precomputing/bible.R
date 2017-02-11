
#DATA
xLabel <- c("2", "4", "6", "8", "10")
x <- c(1:5)

cp4d <- c(114.346, 118.160, 154.494, 143.036, 117.609)
spark1 <- c(86.938, 42.173, 26.006, 18.844, 15.533)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(5, 150))
lines(x,spark1, col="red")

#Pretty up
title(main="Bible", font.main=4)
legend("bottomleft", legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()