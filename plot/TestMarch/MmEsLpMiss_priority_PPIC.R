tiff("MmEsLpMiss_priority_PPIC.png", width=13, height=9, units='in', res=120)
par(mfrow=c(2,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
one <- c(27592, 25792, 24983, 27971, 29876, 33891, 39145, 48591, 70000, 165787)/1000
two <- c(21422, 14426, 13975, 15739, 17856, 19583, 23290, 34481, 62861, 272392)/1000
three <- c(16660, 13704, 13105, 14067, 16200, 20847, 23785, 32787, 58979, 272298)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 664))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(273254, 352139, 433728, 530863)/1000
one <- c(228440, 287036, 370355, 477079)/1000
two <- c(153993, 170552, 197045, 218883)/1000
three <- c(399151, 461804, 589073, 595513)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(153, 595))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10677, 11312, 11903, 13425, 14473, 15247)/1000
one <- c(16383, 17476, 18607, 20910, 22162, 25774)/1000
two <- c(9526, 12275, 10323, 11783, 12473, 13443)/1000
three <- c(9958, 9976, 10224, 11209, 11838, 13562)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 25))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3167, 3291, 3292, 3671, 3757, 4254, 4717, 5390, 6905, 10410)/1000
two <- c(1658, 1649, 1557, 1824, 2072, 2178, 2353, 2392, 2943, 5520)/1000
three <- c(1591, 1779, 1769, 1677, 2159, 2165, 2491, 2535, 2992, 5446)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 12))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(9889, 10898, 11723, 13496, 19435, 30183)/1000
two <- c(4151, 4493, 5175, 6564, 9209, 17229)/1000
three <- c(3943, 4417, 5348, 6569, 9103, 17890)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(3, 32))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(30291, 31491, 38225, 44118, 51787, 61351, 72909, 118744)/1000
two <- c(7743, 9834, 15469, 22137, 32666, 50512, 80329, 137681)/1000
three <- c(7892, 9712, 15784, 22019, 33095, 50330, 71245, 133089)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(7, 204))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100


#PLOT
#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100


#PLOT
dev.off()
