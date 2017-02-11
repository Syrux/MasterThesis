

#DATA
x <- c(0.00025, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100

sparkNP <- c(74205, 58248, 46808, 34329, 32588, 30497, 27160, 24104, 20786, 19129)/1000
sparkPPIC <- c(64948, 52698, 43678, 37451, 33663, 30943, 28196, 25974, 20638, 17336)/1000
sparkPPICFix <- c(73048, 56394, 46570, 38782, 34183, 31619, 29883, 26423, 20791, 17968)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 75))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkPPICFix, col="green", type="o", pch=4)

title(main="PubMed", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"))
box()