
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))
# 300 partitions everywhere (except PPIC, of course)

#BIBLE 
#DATA
x <- rev(c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01)*100)

SPARK1 <- c(120533, 128060, 140167, 157374, 180987, 214660, 277136, 363336, 599299, 0)/1000
SPARK2 <- c(94435, 102269, 115659, 133435, 144252, 196513, 229831, 335298, 546094, 1386509)/1000
SPARK3 <- c(93822, 98534, 111722, 129674, 145572, 187067, 231473, 335640, 555927, 1430378)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(90, 1500))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#FIFA 
#DATA
x <- rev(c(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14)*100)

SPARK1 <- c(230895, 480474, 1253763, 2080473, 0, 0, 0, 0)/1000
SPARK2 <- c(127688, 223388, 701977, 1109300, 0, 0, 0, 0)/1000
SPARK3 <- c(121307, 225600, 683683, 1109717, 1874803, 3310604, 0, 0)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(120, 3500))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#KOSARAK 
#DATA
x <- rev(c(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030)*100)

SPARK1 <- c(85207, 89607, 94796, 111652, 112545, 125368)/1000
SPARK2 <- c(51944, 57344, 62644, 63529, 75976, 79235)/1000
SPARK3 <- c(48515, 52675, 57158, 58600, 67141, 79093)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(40, 130))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#LEVIATHAN 
#DATA
x <- rev(c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1)*100)

SPARK1 <- c(27795, 28547, 30378, 32613, 34750, 39251, 44618, 53540, 75583, 159321)/1000
SPARK2 <- c(17800, 18392, 19274, 21033, 22755, 25169, 27053, 34127, 45953, 92535)/1000
SPARK3 <- c(16043, 17272, 18130, 19940, 20744, 22861, 25821, 31354, 41032, 85882)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 160))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#PROTEIN 
#DATA
x <- rev(c(0.99984, 0.99986, 0.99988, 0.9999)*100)

SPARK1 <- c(416332, 518093, 840899, 1158215)/1000
SPARK2 <- c(342271, 357527, 543421, 781229)/1000
SPARK3 <- c(341466, 358187, 521898, 728512)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(340, 1200))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#PUBMED 
#DATA
x <- rev(c(0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100)

SPARK1 <- c(48962, 54762, 65118, 86453, 148804, 272193)/1000
SPARK2 <- c(30770, 34359, 40931, 54157, 89941, 166371)/1000
SPARK3 <- c(27254, 31408, 37921, 48621, 81682, 155159)/1000

#PLOT
plot(x,SPARK1, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(25, 300))
lines(x,SPARK2, col="red", type="o", pch=1)
lines(x,SPARK3, col="green", type="o", pch=4)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("1 Thread", "3 Thread", "5 Thread"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green"), cex = 1)

#dev.off()