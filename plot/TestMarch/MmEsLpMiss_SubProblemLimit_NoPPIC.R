tiff("MmEsLpMiss_SubProblemLimit_NoPPIC.png", width=18, height=9, units='in', res=120)
par(mfrow=c(2,4), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(40706, 45942, 49181, 53823, 72650, 102087, 134307, 178987, 256623, 640713)/1000
one <- c(76531, 81469, 92590, 111161, 134104, 181825, 242819, 350549, 633764, 1631831)/1000
two <- c(61342, 55452, 65093, 79089, 98262, 126020, 167608, 236934, 443781, 1166330)/1000
three <- c(57533, 54785, 61979, 76191, 93587, 115591, 163953, 226882, 419034, 1126916)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(40, 1631))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(313297, 442825, 544055, 681310)/1000
one <- c(159263, 204338, 242120, 302086)/1000
two <- c(202401, 210236, 244044, 262536)/1000
three <- c(310667, 296331, 341564, 377200)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(159, 681))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(17428, 19026, 19383, 21996, 22934, 26508)/1000
one <- c(14327, 13727, 15221, 17748, 20672, 22164)/1000
two <- c(15565, 17185, 17015, 20066, 22117, 27040)/1000
three <- c(13980, 14303, 15660, 18296, 19762, 24820)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 27))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2969, 3111, 3225, 3690, 4343, 4923, 6374, 7561, 12888, 35421)/1000
one <- c(2341, 2816, 3054, 3397, 4377, 5437, 7207, 10320, 17500, 52546)/1000
two <- c(1926, 2203, 2452, 2742, 3243, 4218, 5102, 7146, 16041, 34827)/1000
three <- c(3166, 8770, 3221, 3753, 3120, 3874, 4986, 6680, 12922, 34387)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(1, 52))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(10268, 10593, 13051, 18495, 26989, 52985)/1000
one <- c(7493, 8713, 12261, 17787, 36757, 78213)/1000
two <- c(6333, 7039, 9402, 13992, 26498, 57494)/1000
three <- c(9857, 6724, 9191, 13818, 26157, 55141)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(6, 78))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(48452, 72893, 218883, 321619, 611067, 1044791, 1766618, 3773984)/1000
one <- c(57605, 131416, 343560, 671941, 1263941, 2249285, 4123296, 8054707)/1000
two <- c(36644, 69497, 202612, 405803, 742098, 1454264, 2419428, 5101763)/1000
three <- c(35147, 55129, 206373, 402892, 751354, 1354872, 2446686, 4866818)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(35, 8054))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(24307, 31709, 46931, 49720, 50665, 48902, 60086, 56259, 54245)/1000
one <- c(16611, 41216, 66459, 68633, 67469, 68224, 69621, 71033, 72969)/1000
two <- c(15756, 30925, 46036, 47607, 47413, 46804, 47655, 51816, 50140)/1000
three <- c(24099, 30816, 46840, 47544, 48660, 48474, 47936, 49742, 51248)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(15, 72))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(19557, 22088, 25194, 39173, 42363, 47440, 49872, 58049, 59746)/1000
one <- c(12730, 13109, 14725, 30519, 35937, 33392, 34724, 39403, 42615)/1000
two <- c(12585, 13404, 14462, 27282, 26743, 28844, 29636, 34593, 35264)/1000
three <- c(12802, 13037, 14404, 26860, 27069, 28544, 29121, 35337, 33458)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(12, 59))
lines(x, one, col="red", type="o", pch=1)
lines(x, two, col="magenta", type="o", pch=4)
lines(x, three, col="green", type="o", pch=5)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("NoLimit", "LimitNbExec", "LimitNbExecSquared", "LimitNbExecCube"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red", "magenta", "green"), cex = 1)

dev.off()
