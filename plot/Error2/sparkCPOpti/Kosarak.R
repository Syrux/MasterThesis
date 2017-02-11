
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01)*100

sparkNP <- c(411088, 199180, 145584, 67172, 48482, 35759, 28412, 25772, 19962, 16535)/1000
sparkPPIC <- c(387796, 183518, 139266, 63920, 52935, 35868, 28153, 25438, 20055, 16337)/1000
sparkCP <- c(444306, 213002, 155303, 69194, 50479, 37326, 28859, 26186, 20662, 17155)/1000
sparkCPMap <- c(416308, 204533, 142086, 65316, 47757, 35975, 28106, 25704, 20228, 16726)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(16, 500))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)

title(main="Kosarak", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))
box()