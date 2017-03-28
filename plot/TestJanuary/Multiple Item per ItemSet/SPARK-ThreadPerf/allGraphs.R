
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,2))
# 300 partitions everywhere (except PPIC, of course)

#BIBLE 
#DATA
x <- rev(c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01)*100)

SPARK1 <- c(114107, 126391, 140136, 155748, 178000, 213450, 272376, 362698, 596383, 1480595)/1000
SPARK2 <- c(92575, 96471, 110478, 129614, 137429, 191352, 225391, 327205, 542348, 1369842)/1000
SPARK3 <- c(93233, 96080, 108520, 125090, 139021, 179538, 222188, 319475, 525124, 1333034)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(90, 1500))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#KOSARAK 
#DATA
x <- rev(c(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030)*100)

SPARK1 <- c(80059, 84358, 88428, 94744, 101342, 111438)/1000
SPARK2 <- c(52300, 52439, 57238, 62720, 67259, 75563)/1000
SPARK3 <- c(49016, 44831, 49684, 55926, 57799, 65936)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(38, 115))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#SLEN1 
#DATA
x <- rev(c(0.0013, 0.00135, 0.0014, 0.00145, 0.0015, 0.00155, 0.0016, 0.00165, 0.0017)*100)

SPARK1 <- c(43821, 52414, 58447, 60516, 62678, 69529, 77150, 81915, 83912)/1000
SPARK2 <- c(27830, 34787, 45619, 43921, 47507, 47927, 54219, 60764, 60416)/1000
SPARK3 <- c(25217, 32022, 39812, 42580, 41822, 41718, 47961, 52161, 52206)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(24, 85))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Slen1", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#SLEN2 
#DATA
x <- rev(c(0.0011, 0.00115, 0.0012, 0.00125, 0.0013, 0.00135, 0.0014, 0.00145, 0.0015)*100)

SPARK1 <- c(47257, 50336, 54330, 63425, 69000, 71349, 79439, 88582, 94758)/1000
SPARK2 <- c(28705, 30345, 34667, 41832, 45693, 47973, 54399, 59502, 62637)/1000
SPARK3 <- c(28329, 27562, 30243, 35984, 40281, 42799, 46565, 54039, 54243)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(27, 100))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Slen2", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#dev.off()