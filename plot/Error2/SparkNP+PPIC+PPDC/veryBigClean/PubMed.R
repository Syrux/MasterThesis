

#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100

sparkNP <- c(157983, 154492, 91034, 46987, 38834, 31699, 29509, 28272, 23992, 22035, 17337, 15673)/1000
sparkPPIC <- c(128653, 124927, 75712, 43018, 36441, 31046, 28413, 26053, 23717, 22047, 17110, 14647)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 170))
lines(x,sparkPPIC, col="red", type="o", pch=1)

title(main="PubMed", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
box()