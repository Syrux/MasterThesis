
#DATA
x <- c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

sparkNP <- c(34362, 31702, 31288, 30357, 29803, 30097, 23195, 16482, 15172, 15020)/1000
sparkPPIC <- c(35859, 31879, 32085, 31010, 30922, 30238, 23762, 16783, 15686, 14837)/1000
sparkPPICFix <- c(34376, 32213, 32184, 32603, 29807, 29200, 22768, 16118, 15352, 14551)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(13, 40))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Fifa", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()