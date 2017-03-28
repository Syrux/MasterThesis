tiff("MmEsLpMiss__PPIC.png", width=13, height=9, units='in', res=120)
par(mfrow=c(2,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
one <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(17, 664))
lines(x, one, col="red", type="o", pch=1)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(273254, 352139, 433728, 530863)/1000
one <- c(246882, 312195, 434838, 520212)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(246, 530))
lines(x, one, col="red", type="o", pch=1)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10677, 11312, 11903, 13425, 14473, 15247)/1000
one <- c(18246, 18937, 20654, 21961, 24087, 29184)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 29))
lines(x, one, col="red", type="o", pch=1)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 12))
lines(x, one, col="red", type="o", pch=1)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 32))
lines(x, one, col="red", type="o", pch=1)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 204))
lines(x, one, col="red", type="o", pch=1)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100


#PLOT
#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100


#PLOT
dev.off()
