tiff("MmEsLpMiss_CleanBeforeLocal.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
two <- c(28351, 20613, 21988, 21630, 25407, 28760, 34332, 42121, 59129, 144700)/1000
three <- c(26555, 21638, 21920, 23982, 25759, 30153, 34436, 44334, 63001, 146520)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(17, 1092))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(275420, 339255, 446968, 536502)/1000
one <- c(273254, 352139, 433728, 530863)/1000
two <- c(236981, 298804, 391152, 513338)/1000
three <- c(231751, 294266, 399726, 523552)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(231, 536))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(14897, 16315, 17535, 20827, 22818, 25235)/1000
one <- c(10677, 11312, 11903, 13425, 14473, 15247)/1000
two <- c(16207, 16695, 17845, 19250, 21191, 24124)/1000
three <- c(17756, 18512, 19519, 21515, 23124, 26741)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 26))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
two <- c(2746, 2609, 2725, 2889, 3212, 3208, 3636, 4063, 5061, 7866)/1000
three <- c(2947, 3110, 3124, 3251, 3461, 3733, 4081, 4329, 5527, 8213)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 33))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
two <- c(8387, 8745, 9591, 10901, 15052, 23029)/1000
three <- c(9212, 10699, 10272, 11668, 16387, 24768)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 60))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
two <- c(21749, 23663, 28585, 31912, 36089, 41339, 51483, 81367)/1000
three <- c(21487, 23352, 27675, 30099, 34273, 39596, 50538, 78498)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 5160))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "BasePPIC", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
two <- c(16109, 19190, 21142, 23318, 23831, 24810, 28111, 30013, 31588)/1000
three <- c(16570, 19902, 21919, 24334, 24709, 25738, 29292, 32392, 31989)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(16, 48))
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
two <- c(19480, 22694, 25047, 28425, 30926, 32442, 35665, 42130, 45709)/1000
three <- c(20445, 22825, 25604, 29482, 32010, 33751, 36669, 44653, 46566)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 46))
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_simpleClean", "MmEsLpMiss_cleanThenTransfer"), lty=c(1,1),lwd=c(2,2), col=c("blue", "magenta", "green"), cex = 1)

dev.off()
