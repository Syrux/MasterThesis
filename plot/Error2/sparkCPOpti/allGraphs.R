
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))

#BIBLE 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.10)*100

sparkNP <-c(173812, 161610, 131754, 53738, 44395, 34756, 30610, 27974, 24947, 19987, 15044, 12239, 10914)/1000
sparkPPIC <- c(150723, 115710, 84153, 48707, 40943, 33764, 30361, 27948, 24831, 19688, 14911, 12159, 10918)/1000
sparkCP <- c(174918, 134047, 94492, 52838, 44268, 35571, 31890, 28635, 26119, 20543, 15576, 12683, 11354)/1000
sparkCPMap <- c(161097, 124742, 103206, 57818, 42406, 34255, 30945, 28075, 25188, 19871, 15265, 12617, 11349)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(12, 200))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))

#FIFA 
#DATA
x <- c(0.0001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.10, 0.14, 0.18, 0.22)*100

sparkNP <- c(47572, 35631, 32278, 31381, 30496, 29192, 28357, 27400, 27380, 28040, 21667, 14598, 14651, 13294)/1000
sparkPPIC <- c(43620, 34604, 32904, 32074, 31306, 29560, 29193, 29855, 28350, 27236, 21180, 14881, 14039, 13432)/1000
sparkCP <- c(44156, 34983, 32533, 31479, 30846, 30753, 28866, 28138, 27500, 27240, 21399, 15190, 14230, 13643)/1000
sparkCPMap <- c(42092, 33278, 31266, 30363, 29952, 29504, 31709, 30803, 30887, 27909, 21048, 14835, 15960, 13607)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(13, 52))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))


#KOSARAK 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.002, 0.004, 0.006, 0.008, 0.01)*100

sparkNP <- c(411088, 199180, 145584, 67172, 48482, 35759, 28412, 25772, 19962, 16535)/1000
sparkPPIC <- c(387796, 183518, 139266, 63920, 52935, 35868, 28153, 25438, 20055, 16337)/1000
sparkCP <- c(444306, 213002, 155303, 69194, 50479, 37326, 28859, 26186, 20662, 17155)/1000
sparkCPMap <- c(416308, 204533, 142086, 65316, 47757, 35975, 28106, 25704, 20228, 16726)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(16, 500))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))


#LEVIATHAN 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.04, 0.06, 0.08, 0.1)*100

sparkNP <- c(46158, 45680, 45459, 32050, 28681, 25844, 23952, 22844, 23066, 20881, 15871, 13570, 10950)/1000
sparkPPIC <- c(41206, 41098, 46700, 31285, 27711, 25596, 23960, 22538, 21170, 20423, 15768, 13020, 10890)/1000
sparkCP <- c(43225, 43045, 42862, 31691, 28166, 25565, 24347, 22684, 21353, 22644, 16143, 13277, 11208)/1000
sparkCPMap <- c(41157, 40777, 41010, 30427, 27628, 25075, 23793, 22588, 21243, 20732, 16183, 13345, 10947)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(10, 50))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))


#PROTEIN 
#DATA
x <- c(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99, 0.999, 0.9999)*100

sparkNP <- c(55278, 51430, 50950, 50336, 49549, 49803, 48242, 47436, 43457, 26721)/1000
sparkPPIC <-  c(93732, 90741, 91059, 90999, 91235, 91545, 88524, 86405, 75279, 35563)/1000
sparkCP <- c(79285, 77851, 76683, 76749, 76892, 77198, 74721, 72824, 64796, 34120)/1000
sparkCPMap <- c(57044, 55519, 56025, 55063, 56175, 55768, 53655, 52482, 48276, 29105)/1000

#PLOT
plot(x,sparkNP, log = "y", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(28, 105))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))


#PUBMED 
#DATA
x <- c(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100

sparkNP <- c(157983, 154492, 91034, 46987, 38834, 31699, 29509, 28272, 23992, 22035, 17337, 15673)/1000
sparkPPIC <- c(128653, 124927, 75712, 43018, 36441, 31046, 28413, 26053, 23717, 22047, 17110, 14647)/1000
sparkCP <- c(138695, 136073, 81498, 44564, 37479, 31736, 28882, 26709, 24701, 22053, 17630, 15091)/1000
sparkCPMap <- c(129494, 130714, 76560, 42591, 36545, 31148, 28326, 26036, 23646, 21878, 17467, 14878)/1000

#PLOT
plot(x,sparkNP, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(15, 170))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCP, col="green", type="o", pch=4)
lines(x,sparkCPMap, col="magenta", type="o", pch=5)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark - no permutation", "Spark - PPIC", "Spark - CP - Array", "Spark - CP - Map"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "green", "magenta"))

#dev.off()