
#DATA
xLabel <- c("6", "10", "14", "18", "22")
x <- c(1:5)

cp4d <- c(197.944, 43.147, 24.529, 23.317, 22.095)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", xaxt='n', ylim=c(20, 10000))

#Pretty up
title(main="Fifa", font.main=4)
legend("topright", legend=c("CP4D", "Spark - 1 thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
axis(1, at=1:5, lab=xLabel)
box()