tiff("first_implementation.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(51911, 43421, 49318, 58845, 71485, 89040, 117958, 172756, 297617, 758238)/1000
one <- c(82008, 80724, 82265, 146457, 97293, 98552, 98697, 109212, 132805, 304888)/1000
two <- c(25548, 22705, 23321, 28601, 32117, 37491, 49792, 69266, 201088, 713458)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(22, 758))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(348641, 463671, 562825, 714033)/1000
one <- c(56843, 61087, 64981, 71408)/1000
two <- c(343765, 471862, 584204, 709748)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(56, 714))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(13626, 14164, 15519, 17114, 18521, 21968)/1000
one <- c(156837, 156004, 164265, 165995, 168944, 165628)/1000
two <- c(9908, 9518, 10577, 10739, 11089, 12398)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 168))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2023, 2218, 2202, 2674, 2962, 3426, 4167, 5904, 10298, 23218)/1000
one <- c(6807, 7433, 7279, 7120, 7100, 7302, 7434, 7659, 12498, 17520)/1000
two <- c(1791, 1948, 1872, 2117, 2175, 2315, 2504, 2923, 3892, 10533)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 23))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(5539, 6494, 8176, 11189, 20628, 40861)/1000
one <- c(79557, 82467, 81906, 81297, 84380, 92545)/1000
two <- c(4693, 5235, 6386, 7478, 13264, 39082)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 92))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(29243, 63196, 168480, 341458, 635816, 1087250, 2042733, 3842188)/1000
one <- c(12083, 21760, 32576, 43764, 55899, 89758, 138721, 218348)/1000
two <- c(9674, 15775, 31988, 47596, 73041, 88842, 155817, 283817)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 3842))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "PPIC", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(14556, 21944, 29900, 29980, 30380, 30445, 32157, 33005, 33640)/1000
two <- c(14705, 22015, 30273, 29469, 30904, 30230, 32101, 33232, 33243)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 33))
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "magenta"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(10860, 11565, 12856, 18006, 19309, 18718, 20803, 22834, 24442)/1000
two <- c(11822, 11826, 12839, 17210, 18635, 18359, 19826, 22251, 22276)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 24))
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Spark", "first_implem"), lty=c(1,1),lwd=c(2,2), col=c("blue", "magenta"), cex = 1)

dev.off()
