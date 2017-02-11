

#DATA
x <- c(1:5)

cp4d <- c(95.263, 91.984, 93.220, 90.379, 90.256)
spark1 <- c(238.432, 102.439, 69.099, 50.578, 46.052)
sparkNP <- c(32.332, 29.791, 26.947, 21.476, 18.383)
sparkPPIC <- c(32.409, 29.315, 27.938, 22.074, 18.467)
sparkPPICFix <- c(31.566, 28.751, 27.478, 20.915, 17.810)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(16, 33))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="PubMed", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()