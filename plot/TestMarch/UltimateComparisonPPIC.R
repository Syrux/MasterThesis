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
six <- c(25468, 25299, 27646, 28716, 32508, 37824, 46734, 54019, 76390, 181579)/1000

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
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(273254, 352139, 433728, 530863)/1000
one <- c(246882, 312195, 434838, 520212)/1000
two <- c(236981, 298804, 391152, 513338)/1000
three <- c(233953, 297675, 391983, 472554)/1000
four <- c(235901, 303927, 406530, 496255)/1000
five <- c(240123, 306535, 430516, 519567)/1000
six <- c(234200, 300092, 409706, 529295)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(233, 530))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10677, 11312, 11903, 13425, 14473, 15247)/1000
one <- c(18246, 18937, 20654, 21961, 24087, 29184)/1000
two <- c(16207, 16695, 17845, 19250, 21191, 24124)/1000
three <- c(19159, 20027, 21617, 23328, 25965, 30033)/1000
four <- c(25797, 27586, 30275, 34992, 37916, 45927)/1000
five <- c(29304, 31698, 34518, 39096, 43527, 50453)/1000
six <- c(19974, 19864, 23642, 23174, 26705, 29502)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 50))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
lines(x, four, col="black", type="o", pch=6)
lines(x, five, col="darkgoldenrod", type="o", pch=7)
lines(x, six, col="darkgrey", type="o", pch=8)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
two <- c(2746, 2609, 2725, 2889, 3212, 3208, 3636, 4063, 5061, 7866)/1000
three <- c(2932, 2806, 3000, 3212, 4023, 3833, 4207, 4933, 6428, 10305)/1000
four <- c(3312, 3562, 3634, 4135, 4491, 5009, 6289, 7502, 10645, 17440)/1000
five <- c(4143, 3796, 3990, 4555, 4970, 5620, 6821, 8364, 11543, 19496)/1000
six <- c(3256, 3298, 5815, 3512, 3780, 4144, 4528, 5296, 6635, 10178)/1000

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
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
two <- c(8387, 8745, 9591, 10901, 15052, 23029)/1000
three <- c(8972, 9745, 10642, 12941, 20040, 32171)/1000
four <- c(10259, 11391, 12983, 16680, 27852, 47720)/1000
five <- c(11880, 13242, 14432, 18345, 30869, 53054)/1000
six <- c(9662, 11067, 11082, 13114, 19144, 30595)/1000

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
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
two <- c(21749, 23663, 28585, 31912, 36089, 41339, 51483, 81367)/1000
three <- c(26603, 28358, 35788, 41110, 47167, 55843, 70414, 117975)/1000
four <- c(40412, 44953, 56164, 69132, 84163, 91173, 110146, 179647)/1000
five <- c(44359, 47508, 60336, 71129, 84512, 95768, 116766, 182728)/1000
six <- c(28564, 29545, 36558, 41357, 47951, 57919, 72352, 115346)/1000

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
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_PPIC", "MmEsLpMiss_simpleClean", "firstPos_PPIC", "lastPos_PPIC", "firstLastPos_PPIC", "MaxItem_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green", "black", "darkgoldenrod", "darkgrey"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

two <- c(16109, 19190, 21142, 23318, 23831, 24810, 28111, 30013, 31588)/1000

#PLOT
plot(x, two, log = "xy", type="o", pch=4, xlab="Minsup(%)",ylab="Time (s logscale)", col="magenta", xlim = rev(range(x)), ylim=c(16, 31))
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("MmEsLpMiss_simpleClean"), lty=c(1,1),lwd=c(2,2), col=c("magenta"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

two <- c(19480, 22694, 25047, 28425, 30926, 32442, 35665, 42130, 45709)/1000

#PLOT
plot(x, two, log = "xy", type="o", pch=4, xlab="Minsup(%)",ylab="Time (s logscale)", col="magenta", xlim = rev(range(x)), ylim=c(19, 45))
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("MmEsLpMiss_simpleClean"), lty=c(1,1),lwd=c(2,2), col=c("magenta"), cex = 1)

dev.off()
