tiff("MmEsLpMiss_priority_PPIC.png", width=13, height=9, units='in', res=120)
par(mfrow=c(2,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(18850, 18071, 17611, 19872, 23860, 33086, 44031, 64446, 155871, 664830)/1000
one <- c(26027, 27023, 32443, 31309, 35641, 38792, 46734, 57341, 85252, 196914)/1000
two <- c(13414, 13109, 13897, 15283, 17443, 21461, 28338, 30856, 63656, 255987)/1000
three <- c(12250, 11911, 12598, 13590, 15556, 17579, 20624, 30968, 69848, 257575)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(11, 664))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(359711, 490719, 613541, 726131)/1000
one <- c(316804, 464647, 605050, 746038)/1000
two <- c(165263, 187800, 205075, 231116)/1000
three <- c(431700, 496491, 583576, 604294)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(165, 746))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(10592, 10615, 11709, 12472, 13241, 15153)/1000
one <- c(20312, 21548, 23558, 25692, 27424, 31209)/1000
two <- c(10306, 10974, 11639, 11797, 12869, 16204)/1000
three <- c(10091, 10542, 13134, 14474, 14179, 14516)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 31))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(1729, 1793, 1857, 1919, 2077, 2306, 2672, 3117, 4718, 12253)/1000
one <- c(3300, 3561, 3553, 3894, 4119, 4491, 5040, 5748, 7762, 11424)/1000
two <- c(1649, 1804, 1734, 2033, 2152, 2247, 2476, 2649, 3047, 5036)/1000
three <- c(1716, 1610, 1732, 1871, 1860, 2107, 3138, 3024, 2995, 4853)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 12))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(4767, 5261, 6040, 7894, 12184, 32451)/1000
one <- c(10906, 11438, 12814, 14668, 22113, 34746)/1000
two <- c(4539, 5519, 5598, 6982, 9746, 15707)/1000
three <- c(4103, 4661, 5469, 6418, 9352, 16319)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(4, 34))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(9423, 13932, 21048, 31249, 43581, 66511, 112528, 204980)/1000
one <- c(32601, 33306, 40961, 46978, 53265, 64710, 80030, 107424)/1000
two <- c(8570, 10435, 15376, 21770, 31940, 44612, 76424, 138666)/1000
three <- c(7991, 9889, 17071, 21301, 30194, 42743, 74129, 125403)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(7, 204))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("BasePPIC", "MmEsLpMiss_priority_NoSubLimit_PPIC", "MmEsLpMiss_priority_SubLimit_nbExec_PPIC", "MmEsLpMiss_priority_SubLimit_nbExecSquared_PPIC"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100


#PLOT
#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100


#PLOT
dev.off()
