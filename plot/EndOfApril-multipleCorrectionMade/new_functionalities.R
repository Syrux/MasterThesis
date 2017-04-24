tiff("new_functionalities.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(25548, 22705, 23321, 28601, 32117, 37491, 49792, 69266, 201088, 713458)/1000
one <- c(23555, 22638, 22920, 26982, 31759, 34153, 41436, 57334, 152001, 631520)/1000
two <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(22, 713))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(343765, 471862, 584204, 709748)/1000
one <- c(333665, 466323, 596453, 699012)/1000
two <- c(316549, 446706, 554299, 686114)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(316, 709))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(9908, 9518, 10577, 10739, 11089, 12398)/1000
one <- c(10908, 11518, 12577, 12739, 12089, 13398)/1000
two <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 24))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1791, 1948, 1872, 2117, 2175, 2315, 2504, 2923, 3892, 10533)/1000
one <- c(1947, 1810, 1824, 2251, 2261, 2733, 2081, 2529, 2927, 8213)/1000
two <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 10))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4693, 5235, 6386, 7478, 13264, 39082)/1000
one <- c(4212, 4699, 6572, 7668, 12387, 38768)/1000
two <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 39))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9674, 15775, 31988, 47596, 73041, 88842, 155817, 283817)/1000
one <- c(8487, 12352, 27675, 43099, 64273, 76596, 122538, 219498)/1000
two <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(8, 283))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(14705, 22015, 30273, 29469, 30904, 30230, 32101, 33232, 33243)/1000
one <- c(16282, 16876, 19293, 18853, 19119, 22758, 22126, 24132, 26700)/1000
two <- c(15077, 16317, 18549, 18766, 19779, 20306, 21739, 23757, 26922)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 33))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(11822, 11826, 12839, 17210, 18635, 18359, 19826, 22251, 22276)/1000
one <- c(13746, 12651, 14389, 17903, 19707, 20510, 23057, 26810, 27856)/1000
two <- c(13005, 13462, 15471, 20308, 19068, 20138, 23366, 26772, 27830)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 27))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("first_implem", "Early_start", "clean_before_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

dev.off()
