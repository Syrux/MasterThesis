

#DATA
x <- c(0.00025, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100

sparkNP <- c(65897, 56263, 42644, 34214, 32020, 28392, 25265, 23910, 18404, 15484)/1000
sparkPPIC <- c(64554, 52053, 43117, 36128, 32926, 29559, 26404, 24343, 20227, 18149)/1000
sparkPPICFix <- c(59520, 47278, 39550, 34553, 30944, 28448, 27380, 23590, 19460, 16898)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 75))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="PubMed", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()