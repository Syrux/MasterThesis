

#DATA
x <- c(2, 4, 6, 8, 10)

cp4d <- c(21.840, 19.239, 17.379, 16.824, 16.694)
spark1 <- c(100.039, 51.752, 34.280, 25.860, 22.003)
sparkNP <- c(28.410, 26.511, 19.532, 16.171, 14.210)
sparkPPIC <- c(29.370, 25.852, 19.365, 15.892, 13.229)
sparkPPICFix <- c(25.167, 24.804, 19.837, 15.584, 12.705)

#PLOT
plot(x,cp4d, log = "y", type="l", xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 30))
lines(x,spark1, col="red")
lines(x,sparkNP, col="green")
lines(x,sparkPPIC, col="magenta")
lines(x,sparkPPICFix, col="orange")

title(main="Leviathan", font.main=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")

#Pretty up
legend("bottomright", legend=c("Original CP4D", "Original Spark", "Spark - no permutation", "Spark - PPIC", "Spark - PPICfix413"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta", "orange"))
box()