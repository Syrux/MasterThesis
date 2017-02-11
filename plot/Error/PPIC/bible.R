
#DATA
x <- c(2, 4, 6, 8, 10)

cp4d <- c(114.346, 118.160, 154.494, 143.036, 117.609)
spark1 <- c(74.400, 41.309, 27.216, 21.614, 18.244)
sparkNP <- c(32.613, 30.725, 18.338, 14.765, 14.184)
sparkPPIC <- c(31.444, 24.466, 18.817, 14.876, 13.472)
sparkPPICFix <- c(38.414, 23.738, 18.003, 14.606, 13.153)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(12, 40))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="Bible", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()