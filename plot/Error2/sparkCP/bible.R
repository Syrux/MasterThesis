
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10)*100

sparkNP <-c(173812, 161610, 131754, 53738, 44395, 34756, 30610, 27974, 24947, 19987, 15044, 12239, 10914)/1000
sparkPPIC <- c(150723, 115710, 84153, 48707, 40943, 33764, 30361, 27948, 24831, 19688, 14911, 12159, 10918)/1000
sparkCP <- c(174918, 134047, 94492, 52838, 44268, 35571, 31890, 28635, 26119, 20543, 15576, 12683, 11354)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(12, 200))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)

title(main="Bible", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()