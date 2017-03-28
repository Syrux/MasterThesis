
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))
# 300 partitions everywhere (except PPIC, of course)

#BIBLE 
#DATA
x <- rev(c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01)*100)

spark <-c(120533, 128060, 140167, 157374, 180987, 214660, 277136, 363336, 599299, 0)/1000
PPIC <- c(62050, 62407, 63714, 63088, 66359, 71351, 75052, 81329, 107974, 282528)/1000
Mixed <- c(72493, 71476, 73961, 77192, 79149, 83273, 96695, 99406, 126792, 303826)/1000
PPICOPTI <- c(43574, 42705, 43450, 45466, 47334, 51248, 56873, 67987, 94077, 275513)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(40, 800))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)

#FIFA 
#DATA
x <- rev(c(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14)*100)

spark <-c(230895, 480474, 1253763, 2080473, 0, 0, 0, 0)/1000
PPIC <- c(28810, 29878, 34743, 44023, 62670, 94622, 148614, 329946)/1000
Mixed <- c(56639, 53848, 67270, 92645, 130974, 139763, 158870, 245169)/1000
PPICOPTI <- c(31574, 30460, 43513, 55338, 68014, 88591, 128453, 260703)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(20, 2500))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#KOSARAK 
#DATA
x <- rev(c(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030)*100)

spark <- c(85207, 89607, 94796, 111652, 112545, 125368)/1000
PPIC <- c(163830, 171291, 174344, 176624, 179948, 182677)/1000
Mixed <- c(72853, 75134, 76364, 79079, 82005, 87426)/1000
PPICOPTI <- c(37237, 38027, 39498, 41187, 43056, 46413)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(30, 450))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#LEVIATHAN 
#DATA
x <- rev(c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1)*100)

spark <-c(27795, 28547, 30378, 32613, 34750, 39251, 44618, 53540, 75583, 159321)/1000
PPIC <- c(12639, 12608, 12655, 12677, 12795, 13043, 12986, 13146, 14177, 18093)/1000
Mixed <- c(25739, 26887, 27743, 28844, 29933, 31517, 33208, 34944, 38670, 46764)/1000
PPICOPTI <- c(14029, 14460, 15450, 17334, 19568, 21520, 22648, 23872, 25360, 31257)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 200))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#PROTEIN 
#DATA
x <- rev(c(0.99984, 0.99986, 0.99988, 0.9999)*100)

spark <-c(416332, 518093, 840899, 1158215)/1000
PPIC <- c(49474, 54956, 65171, 75608)/1000
Mixed <- c(346658, 399486, 437277, 446292)/1000
PPICOPTI <- c(20923, 22474, 27823, 31493)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(18, 2800))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#PUBMED 
#DATA
x <- rev(c(0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100)

spark <-c(48962, 54762, 65118, 86453, 148804, 272193)/1000
PPIC <- c(79921, 78961, 79906, 81324, 84248, 92986)/1000
Mixed <- c(39894, 42527, 45842, 53072, 67256, 81245)/1000
PPICOPTI <- c(20923, 22474, 27823, 31493, 37705, 47938)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(19, 300))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
lines(x,PPICOPTI, col="green", type="o", pch=5)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "PPIC", "Spark-PPIC (300 partition)", "Spark-PPIC (100 partition)"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)

#dev.off()