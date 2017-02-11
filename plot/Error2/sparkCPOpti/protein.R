

#DATA
x <- c(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99, 0.999, 0.9999)*100

sparkNP <- c(55278, 51430, 50950, 50336, 49549, 49803, 48242, 47436, 43457, 26721)/1000
sparkPPIC <-  c(93732, 90741, 91059, 90999, 91235, 91545, 88524, 86405, 75279, 35563)/1000
sparkCP <- c(79285, 77851, 76683, 76749, 76892, 77198, 74721, 72824, 64796, 34120)/1000
sparkCPMap <- c(57044, 55519, 56025, 55063, 56175, 55768, 53655, 52482, 48276, 29105)/1000

#PLOT
plot(x,sparkNP, log = "y", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(28, 105))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)

title(main="Protein", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))
box()