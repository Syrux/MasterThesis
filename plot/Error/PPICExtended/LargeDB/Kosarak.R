
#DATA
x <- c(0.0001, 0.0002, 0.0003, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01)*100

sparkNP <- c(184236, 134600, 102719, 77946, 63363, 42784, 34452, 28602, 21790, 17884)/1000
sparkPPIC <- c(152073, 106510, 87706, 68335, 52607, 39712, 29934, 27403, 21633, 17136)/1000
sparkPPICFix <- c(154770, 110804, 93265, 71897, 51241, 45040, 29577, 26764, 21146, 17153)/1000

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