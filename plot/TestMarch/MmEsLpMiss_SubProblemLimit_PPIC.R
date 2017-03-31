tiff("MmEsLpMiss_SubProblemLimit_PPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(39119, 34899, 35331, 40499, 50650, 70702, 91325, 122760, 176551, 441163)/1000
one <- c(50760, 51732, 60535, 72886, 87593, 115659, 158423, 225739, 410056, 1096782)/1000
two <- c(76294, 77477, 90608, 109903, 133888, 173967, 233876, 337788, 602579, 1591939)/1000
three <- c(79276, 80430, 91285, 112419, 136481, 181523, 238008, 344930, 619925, 1591803)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(34, 1591))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(308226, 437820, 538330, 674844)/1000
one <- c(162122, 201114, 242884, 297038)/1000
two <- c(209249, 203316, 257267, 276241)/1000
three <- c(317441, 309485, 355407, 395068)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(162, 674))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(16070, 17262, 17268, 20145, 21729, 24083)/1000
one <- c(14087, 13289, 15546, 16644, 19775, 21091)/1000
two <- c(13978, 14856, 15432, 19653, 19934, 23360)/1000
three <- c(13806, 14835, 15677, 18240, 19243, 23082)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 24))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2555, 2848, 2866, 3350, 3363, 3665, 5270, 5904, 9147, 23925)/1000
one <- c(1905, 2036, 2258, 2588, 3035, 3606, 4770, 6861, 11728, 34362)/1000
two <- c(2360, 2437, 2841, 3472, 4087, 5033, 6695, 9631, 17194, 50332)/1000
three <- c(4695, 2907, 3009, 3612, 4031, 5242, 6884, 9847, 18721, 50366)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 50))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(10027, 8892, 10727, 14101, 20774, 39770)/1000
one <- c(5494, 6279, 8908, 11993, 24468, 53224)/1000
two <- c(6937, 11094, 11224, 16736, 35125, 76480)/1000
three <- c(10275, 8679, 11798, 18015, 38137, 78141)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(5, 78))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(30958, 44640, 123454, 176801, 332213, 562830, 916465, 2016613)/1000
one <- c(35786, 80634, 201769, 399266, 748778, 1333258, 2417993, 4765888)/1000
two <- c(53734, 108717, 325362, 643100, 1216430, 2365059, 3941060, 8427763)/1000
three <- c(44586, 72593, 336544, 665348, 1254170, 2274831, 4104472, 8176178)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(30, 8427))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(16111, 24774, 35863, 38040, 38423, 38548, 45119, 41859, 42252)/1000
one <- c(12621, 28906, 44395, 44683, 45170, 46854, 47049, 47741, 49667)/1000
two <- c(20172, 38818, 61530, 62916, 62405, 62628, 62778, 63544, 67115)/1000
three <- c(27719, 40771, 62931, 64600, 64609, 65227, 66530, 66633, 67653)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(12, 67))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(17916, 19933, 22569, 32337, 35144, 37589, 40291, 47436, 49250)/1000
one <- c(10439, 10642, 11851, 22690, 25914, 24291, 24210, 28542, 30484)/1000
two <- c(11078, 11847, 12840, 29876, 30083, 32990, 32301, 38482, 38049)/1000
three <- c(12506, 12827, 14161, 31062, 32944, 36102, 33340, 40856, 40056)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 49))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
