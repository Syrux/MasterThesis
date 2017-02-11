
#DATA
x <- c(0.0001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

sparkNP <- c(47572, 35631, 32278, 31381, 30496, 29192, 28357, 27400, 27380, 28040, 21667, 14598, 14651, 13294)/1000
sparkPPIC <- c(48502, 36374, 34180, 32684, 32183, 30046, 29334, 28443, 28267, 28338, 21362, 14963, 14868, 14048)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(13, 52))
lines(x,sparkPPIC, col="red", type="o", pch=1)

title(main="Fifa", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
box()