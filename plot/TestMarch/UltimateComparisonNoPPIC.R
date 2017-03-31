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
five <- c(22525, 20743, 21401, 22428, 23459, 28200, 33593, 42280, 58723, 143557)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(20, 1092))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(343017, 473810, 596472, 697465)/1000
one <- c(301100, 429886, 536385, 666723)/1000
two <- c(315017, 439511, 547069, 686244)/1000
three <- c(315546, 436795, 529721, 679101)/1000
four <- c(312246, 434722, 532022, 660175)/1000
five <- c(325769, 462997, 606735, 740408)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(301, 740))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15474, 14856, 17149, 18875, 21231, 24935)/1000
one <- c(16291, 17919, 18273, 20873, 22570, 24924)/1000
two <- c(22440, 23879, 23866, 28099, 29961, 34483)/1000
three <- c(24445, 26331, 27988, 31849, 35671, 41785)/1000
four <- c(28659, 32920, 33905, 38783, 43564, 50649)/1000
five <- c(15588, 17048, 17596, 19098, 20958, 23497)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 50))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(2748, 2808, 3491, 3287, 3539, 3871, 4898, 5367, 10148, 24977)/1000
two <- c(2813, 3250, 3569, 3440, 3912, 4110, 5059, 6398, 10289, 25803)/1000
three <- c(3713, 3877, 4417, 5162, 6797, 6454, 8472, 10114, 18092, 44843)/1000
four <- c(3624, 3626, 4146, 4666, 5066, 5905, 7372, 10299, 15683, 36539)/1000
five <- c(2510, 2577, 2677, 2725, 3081, 3125, 3601, 3887, 5504, 7288)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 44))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(13949, 9785, 11005, 15957, 23109, 44058)/1000
two <- c(9488, 11312, 11924, 16140, 25265, 49404)/1000
three <- c(12506, 13774, 16624, 24189, 40220, 77156)/1000
four <- c(11931, 13923, 15687, 24014, 39083, 72956)/1000
five <- c(8307, 8559, 9442, 10633, 14689, 22462)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 77))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(33111, 49208, 129728, 189627, 359721, 608857, 994174, 2120188)/1000
two <- c(35656, 51383, 136084, 197648, 362176, 620936, 1024881, 2205090)/1000
three <- c(67485, 96850, 254842, 357743, 650649, 1095734, 1842227, 3897483)/1000
four <- c(54714, 75425, 176057, 248614, 432697, 718622, 1149499, 2439468)/1000
five <- c(20683, 22658, 26916, 30191, 34036, 41168, 52060, 74124)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(20, 5160))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
one <- c(21301, 25910, 36740, 39328, 40503, 38721, 47662, 44635, 44621)/1000
two <- c(21146, 29399, 40601, 43637, 43973, 44480, 51246, 48576, 49776)/1000
three <- c(22914, 35394, 51768, 54421, 56881, 55189, 65617, 61134, 60876)/1000
four <- c(23241, 32777, 44198, 48526, 50625, 49852, 58785, 56067, 56923)/1000
five <- c(16903, 18691, 21227, 23410, 25048, 26062, 29873, 31750, 32163)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(16, 65))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
one <- c(19100, 21783, 24292, 33911, 37246, 39462, 42475, 50357, 52442)/1000
two <- c(22768, 24454, 28242, 38506, 42214, 45109, 49097, 60011, 62425)/1000
three <- c(22672, 25716, 29842, 44593, 49100, 52728, 57001, 70322, 71980)/1000
four <- c(25330, 28799, 33542, 45456, 49855, 53844, 58931, 71956, 76033)/1000
five <- c(20289, 22537, 25372, 28287, 31163, 32456, 36837, 42475, 45137)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 76))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_NoPPIC", "firstPos_NoPPIC", "lastPos_NoPPIC", "firstLastPos_NoPPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod"), cex = 1)

dev.off()
