tiff("MmEsLpMiss_MissRecalculated_NoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(48356, 54199, 54728, 69970, 75747, 87422, 119358, 225696, 291582, 712196)/1000
two <- c(39797, 41885, 42179, 51374, 55977, 64845, 87143, 156671, 203717, 478951)/1000
three <- c(43782, 50408, 50783, 65470, 70317, 84362, 113584, 213463, 265223, 663891)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(39, 1092))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(343017, 473810, 596472, 697465)/1000
one <- c(308961, 439082, 540702, 669324)/1000
two <- c(308885, 434039, 541505, 675497)/1000
three <- c(307861, 437715, 544172, 684101)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(307, 697))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15474, 14856, 17149, 18875, 21231, 24935)/1000
one <- c(19793, 21194, 23145, 24331, 27508, 32018)/1000
two <- c(19734, 21323, 23261, 24561, 27626, 31468)/1000
three <- c(20269, 21718, 23429, 24793, 27910, 31845)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 32))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(3429, 3556, 4123, 4367, 4958, 5353, 7033, 8463, 15132, 33196)/1000
two <- c(3256, 3336, 3832, 4057, 4246, 4808, 6006, 7092, 11263, 22483)/1000
three <- c(3375, 3548, 3803, 4343, 5288, 5189, 6766, 8252, 13622, 28689)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 33))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(11477, 13539, 13999, 20093, 32291, 68072)/1000
two <- c(12909, 12172, 13326, 17062, 28273, 54353)/1000
three <- c(11517, 12540, 14606, 18976, 31550, 64131)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 68))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(54808, 83163, 189051, 325328, 662737, 1257004, 1832036, 4179184)/1000
two <- c(39155, 55390, 114377, 191110, 346952, 642282, 929263, 2102940)/1000
three <- c(52466, 78049, 176652, 302624, 565132, 1067158, 1546791, 3548749)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(34, 5160))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
one <- c(29527, 36046, 49805, 53633, 55558, 53890, 59184, 69107, 70786)/1000
two <- c(25029, 29236, 39497, 43030, 44366, 44532, 49195, 57022, 58808)/1000
three <- c(21024, 34564, 47899, 51574, 52845, 51686, 57474, 67521, 69082)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(21, 70))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
one <- c(21200, 23676, 27043, 39439, 45476, 46323, 53442, 62428, 71626)/1000
two <- c(22517, 25774, 28799, 37925, 42777, 45345, 50300, 59813, 66919)/1000
three <- c(21610, 24602, 28905, 40540, 47704, 46138, 54236, 69129, 72656)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 72))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MaxItemRecalculated_0_Spark", "MaxItemRecalculated_1_Spark", "MaxItemRecalculated_2_Spark"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
