
#DATA
xLabel <- c("0.2", "0.4", "0.6", "0.8", "1.0")
x <- c(1:5)

cp4d <- c(262.589, 262.037, 261.587, 256.581, 272.613)
spark1 <- c(111.086, 50.986, 35.638, 31.816, 21.442)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(10, 300))
lines(x,spark1, col="red")

#Pretty up
title(main="Kosarak", font.main=4)
legend(3.75, 175, legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()