

#DATA
x <- c(0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1)*100

sparkNP <- c(36477, 33126, 30791, 29061, 27600, 24813, 24284, 18154, 14912, 12914)/1000
sparkPPIC <- c(35661, 32428, 28209, 29043, 26603, 25373, 23578, 17899, 15229, 13639)/1000
sparkPPICFix <- c(33262, 29973, 28120, 27893, 25428, 23724, 24080, 18586, 16262, 12773)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 40))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Leviathan", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()