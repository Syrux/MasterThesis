
#DATA
x <- c(0.2, 0.4, 0.6, 0.8, 1.0)

cp4d <- c(262.589, 262.037, 261.587, 256.581, 272.613)
spark1 <- c(108.297, 49.781, 38.638, 32.163, 25.873)
sparkNP <- c(44.389, 34.931, 31.863, 25.149, 20.716)
sparkPPIC <- c(43.858, 34.967, 31.483, 24.314, 19.117)
sparkPPICFix <- c(43.559, 33.130, 30.081, 24.420, 20.054)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(18, 45))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="Kosarak", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()