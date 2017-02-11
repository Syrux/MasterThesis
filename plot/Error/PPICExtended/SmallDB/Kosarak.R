
#DATA
x <- c(0.0001, 0.0002, 0.0003, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01)*100

sparkNP <- c(167320, 121293, 98226, 76204, 61322, 40828, 30018, 27505, 23504, 19560)/1000
sparkPPIC <- c(175576, 123555, 100985, 75667, 60254, 41474, 32382, 28901, 21455, 17580)/1000
sparkPPICFix <- c(161280, 117803, 97836, 73816, 58512, 39230, 30358, 30003, 21223, 17680)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(16, 190))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Kosarak", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()