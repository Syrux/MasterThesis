

#DATA
x <- c(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99, 0.999, 0.9999)*100

sparkNP <- c(55278, 51430, 50950, 50336, 49549, 49803, 48242, 47436, 43457, 26721)/1000
sparkPPIC <-  c(104139, 100608, 101008, 101328, 102937, 100632, 97426, 94960, 82830, 37793)/1000

#PLOT
plot(x,sparkNP, log = "y", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(28, 105))
lines(x,sparkPPIC, col="red", type="o", pch=1)

title(main="Protein", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue","red"))
box()