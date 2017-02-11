
#DATA
xLabel <- c("6", "10", "14", "18", "22")
x <- c(1:5)

cp4d <- c(197.944, 43.147, 24.529, 23.317, 22.095)
spark1 <- c(11266.373, 5270.773, 3396.916, 2812.601, 1650.616)
spark3 <- c(6203.094, 3078.165, 1990.103, 1474.381, 871.219)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(20, 10000))
lines(x,spark1, col="red")
lines(x,spark3, col="green")

#Pretty up
title(main="Fifa", font.main=4)
legend(2, 1000, legend=c("CP4D", "Spark - 1 thread", "Spark - 3 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red","green"))
axis(1, at=1:5, lab=xLabel)
box()