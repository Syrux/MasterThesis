

#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1)*100

sparkNP <- c(46158, 45680, 45459, 32050, 28681, 25844, 23952, 22844, 23066, 20881, 15871, 13570, 10950)/1000
sparkPPIC <- c(43821, 44890, 43332, 30700, 26875, 23309, 21684, 20830, 18820, 19282, 14316, 11799, 10157)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 50))
lines(x,sparkPPIC, col="red", type="o", pch=1)

title(main="Leviathan", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
box()