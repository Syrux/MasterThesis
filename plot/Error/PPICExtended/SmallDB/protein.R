

#DATA
x <- c(0.999, 0.99915, 0.99935, 0.9995, 0.9996, 0.9997, 0.99975, 0.9998, 0.99985, 0.9999)*100

sparkNP <- c(37440, 36814, 37426, 36871, 36518, 37131, 37261, 36858, 32118, 27765)/1000
sparkPPIC <- c(62216, 62097, 62056, 59314, 58238, 58679, 58918, 59253, 48997, 39607)/1000
sparkPPICFix <- c(61614, 62746, 65034, 59326, 58920, 59617, 59181, 60629, 51609, 44076)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(25, 80))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Protein", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()