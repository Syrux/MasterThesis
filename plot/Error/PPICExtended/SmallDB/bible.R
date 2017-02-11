
#DATA
x <- c(0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10)*100

sparkNP <- c(57071, 47126, 38161, 33259, 30136, 26762, 21032, 17067, 13184, 11661)/1000
sparkPPIC <- c(52977, 46155, 36608, 33405, 29968, 27072, 20998, 17290, 14133, 11952)/1000
sparkPPICFix <- c(51979, 47755, 37748, 35567, 32462, 28155, 22532, 16551, 13447, 12393)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(12, 70))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Bible", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()