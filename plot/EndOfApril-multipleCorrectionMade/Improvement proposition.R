tiff("Improvement proposition.png", width=9, height=9, units='in', res=120)
par(mfrow=c(3,3), cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

#BIBLE
#DATA
x <- c(0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001)*100

zero <- c(61421, 56039, 64404, 77005, 95499, 119177, 161264, 237380, 418953, 1123047)/1000
one <- c(51911, 43421, 49318, 58845, 71485, 89040, 117958, 172756, 297617, 758238)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(43, 1123))
lines(x, one, col="red", type="o", pch=1)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#protein
#DATA
x <- c(0.9999, 0.99988, 0.99987, 0.99986)*100

zero <- c(349547, 491547, 589433, 731210)/1000
one <- c(348641, 463671, 562825, 714033)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(348, 731))
lines(x, one, col="red", type="o", pch=1)
title(main="protein", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#Kosarak-70
#DATA
x <- c(0.003, 0.0028, 0.0026, 0.0024, 0.0022, 0.002)*100

zero <- c(15374, 16278, 18766, 20471, 22076, 26287)/1000
one <- c(13626, 14164, 15519, 17114, 18521, 21968)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(13, 26))
lines(x, one, col="red", type="o", pch=1)
title(main="Kosarak-70", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#LEVIATHAN
#DATA
x <- c(0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01)*100

zero <- c(2163, 2415, 2624, 3031, 3211, 4100, 5348, 7298, 13737, 33265)/1000
one <- c(2023, 2218, 2202, 2674, 2962, 3426, 4167, 5904, 10298, 23218)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(2, 33))
lines(x, one, col="red", type="o", pch=1)
title(main="LEVIATHAN", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#PubMed
#DATA
x <- c(0.05, 0.04, 0.03, 0.02, 0.01, 0.005)*100

zero <- c(6480, 7514, 9662, 13262, 26733, 54894)/1000
one <- c(5539, 6494, 8176, 11189, 20628, 40861)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(5, 54))
lines(x, one, col="red", type="o", pch=1)
title(main="PubMed", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#FIFA
#DATA
x <- c(0.14, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05)*100

zero <- c(34721, 78304, 202693, 430468, 800214, 1370544, 2550223, 4809929)/1000
one <- c(29243, 63196, 168480, 341458, 635816, 1087250, 2042733, 3842188)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(29, 4809))
lines(x, one, col="red", type="o", pch=1)
title(main="FIFA", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#slen1
#DATA
x <- c(0.0017, 0.00165, 0.0016, 0.00155, 0.0015, 0.00145, 0.0014, 0.00135, 0.0013)*100

zero <- c(17548, 22658, 30700, 30193, 31847, 31040, 32721, 33085, 34900)/1000
one <- c(14556, 21944, 29900, 29980, 30380, 30445, 32157, 33005, 33640)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(14, 34))
lines(x, one, col="red", type="o", pch=1)
title(main="slen1", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

#slen2
#DATA
x <- c(0.0015, 0.00145, 0.0014, 0.00135, 0.0013, 0.00125, 0.0012, 0.00115, 0.0011)*100

zero <- c(11281, 11586, 13931, 17932, 19220, 19016, 21690, 23158, 24108)/1000
one <- c(10860, 11565, 12856, 18006, 19309, 18718, 20803, 22834, 24442)/1000

#PLOT
plot(x, zero, log = "xy", type="o", pch=0, xlab="Minsup(%)",ylab="Time (s logscale)", col="blue", xlim = rev(range(x)), ylim=c(10, 24))
lines(x, one, col="red", type="o", pch=1)
title(main="slen2", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomright", legend=c("Original_Spark", "Improved_version"), lty=c(1,1),lwd=c(2,2), col=c("blue", "red"), cex = 1)

dev.off()
