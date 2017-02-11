
#DATA
x <- c(0.0001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

sparkNP <- c(47572, 35631, 32278, 31381, 30496, 29192, 28357, 27400, 27380, 28040, 21667, 14598, 14651, 13294)/1000
sparkPPIC <- c(43620, 34604, 32904, 32074, 31306, 29560, 29193, 29855, 28350, 27236, 21180, 14881, 14039, 13432)/1000
sparkCP <- c(44156, 34983, 32533, 31479, 30846, 30753, 28866, 28138, 27500, 27240, 21399, 15190, 14230, 13643)/1000
sparkCPMap <- c(42092, 33278, 31266, 30363, 29952, 29504, 31709, 30803, 30887, 27909, 21048, 14835, 15960, 13607)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(13, 52))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)

title(main="Fifa", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("topright", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))
box()