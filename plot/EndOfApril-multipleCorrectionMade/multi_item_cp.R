tiff("multi_item_cp.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
one <- c(237489, 297470, 335973, 442054, 631428, 822926, 1353137, 2740897, 5518184, 24392285)/1000
two <- c(334083, 418471, 523762, 776208, 953625, 1500781, 2171684, 4010184, 9826839, 0)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 24392))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(316549, 446706, 554299, 686114)/1000
one <- c(344829, 481464, 573733, 700710)/1000
two <- c(349579, 494702, 635167, 745368)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(316, 745))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000
one <- c(42187, 52039, 59850, 72461, 86128, 102817)/1000
two <- c(95839, 90958, 99374, 113847, 150720, 187664)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(15, 187))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
one <- c(3234, 3578, 3877, 5017, 5802, 7305, 10210, 15497, 32720, 97926)/1000
two <- c(4532, 6530, 11820, 5998, 13692, 8525, 14403, 16120, 32941, 123012)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 123))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
one <- c(11742, 15169, 21170, 35606, 104759, 317454)/1000
two <- c(29940, 25629, 31444, 57534, 181176, 674850)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 674))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
one <- c(65524, 151623, 305578, 545998, 860325, 1443431, 2625071, 5185374)/1000
two <- c(76610, 167163, 389445, 631685, 1051503, 1813300, 3561210, 6679371)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(26, 6679))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(15077, 16317, 18549, 18766, 19779, 20306, 21739, 23757, 26922)/1000
one <- c(14182, 22215, 27837, 27414, 28003, 27309, 30199, 30604, 30377)/1000
two <- c(16091, 24472, 35254, 35890, 35958, 36613, 39609, 40083, 39720)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 40))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13005, 13462, 15471, 20308, 19068, 20138, 23366, 26772, 27830)/1000
one <- c(11145, 11753, 13877, 20186, 20011, 19822, 22386, 22718, 24224)/1000
two <- c(13180, 14088, 14569, 25381, 27727, 26311, 29330, 30488, 31781)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 31))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "multi_array", "multi_map"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta"), cex = 1)

dev.off()
