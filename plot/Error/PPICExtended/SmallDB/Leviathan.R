

#DATA
x <- c(0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1)*100

sparkNP <- c(34236, 30941, 27455, 26496, 24558, 22782, 21977, 17071, 14033, 11999)/1000
sparkPPIC <- c(40896, 36172, 32619, 27119, 25014, 23807, 22564, 18225, 15235, 12114)/1000
sparkPPICFix <- c(39270, 33916, 30895, 29503, 27848, 25643, 25553, 19696, 16285, 13368)/1000

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