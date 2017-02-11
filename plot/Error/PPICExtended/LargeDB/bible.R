
#DATA
x <- c(0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10)*100

sparkNP <-c(60263, 54263, 45098, 40024, 36957, 33049, 26018, 19614, 15663, 14217)/1000
sparkPPIC <- c(53435, 45854, 40849, 35722, 32624, 26763, 21220, 15888, 13010, 11687)/1000
sparkPPICFix <- c(64754, 49177, 40795, 35623, 32083, 29039, 23515, 19016, 15753, 13789)/1000

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