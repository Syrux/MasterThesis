
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))
# 300 partitions everywhere (except PPIC, of course)

#BIBLE 
#DATA
x <- rev(c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01)*100)

PPIC1 <- c(72493, 71476, 73961, 77192, 79149, 83273, 96695, 99406, 126792, 303826)/1000
PPIC2 <- c(52387, 50332, 52763, 53414, 54407, 59751, 63141, 71065, 89616, 234301)/1000
PPIC3 <- c(44362, 44295, 44588, 46997, 48096, 52959, 58870, 64556, 83601, 225868)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(40, 350))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#FIFA 
#DATA
x <- rev(c(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14)*100)

PPIC1 <- c(56639, 53848, 67270, 92645, 130974, 139763, 158870, 245169)/1000
PPIC2 <- c(33459, 30840, 39498, 46861, 56113, 70569, 90993, 153817)/1000
PPIC3 <- c(31530, 29376, 38102, 44212, 52707, 65089, 81623, 134263)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(25, 280))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#KOSARAK 
#DATA
x <- rev(c(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030)*100)

PPIC1 <- c(72853, 75134, 76364, 79079, 82005, 87426)/1000
PPIC2 <- c(52670, 53016, 54463, 55461, 57930, 69746)/1000
PPIC3 <- c(48279, 46581, 47492, 50055, 51547, 53801)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(45, 120))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#LEVIATHAN 
#DATA
x <- rev(c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1)*100)

PPIC1 <- c(25739, 26887, 27743, 28844, 29933, 31517, 33208, 34944, 38670, 46764)/1000
PPIC2 <- c(18844, 18832, 19859, 20097, 20498, 22255, 22495, 24574, 26813, 32225)/1000
PPIC3 <- c(16754, 17075, 17594, 18358, 19363, 19778, 21032, 22060, 25269, 29559)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 60))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#PROTEIN 
#DATA
x <- rev(c(0.99984, 0.99986, 0.99988, 0.9999)*100)

PPIC1 <- c(346658, 399486, 437277, 446292)/1000
PPIC2 <- c(335547, 335677, 363314, 374943)/1000
PPIC3 <- c(293632, 297613, 340955, 364871)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(280, 520))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#PUBMED 
#DATA
x <- rev(c(0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100)

PPIC1 <- c(39894, 42527, 45842, 53072, 67256, 81245)/1000
PPIC2 <- c(27522, 29793, 31602, 35979, 44553, 54778)/1000
PPIC3 <- c(25145, 26419, 28519, 32524, 42028, 49093)/1000

#PLOT
plot(x,PPIC1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(25, 90))
lines(x,PPIC2, col="red", type="o", pch=1)
lines(x,PPIC3, col="green", type="o", pch=4)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#dev.off()