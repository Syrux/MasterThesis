tiff("MmEsLpMiss_priority_NoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(52796, 54313, 65238, 76671, 96842, 121262, 156699, 234465, 413217, 1092148)/1000
one <- c(35327, 40771, 42341, 52978, 57984, 67874, 90287, 159773, 203204, 490661)/1000
two <- c(72428, 81467, 93920, 111908, 140241, 181582, 246418, 355963, 625055, 1669685)/1000
three <- c(75497, 83898, 99486, 118842, 143893, 184353, 248709, 372327, 645193, 1697014)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(35, 1697))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(343017, 473810, 596472, 697465)/1000
one <- c(320794, 441620, 557941, 714822)/1000
two <- c(174618, 224436, 292674, 384518)/1000
three <- c(234010, 273482, 320215, 344295)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(174, 714))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15474, 14856, 17149, 18875, 21231, 24935)/1000
one <- c(20573, 22161, 24907, 25763, 30539, 33786)/1000
two <- c(18018, 23163, 22830, 27463, 28260, 34785)/1000
three <- c(18701, 19968, 22274, 26020, 32513, 35339)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 35))
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
one <- c(3028, 3405, 3331, 3817, 4058, 4656, 5653, 6616, 10822, 25181)/1000
two <- c(2608, 2963, 2992, 3626, 4433, 6041, 7682, 10801, 18849, 51408)/1000
three <- c(2710, 4476, 3240, 3598, 4556, 6043, 7968, 11084, 19479, 52663)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 52))
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
one <- c(10496, 11560, 12400, 15485, 26753, 46554)/1000
two <- c(7611, 9265, 12110, 18862, 37882, 114851)/1000
three <- c(7825, 9413, 12632, 19581, 40233, 115922)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 115))
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
one <- c(36556, 58911, 151618, 230629, 374071, 766731, 1375863, 2259819)/1000
two <- c(50880, 123846, 362230, 707257, 1313220, 2329573, 4216235, 8337291)/1000
three <- c(53769, 133028, 393140, 766600, 1420618, 2558353, 4634818, 9211057)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(34, 9211))
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
one <- c(22905, 30341, 41264, 45446, 44633, 48266, 50873, 59252, 53648)/1000
two <- c(16338, 40305, 64947, 65720, 65657, 66669, 68444, 68277, 69027)/1000
three <- c(22625, 41679, 67243, 68088, 68304, 69750, 71259, 71228, 71881)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(16, 71))
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
one <- c(22671, 25567, 29293, 39235, 43190, 45021, 49891, 57757, 66451)/1000
two <- c(12204, 12371, 13147, 29587, 31667, 32147, 33048, 37173, 37629)/1000
three <- c(12517, 12972, 13656, 31177, 33593, 33810, 34709, 37757, 38907)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(12, 66))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BaseSpark", "MmEsLpMiss_priority_NoSubLimit_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExec_NoPPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_NoPPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
