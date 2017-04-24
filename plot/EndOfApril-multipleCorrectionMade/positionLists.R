tiff("positionLists.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(28247, 23874, 27147, 28035, 30995, 37511, 43290, 55725, 77181, 176405)/1000
one <- c(37337, 32697, 27970, 30373, 32682, 40591, 48069, 60031, 83409, 183919)/1000
two <- c(38116, 36789, 38283, 40639, 46390, 55533, 64153, 80930, 129417, 207934)/1000
three <- c(47368, 43620, 45367, 49363, 52340, 60683, 71579, 91719, 145451, 236287)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(23, 236))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(316549, 446706, 554299, 686114)/1000
one <- c(309208, 452549, 559197, 697818)/1000
two <- c(315680, 451714, 558246, 699961)/1000
three <- c(303855, 432112, 531031, 666018)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(303, 699))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15922, 16873, 18065, 19459, 21731, 24384)/1000
one <- c(19982, 21280, 22647, 25012, 27708, 31294)/1000
two <- c(24075, 26398, 28432, 31986, 36034, 42928)/1000
three <- c(26692, 30363, 32181, 35716, 39687, 46274)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(15, 46))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(3170, 2933, 3398, 4253, 3470, 3782, 4780, 5159, 6189, 10052)/1000
one <- c(2932, 2806, 3000, 3212, 4023, 3833, 4207, 4933, 6428, 10305)/1000
two <- c(3312, 3562, 3634, 4135, 4491, 5009, 6289, 7502, 10645, 17440)/1000
three <- c(4143, 3796, 3990, 4555, 4970, 5620, 6821, 8364, 11543, 19496)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 19))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(9556, 10489, 10974, 12881, 20003, 30201)/1000
one <- c(8972, 9745, 10642, 12941, 20040, 32171)/1000
two <- c(10259, 11391, 12983, 16680, 27852, 47720)/1000
three <- c(11880, 13242, 14432, 18345, 30869, 53054)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(8, 53))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(26572, 28193, 35703, 44324, 48639, 57630, 72229, 117669)/1000
one <- c(26603, 28358, 35788, 41110, 47167, 55843, 70414, 117975)/1000
two <- c(40412, 44953, 56164, 69132, 84163, 91173, 110146, 179647)/1000
three <- c(44359, 47508, 60336, 71129, 84512, 95768, 116766, 182728)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(26, 182))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(15077, 16317, 18549, 18766, 19779, 20306, 21739, 23757, 26922)/1000
one <- c(14150, 13045, 13185, 13571, 14194, 15140, 15192, 16338, 16765)/1000
two <- c(15997, 15520, 15734, 16358, 16667, 17206, 19129, 20165, 21183)/1000
three <- c(14276, 13307, 13151, 13339, 13581, 14139, 14847, 15522, 16056)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 26))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(13005, 13462, 15471, 20308, 19068, 20138, 23366, 26772, 27830)/1000
one <- c(13346, 13921, 14900, 18322, 18412, 19671, 21419, 24388, 26252)/1000
two <- c(15161, 16170, 18429, 19679, 21678, 22984, 24890, 29206, 32351)/1000
three <- c(13449, 13955, 14880, 16126, 17360, 18195, 19369, 22095, 23870)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 32))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("reference", "first_pos", "last_pos", "first_last_pos"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
