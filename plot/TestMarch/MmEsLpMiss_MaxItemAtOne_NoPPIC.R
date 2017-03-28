tiff("MmEsLpMiss_MaxItemAtOne_NoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(45301, 46646, 49071, 53203, 70110, 100696, 130230, 179787, 252375, 635487)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(45, 1092))
lines(x, one, col="red", type="o", pch=1)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(275420, 339255, 446968, 536502)/1000
one <- c(234381, 304146, 410503, 514969)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(234, 536))
lines(x, one, col="red", type="o", pch=1)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(14897, 16315, 17535, 20827, 22818, 25235)/1000
one <- c(21441, 21660, 23060, 26388, 28921, 35072)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 35))
lines(x, one, col="red", type="o", pch=1)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(3259, 3230, 3621, 4737, 4444, 4824, 6196, 7247, 13846, 36029)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 36))
lines(x, one, col="red", type="o", pch=1)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(10343, 11198, 13420, 18463, 29293, 56065)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 60))
lines(x, one, col="red", type="o", pch=1)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(47956, 72566, 214017, 315329, 601258, 1023672, 1667162, 3778928)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(34, 5160))
lines(x, one, col="red", type="o", pch=1)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
one <- c(21932, 32380, 47272, 51320, 51474, 49942, 58808, 55098, 55660)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(21, 58))
lines(x, one, col="red", type="o", pch=1)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
one <- c(20559, 23078, 26536, 39913, 43127, 46395, 49298, 59426, 61223)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 61))
lines(x, one, col="red", type="o", pch=1)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

dev.off()
