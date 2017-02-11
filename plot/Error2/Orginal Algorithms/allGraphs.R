
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))

#BIBLE 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10)*100

spark <-c(40000000, 40000000, 40000000, 40000000, 40000000, 5000000, 538239, 187962, 84010, 39947, 24614, 17728, 14470)/1000
PPIC <- c(40000000, 40000000, 40000000, 2833993, 301266, 140799, 117743, 110585, 107425, 105201, 103492, 98633, 88532)/1000
Mixed <- c(150723, 115710, 84153, 48707, 40943, 33764, 30361, 27948, 24831, 19688, 14911, 12159, 10918)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 3000))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)

#FIFA 
#DATA
x <- c(0.0001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

spark <-c(2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 2000000)/1000
PPIC <- c(2000000, 2000000, 2000000, 2000000, 2000000, 2000000, 473165, 248836, 143546, 35556, 19849, 18911, 17337, 16897)/1000
Mixed <- c(43620, 34604, 32904, 32074, 31306, 29560, 29193, 29855, 28350, 27236, 21180, 14881, 14039, 13432)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(13, 700))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)


#KOSARAK 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01)*100

spark <- c(40000000, 40000000, 40000000, 40000000, 934453, 102276, 42424, 31769, 23115, 21834)/1000
PPIC <- c(40000000, 40000000, 40000000, 3787552, 222267, 176032, 177696, 170233, 167167, 160994)/1000
Mixed <- c(387796, 183518, 139266, 63920, 52935, 35868, 28153, 25438, 20055, 16337)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(13, 3000))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)


#LEVIATHAN 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1)*100

spark <-c(40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 849409, 234886, 71863, 36528, 28120, 25105, 19574)/1000
PPIC <- c(10000000, 10000000, 10000000, 10000000, 10000000, 144561, 34394, 18025, 14583, 13385, 12852, 12454, 11079)/1000
Mixed <- c(41206, 41098, 46700, 31285, 27711, 25596, 23960, 22538, 21170, 20423, 15768, 13020, 10890)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 3000))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)


#PROTEIN 
#DATA
x <- c(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99, 0.999, 0.9999)*100

spark <-c(40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 1031894)/1000
PPIC <- c(40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 40000000, 43640)/1000
Mixed <- c(57044, 55519, 56025, 55063, 56175, 55768, 53655, 52482, 48276, 29105)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(13, 3000))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)


#PUBMED 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100

spark <-c(10000000, 10000000, 10000000, 10000000, 10000000, 10000000, 10000000, 611512, 225720, 126406, 79767, 61397)/1000
PPIC <- c(10000000, 10000000, 10000000, 10000000, 375830, 120681, 88439, 83192, 75572, 73921, 72887, 71834)/1000
Mixed <- c(128653, 124927, 75712, 43018, 36441, 31046, 28413, 26053, 23717, 22047, 17110, 14647)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(13, 3000))
lines(x,PPIC, col="red", type="o", pch=1)
lines(x,Mixed, col="magenta", type="o", pch=4)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topleft", legend=c("Spark", "PPIC", "Mixed"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta"), cex = 1)

#dev.off()