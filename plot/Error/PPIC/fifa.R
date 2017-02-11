
#DATA
x <- c(6, 10, 14, 18, 22)

cp4d <- c(197.944, 43.147, 24.529, 23.317, 22.095)
spark1 <- c(11266.373, 5270.773, 3396.916, 2812.601, 1650.616)
sparkNP <- c(32.565, 25.541, 17.730, 16.540, 17.015)
sparkPPIC <- c(33.708, 26.490, 18.249, 20.297, 21.421)
sparkPPICFix <- c(32.829, 25.876, 17.727, 16.883, 16.217)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 35))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="Fifa", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
#legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()