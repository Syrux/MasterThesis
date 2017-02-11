

#DATA
x <- c(99.97, 99.975, 99.98, 99.985, 99.99)

cp4d <- c(388.204, 218.849, 124.911, 71.952, 54.870)
spark1 <- c(100000, 100000, 100000, 6659.712, 1088.813)
sparkNP <- c(43.646, 43.840, 45.509, 38.365, 31.493)
sparkPPIC <- c(64.191, 63.919, 63.475, 53.843, 42.103)
sparkPPICFix <- c(64.260, 63.427, 62.178, 52.579, 44.998)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(28, 70))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="Protein", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()