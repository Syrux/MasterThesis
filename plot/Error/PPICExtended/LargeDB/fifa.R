
#DATA
x <- c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

sparkNP <- c(39743, 32275, 31040, 29145, 29512, 29384, 23609, 16009, 14830, 14620)/1000
sparkPPIC <- c(35660, 32930, 31950, 32047, 30476, 31067, 23467, 17283, 15681, 14942)/1000
sparkPPICFix <- c(38559, 36445, 35425, 34221, 33648, 32804, 25591, 18053, 17022, 16408)/1000

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