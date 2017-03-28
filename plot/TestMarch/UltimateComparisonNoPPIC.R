tiff("UltimateComparisonNoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(35452, 36785, 35713, 42346, 56086, 74180, 94140, 128774, 181539, 468725)/1000
two <- c(40459, 39825, 43144, 45840, 60062, 81513, 105887, 139940, 200825, 491480)/1000
three <- c(57251, 62971, 64247, 68604, 92617, 132273, 168278, 219716, 302063, 708680)/1000
four <- c(52726, 55286, 55855, 63733, 84355, 110988, 137774, 187753, 263900, 584497)/1000
five <- c(45301, 46646, 49071, 53203, 70110, 100696, 130230, 179787, 252375, 635487)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(35, 1092))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(275420, 339255, 446968, 536502)/1000
one <- c(237057, 312765, 396253, 496434)/1000
two <- c(229789, 306514, 382241, 479804)/1000
three <- c(237424, 295879, 395786, 520362)/1000
four <- c(234877, 305027, 405640, 520924)/1000
five <- c(234381, 304146, 410503, 514969)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(229, 536))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(14897, 16315, 17535, 20827, 22818, 25235)/1000
one <- c(19298, 20000, 21258, 23093, 25354, 30151)/1000
two <- c(22364, 23127, 25006, 26686, 31132, 36659)/1000
three <- c(32420, 32080, 36021, 41805, 44025, 55484)/1000
four <- c(32020, 34389, 37029, 41384, 47252, 56612)/1000
five <- c(21441, 21660, 23060, 26388, 28921, 35072)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 56))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(2748, 2808, 3491, 3287, 3539, 3871, 4898, 5367, 10148, 24977)/1000
two <- c(2813, 3250, 3569, 3440, 3912, 4110, 5059, 6398, 10289, 25803)/1000
three <- c(3713, 3877, 4417, 5162, 6797, 6454, 8472, 10114, 18092, 44843)/1000
four <- c(3624, 3626, 4146, 4666, 5066, 5905, 7372, 10299, 15683, 36539)/1000
five <- c(3259, 3230, 3621, 4737, 4444, 4824, 6196, 7247, 13846, 36029)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 44))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(13949, 9785, 11005, 15957, 23109, 44058)/1000
two <- c(9488, 11312, 11924, 16140, 25265, 49404)/1000
three <- c(12506, 13774, 16624, 24189, 40220, 77156)/1000
four <- c(11931, 13923, 15687, 24014, 39083, 72956)/1000
five <- c(10343, 11198, 13420, 18463, 29293, 56065)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 77))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(33111, 49208, 129728, 189627, 359721, 608857, 994174, 2120188)/1000
two <- c(35656, 51383, 136084, 197648, 362176, 620936, 1024881, 2205090)/1000
three <- c(67485, 96850, 254842, 357743, 650649, 1095734, 1842227, 3897483)/1000
four <- c(54714, 75425, 176057, 248614, 432697, 718622, 1149499, 2439468)/1000
five <- c(47956, 72566, 214017, 315329, 601258, 1023672, 1667162, 3778928)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(33, 5160))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
one <- c(21301, 25910, 36740, 39328, 40503, 38721, 47662, 44635, 44621)/1000
two <- c(21146, 29399, 40601, 43637, 43973, 44480, 51246, 48576, 49776)/1000
three <- c(22914, 35394, 51768, 54421, 56881, 55189, 65617, 61134, 60876)/1000
four <- c(23241, 32777, 44198, 48526, 50625, 49852, 58785, 56067, 56923)/1000
five <- c(21932, 32380, 47272, 51320, 51474, 49942, 58808, 55098, 55660)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(21, 65))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
one <- c(19100, 21783, 24292, 33911, 37246, 39462, 42475, 50357, 52442)/1000
two <- c(22768, 24454, 28242, 38506, 42214, 45109, 49097, 60011, 62425)/1000
three <- c(22672, 25716, 29842, 44593, 49100, 52728, 57001, 70322, 71980)/1000
four <- c(25330, 28799, 33542, 45456, 49855, 53844, 58931, 71956, 76033)/1000
five <- c(20559, 23078, 26536, 39913, 43127, 46395, 49298, 59426, 61223)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 76))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "MaxItem_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

dev.off()
