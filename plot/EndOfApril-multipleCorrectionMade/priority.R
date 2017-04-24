tiff("priority.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
one <- c(26027, 27023, 32443, 31309, 35641, 38792, 46734, 57341, 85252, 196914)/1000
two <- c(13414, 13109, 13897, 15283, 17443, 21461, 28338, 30856, 63656, 255987)/1000
three <- c(12250, 11911, 12598, 13590, 15556, 17579, 20624, 30968, 69848, 257575)/1000
four <- c(13141, 12778, 13040, 14775, 16084, 17337, 23401, 32681, 53123, 248297)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 257))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(316549, 446706, 554299, 686114)/1000
one <- c(316804, 464647, 605050, 746038)/1000
two <- c(165263, 187800, 205075, 231116)/1000
three <- c(431700, 496491, 583576, 604294)/1000
four <- c(329324, 996101, 1342917, 0)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 1342))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000
one <- c(20312, 21548, 23558, 25692, 27424, 31209)/1000
two <- c(10306, 10974, 11639, 11797, 12869, 16204)/1000
three <- c(10091, 10542, 13134, 14474, 14179, 14516)/1000
four <- c(10114, 11990, 11167, 12496, 13009, 14759)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 31))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
one <- c(3300, 3561, 3553, 3894, 4119, 4491, 5040, 5748, 7762, 11424)/1000
two <- c(1649, 1804, 1734, 2033, 2152, 2247, 2476, 2649, 3047, 5036)/1000
three <- c(1716, 1610, 1732, 1871, 1860, 2107, 3138, 3024, 2995, 4853)/1000
four <- c(3451, 3340, 4024, 3870, 1954, 2237, 2412, 3511, 2944, 5142)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 11))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
one <- c(10906, 11438, 12814, 14668, 22113, 34746)/1000
two <- c(4539, 5519, 5598, 6982, 9746, 15707)/1000
three <- c(4103, 4661, 5469, 6418, 9352, 16319)/1000
four <- c(10779, 5284, 5521, 6870, 10242, 17636)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 34))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
one <- c(32601, 33306, 40961, 46978, 53265, 64710, 80030, 107424)/1000
two <- c(8570, 10435, 15376, 21770, 31940, 44612, 76424, 138666)/1000
three <- c(7991, 9889, 17071, 21301, 30194, 42743, 74129, 125403)/1000
four <- c(37114, 37690, 16202, 23195, 32211, 49033, 75680, 137218)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(7, 138))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(15077, 16317, 18549, 18766, 19779, 20306, 21739, 23757, 26922)/1000
one <- c(19142, 23931, 28620, 30275, 30929, 31575, 34504, 41248, 38065)/1000
two <- c(15222, 20134, 27085, 26180, 26208, 26738, 27782, 28109, 29363)/1000
three <- c(13195, 19352, 23938, 24986, 25591, 26928, 26693, 27163, 28087)/1000
four <- c(14300, 17329, 22342, 21351, 22332, 22395, 23501, 24327, 24131)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 41))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13005, 13462, 15471, 20308, 19068, 20138, 23366, 26772, 27830)/1000
one <- c(18129, 20083, 22657, 28319, 30769, 31230, 36166, 39556, 42935)/1000
two <- c(12494, 13430, 14405, 18248, 19883, 18568, 20970, 22171, 23745)/1000
three <- c(12709, 12832, 14086, 17989, 19065, 19381, 22070, 23804, 24787)/1000
four <- c(12920, 13269, 14213, 17606, 18037, 18537, 20523, 21706, 23048)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(12, 42))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

dev.off()
