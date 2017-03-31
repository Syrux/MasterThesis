tiff("UltimateComparisonPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
one <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
two <- c(28351, 20613, 21988, 21630, 25407, 28760, 34332, 42121, 59129, 144700)/1000
three <- c(37337, 32697, 27970, 30373, 32682, 40591, 48069, 60031, 83409, 183919)/1000
four <- c(38116, 36789, 38283, 40639, 46390, 55533, 64153, 80930, 129417, 207934)/1000
five <- c(47368, 43620, 45367, 49363, 52340, 60683, 71579, 91719, 145451, 236287)/1000
six <- c(22525, 20743, 21401, 22428, 23459, 28200, 33593, 42280, 58723, 143557)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(17, 664))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(359711, 490719, 613541, 726131)/1000
one <- c(316549, 446706, 554299, 686114)/1000
two <- c(307324, 445807, 569527, 715469)/1000
three <- c(309208, 452549, 559197, 697818)/1000
four <- c(315680, 451714, 558246, 699961)/1000
five <- c(303855, 432112, 531031, 666018)/1000
six <- c(325769, 462997, 606735, 740408)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(303, 740))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10592, 10615, 11709, 12472, 13241, 15153)/1000
one <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000
two <- c(16688, 17908, 18961, 20953, 22498, 25327)/1000
three <- c(19982, 21280, 22647, 25012, 27708, 31294)/1000
four <- c(24075, 26398, 28432, 31986, 36034, 42928)/1000
five <- c(26692, 30363, 32181, 35716, 39687, 46274)/1000
six <- c(15588, 17048, 17596, 19098, 20958, 23497)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 46))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
two <- c(2746, 2609, 2725, 2889, 3212, 3208, 3636, 4063, 5061, 7866)/1000
three <- c(2932, 2806, 3000, 3212, 4023, 3833, 4207, 4933, 6428, 10305)/1000
four <- c(3312, 3562, 3634, 4135, 4491, 5009, 6289, 7502, 10645, 17440)/1000
five <- c(4143, 3796, 3990, 4555, 4970, 5620, 6821, 8364, 11543, 19496)/1000
six <- c(2510, 2577, 2677, 2725, 3081, 3125, 3601, 3887, 5504, 7288)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 19))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
two <- c(8387, 8745, 9591, 10901, 15052, 23029)/1000
three <- c(8972, 9745, 10642, 12941, 20040, 32171)/1000
four <- c(10259, 11391, 12983, 16680, 27852, 47720)/1000
five <- c(11880, 13242, 14432, 18345, 30869, 53054)/1000
six <- c(8307, 8559, 9442, 10633, 14689, 22462)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 53))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
two <- c(21749, 23663, 28585, 31912, 36089, 41339, 51483, 81367)/1000
three <- c(26603, 28358, 35788, 41110, 47167, 55843, 70414, 117975)/1000
four <- c(40412, 44953, 56164, 69132, 84163, 91173, 110146, 179647)/1000
five <- c(44359, 47508, 60336, 71129, 84512, 95768, 116766, 182728)/1000
six <- c(20683, 22658, 26916, 30191, 34036, 41168, 52060, 74124)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 204))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

two <- c(16109, 19190, 21142, 23318, 23831, 24810, 28111, 30013, 31588)/1000
six <- c(16903, 18691, 21227, 23410, 25048, 26062, 29873, 31750, 32163)/1000

#PLOT
plot(x, two, log = "xy", type="o", pch=4, xlab="Minsup(%)",ylab="Time (s logscale)", col="magenta", xlim = rev(range(x)), ylim=c(16, 32))
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("MmEsLpMiss_simpleClean", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("magenta", "darkgrey"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

two <- c(19480, 22694, 25047, 28425, 30926, 32442, 35665, 42130, 45709)/1000
six <- c(20289, 22537, 25372, 28287, 31163, 32456, 36837, 42475, 45137)/1000

#PLOT
plot(x, two, log = "xy", type="o", pch=4, xlab="Minsup(%)",ylab="Time (s logscale)", col="magenta", xlim = rev(range(x)), ylim=c(19, 45))
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("MmEsLpMiss_simpleClean", "FinalVersionNoRegex"), lty=c(1,1),lwd=c(2,2), col=c("magenta", "darkgrey"), cex = 1)

dev.off()
