tiff("MmEsLpMiss_MissRecalculated_PPIC.png", width=13, height=9, units='in', res=120)
par(mfrow=c(2,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
one <- c(39396, 27094, 29532, 32020, 36532, 40517, 43092, 53869, 81555, 186801)/1000
two <- c(35440, 28447, 29999, 32490, 35507, 41662, 47732, 58475, 83229, 198310)/1000
three <- c(32870, 28767, 29957, 32192, 35013, 41822, 47814, 57163, 86652, 196703)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(17, 664))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(359711, 490719, 613541, 726131)/1000
one <- c(307612, 464197, 576235, 696708)/1000
two <- c(308457, 444165, 545535, 688441)/1000
three <- c(312132, 441823, 545013, 677614)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(307, 726))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10592, 10615, 11709, 12472, 13241, 15153)/1000
one <- c(18647, 20060, 22353, 22557, 24497, 27268)/1000
two <- c(18864, 19987, 22158, 23059, 25192, 28220)/1000
three <- c(18623, 20121, 22541, 23080, 26632, 28760)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 28))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3460, 3708, 3740, 4138, 4108, 4718, 5141, 6032, 7375, 11314)/1000
two <- c(3674, 3656, 4060, 4162, 4588, 4913, 5445, 6154, 7707, 11863)/1000
three <- c(3373, 3310, 3735, 3753, 4151, 4547, 5131, 5808, 8342, 11590)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 12))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(11021, 12422, 12629, 14881, 21142, 33065)/1000
two <- c(11266, 12419, 13176, 15261, 22721, 35077)/1000
three <- c(10827, 11440, 12581, 14757, 21838, 34785)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 35))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(32386, 34014, 40107, 47617, 53681, 63171, 75265, 119363)/1000
two <- c(32837, 34073, 40610, 47712, 55739, 63277, 76324, 121852)/1000
three <- c(33227, 34168, 41184, 47836, 57166, 66103, 79196, 125000)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(9, 204))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MaxItemRecalculated_0_PPIC", "MaxItemRecalculated_1_PPIC", "MaxItemRecalculated_2_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100


#PLOT
#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100


#PLOT
dev.off()
