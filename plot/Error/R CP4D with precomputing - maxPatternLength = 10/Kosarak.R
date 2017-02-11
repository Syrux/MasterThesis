
#DATA
xLabel <- c("0.2", "0.4", "0.6", "0.8", "1.0")
x <- c(1:5)

cp4d <- c(262.589, 262.037, 261.587, 256.581, 272.613)
spark1 <- c(108.297, 49.781, 38.638, 32.163, 25.873)
spark3 <- c(64.971, 29.327, 19.752, 14.670, 12.034)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(10, 300))
lines(x,spark1, col="red")
lines(x,spark3, col="green")

#Pretty up
title(main="Kosarak", font.main=4)
legend(3.75, 175, legend=c("CP4D", "Spark - 1 thread", "Spark - 3 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red","green"))
axis(1, at=1:5, lab=xLabel)
box()