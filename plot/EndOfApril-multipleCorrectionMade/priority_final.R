tiff("priority_final.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
one <- c(31332, 26380, 24720, 28192, 30125, 34889, 42302, 52264, 74045, 164320)/1000
two <- c(19704, 11563, 12239, 14255, 16192, 18492, 22396, 29361, 59025, 282634)/1000
three <- c(19207, 11934, 13727, 13732, 14510, 17091, 21315, 34415, 59900, 263733)/1000
four <- c(19186, 12594, 11541, 14517, 16567, 18621, 24621, 32965, 58919, 277550)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 282))
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
one <- c(319584, 458499, 573265, 718664)/1000
two <- c(155514, 171729, 182056, 204187)/1000
three <- c(382166, 446636, 499930, 535722)/1000
four <- c(313136, 847822, 1138030, 1381424)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(155, 1381))
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
one <- c(16154, 17057, 17960, 24146, 24195, 24317)/1000
two <- c(8388, 9561, 9546, 9514, 10688, 12650)/1000
three <- c(8656, 8562, 11449, 10077, 10551, 11985)/1000
four <- c(8890, 8527, 9236, 9805, 11357, 12247)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(8, 24))
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
one <- c(2888, 2775, 3089, 3161, 3508, 3767, 4187, 4662, 5872, 9156)/1000
two <- c(1257, 1558, 1445, 1516, 1661, 1930, 1777, 2146, 2330, 4891)/1000
three <- c(1247, 1456, 1535, 1513, 1635, 1821, 2502, 1999, 2707, 4899)/1000
four <- c(2764, 2928, 2879, 3103, 1700, 1816, 1774, 2025, 2291, 4824)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 10))
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
one <- c(8852, 9363, 10310, 12235, 19175, 28152)/1000
two <- c(3921, 4037, 4745, 5487, 8120, 14512)/1000
three <- c(3967, 3924, 4824, 5950, 8576, 12571)/1000
four <- c(9146, 4150, 4698, 5576, 7973, 12638)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(3, 30))
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
one <- c(26086, 28163, 34827, 40931, 47670, 56325, 71831, 106122)/1000
two <- c(7544, 9577, 14093, 19233, 28362, 42406, 70050, 126602)/1000
three <- c(9345, 8978, 15358, 20475, 28851, 46572, 69498, 132928)/1000
four <- c(25285, 27219, 13943, 18855, 29384, 43116, 70155, 125156)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(7, 132))
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
one <- c(17399, 19664, 23112, 23545, 24104, 25054, 28027, 28895, 32042)/1000
two <- c(14768, 21367, 27748, 27955, 28310, 28616, 29882, 30885, 32790)/1000
three <- c(13061, 15424, 18343, 18000, 19866, 19121, 20511, 20964, 21677)/1000
four <- c(14514, 19874, 25262, 26400, 27033, 26629, 28638, 31148, 30113)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 32))
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
one <- c(16291, 17886, 19608, 23313, 24803, 26232, 30373, 33801, 36116)/1000
two <- c(11941, 12336, 13696, 17390, 18401, 20277, 21024, 22835, 24893)/1000
three <- c(11446, 11856, 12576, 14385, 15655, 16482, 16405, 18173, 19529)/1000
four <- c(12155, 12588, 13803, 16472, 18342, 20017, 18990, 20817, 23752)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 36))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "noSubLimit", "4 subproblems", "16 subproblems", "64 subproblems"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black"), cex = 1)

dev.off()
