tiff("sub_problem_limit.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
one <- c(50760, 51732, 60535, 72886, 87593, 115659, 158423, 225739, 410056, 1096782)/1000
two <- c(76294, 77477, 90608, 109903, 133888, 173967, 233876, 337788, 602579, 1591939)/1000
three <- c(79276, 80430, 91285, 112419, 136481, 181523, 238008, 344930, 619925, 1591803)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(23, 1591))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(316549, 446706, 554299, 686114)/1000
one <- c(162122, 201114, 242884, 297038)/1000
two <- c(209249, 203316, 257267, 276241)/1000
three <- c(317441, 309485, 355407, 395068)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(162, 686))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000
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
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
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
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
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
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
one <- c(35786, 80634, 201769, 399266, 748778, 1333258, 2417993, 4765888)/1000
two <- c(53734, 108717, 325362, 643100, 1216430, 2365059, 3941060, 8427763)/1000
three <- c(44586, 72593, 336544, 665348, 1254170, 2274831, 4104472, 8176178)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(26, 8427))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(15077, 16317, 18549, 18766, 19779, 20306, 21739, 23757, 26922)/1000
one <- c(16122, 18923, 25873, 24790, 25261, 25555, 31107, 34374, 34367)/1000
two <- c(14207, 20422, 26171, 26743, 25495, 26272, 27868, 32067, 29220)/1000
three <- c(14021, 17581, 22671, 22370, 22365, 24291, 26577, 26953, 28617)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 34))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13005, 13462, 15471, 20308, 19068, 20138, 23366, 26772, 27830)/1000
one <- c(12084, 14995, 13020, 20522, 19940, 20250, 21972, 21314, 24658)/1000
two <- c(12043, 14214, 13641, 16744, 17296, 19217, 20962, 21074, 22696)/1000
three <- c(11556, 11939, 13804, 16743, 16085, 17957, 17446, 19506, 20711)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 27))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("clean_before_PPIC", "4 sub-problems", "16 sub-problems", "64 sub-problems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
