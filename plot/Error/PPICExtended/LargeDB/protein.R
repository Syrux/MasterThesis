

#DATA
x <- c(0.999, 0.99915, 0.99935, 0.9995, 0.9996, 0.9997, 0.99975, 0.9998, 0.99985, 0.9999)*100

sparkNP <- c(40548, 38753, 40644, 39458, 38480, 39168, 39193, 39099, 31610, 27942)/1000
sparkPPIC <- c(82705, 77973, 78778, 76048, 75911, 74990, 75529, 75922, 53568, 39946)/1000
sparkPPICFix <-  c(81977, 78602, 79576, 74680, 75321, 74867, 75642, 74382, 52559, 39312)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(25, 115))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="Protein", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()