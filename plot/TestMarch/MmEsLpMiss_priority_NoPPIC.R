tiff("MmEsLpMiss_priority_NoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(38128, 46788, 48489, 61613, 67884, 79108, 108154, 207608, 261070, 639070)/1000
two <- c(70355, 80105, 93172, 111521, 137114, 175595, 236760, 348016, 610344, 1614060)/1000
three <- c(66220, 74141, 86797, 104387, 126594, 161994, 220511, 325093, 575726, 1530155)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(38, 1614))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(275420, 339255, 446968, 536502)/1000
one <- c(223444, 279687, 355598, 441702)/1000
two <- c(175447, 217250, 363478, 501232)/1000
three <- c(228867, 222107, 297504, 386401)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(175, 536))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(14897, 16315, 17535, 20827, 22818, 25235)/1000
one <- c(18428, 19989, 21428, 24471, 26377, 29563)/1000
two <- c(17883, 22338, 22122, 25558, 28943, 32872)/1000
three <- c(16420, 17952, 20291, 25231, 30171, 31996)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 32))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2295, 2312, 2516, 3105, 3496, 4080, 5163, 7414, 13505, 33000)/1000
one <- c(3057, 3140, 3755, 4053, 4261, 5021, 6358, 7960, 13482, 28140)/1000
two <- c(2572, 2934, 2945, 3568, 4354, 5625, 7521, 10401, 18365, 49316)/1000
three <- c(2463, 2768, 3034, 3455, 4132, 5448, 8323, 9900, 17329, 47465)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 49))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6549, 7547, 9177, 14644, 25945, 60113)/1000
one <- c(10255, 11734, 12629, 17206, 28700, 60516)/1000
two <- c(7455, 9057, 12074, 18472, 37575, 109656)/1000
three <- c(7434, 9679, 12143, 17644, 35362, 104460)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 109))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34465, 79626, 221550, 449631, 834468, 1476503, 2639619, 5160952)/1000
one <- c(49889, 76901, 171911, 295509, 578230, 1081152, 1547595, 3591853)/1000
two <- c(49119, 122774, 356852, 697736, 1303324, 2311685, 4175362, 8310574)/1000
three <- c(47775, 117683, 345522, 676277, 1251842, 2225407, 4069512, 8077980)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(34, 8310))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(21433, 30124, 46018, 45696, 45741, 47937, 48250, 48646, 48981)/1000
one <- c(20961, 33878, 48214, 51686, 53229, 52068, 57365, 68912, 70215)/1000
two <- c(23126, 41080, 66782, 65529, 66632, 67390, 67689, 69938, 70125)/1000
three <- c(16117, 38585, 60055, 60771, 61410, 62660, 63270, 64455, 65114)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(16, 70))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13258, 14335, 14949, 26537, 30083, 28606, 28885, 34413, 32900)/1000
one <- c(20958, 23792, 26859, 38911, 45616, 45268, 52733, 62457, 71755)/1000
two <- c(11711, 12493, 13070, 31031, 32040, 32844, 34816, 36979, 38237)/1000
three <- c(11667, 12688, 12924, 27894, 30123, 30601, 31008, 34777, 35904)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 71))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
