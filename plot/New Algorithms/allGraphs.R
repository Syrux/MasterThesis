
#png(file="mygraphic.png",width=1259,height=756)
par(mfrow=c(2,3))
# 300 partitions everywhere (except sparkPPIC, of course)

#BIBLE 
#DATA
x <- rev(c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01)*100)

spark <-c(120533, 128060, 140167, 157374, 180987, 214660, 277136, 363336, 599299, 0)/1000
sparkPPIC <- c(72493, 71476, 73961, 77192, 79149, 83273, 96695, 99406, 126792, 303826)/1000
sparkCPMap <- c(306833, 463417, 515342, 624510, 730545, 0, 0, 0, 0, 0)/1000
sparkCPArray <- c(239212, 279359, 370612, 464873, 575584, 819977, 0, 0, 0, 0)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(70, 850))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="BIBLE", cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)

#FIFA 
#DATA
x <- rev(c(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14)*100)

spark <-c(230895, 480474, 1253763, 2080473, 0, 0, 0, 0)/1000
sparkPPIC <- c(56639, 53848, 67270, 92645, 130974, 139763, 158870, 245169)/1000
sparkCPMap <- c(227256, 504521, 923323, 0, 0, 0, 0, 0)/1000
sparkCPArray <- c(224544, 392279, 740741, 1108297, 1655731, 2662610, 0, 0)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(55, 3000))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="FIFA", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("bottomleft", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#KOSARAK 
#DATA
x <- rev(c(0.0020, 0.0022, 0.0024, 0.0026, 0.0028, 0.0030)*100)

spark <- c(85207, 89607, 94796, 111652, 112545, 125368)/1000
sparkPPIC <- c(72853, 75134, 76364, 79079, 82005, 87426)/1000
sparkCPMap <- c(119807, 130849, 153225, 173705, 189371, 223590)/1000
sparkCPArray <- c(116795, 121702, 117764, 127147, 142430, 162014)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(70, 250))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="Kosarak-70", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#LEVIATHAN 
#DATA
x <- rev(c(0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1)*100)

spark <-c(27795, 28547, 30378, 32613, 34750, 39251, 44618, 53540, 75583, 159321)/1000
sparkPPIC <- c(25739, 26887, 27743, 28844, 29933, 31517, 33208, 34944, 38670, 46764)/1000
sparkCPMap <- c(37580, 39417, 40832, 51747, 44725, 50491, 58006, 70175, 101046, 232967)/1000
sparkCPArray <- c(32660, 32294, 38910, 41836, 44770, 49933, 47563, 54105, 79554, 188720)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="Time (s logscale)", col="blue", ylim=c(25, 250))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="LEVIATHAN", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#PROTEIN 
#DATA
x <- rev(c(0.99984, 0.99986, 0.99988, 0.9999)*100)

spark <-c(416332, 518093, 840899, 1158215)/1000
sparkPPIC <- c(346658, 399486, 437277, 446292)/1000
sparkCPMap <- c(688285, 899486, 0, 0)/1000
sparkCPArray <- c(511053, 493237, 598874, 677839)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(330, 1200))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="Protein", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#PUBMED 
#DATA
x <- rev(c(0.005, 0.01, 0.02, 0.03, 0.04, 0.05)*100)

spark <-c(48962, 54762, 65118, 86453, 148804, 272193)/1000
sparkPPIC <- c(39894, 42527, 45842, 53072, 67256, 81245)/1000
sparkCPMap <- c(71474, 71340, 83013, 130118, 345680, 836681)/1000
sparkCPArray <- c(55085, 63331, 76955, 116025, 263113, 559204)/1000

#PLOT
plot(x,spark, log = "xy", type="o", pch=0, xlab="Minsup(%)", ylab="", col="blue", ylim=c(35, 900))
lines(x,sparkPPIC, col="red", type="o", pch=1)
lines(x,sparkCPMap, col="magenta", type="o", pch=4)
lines(x,sparkCPArray, col="green", type="o", pch=5)
title(main="Pubmed", font.main=4, cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
grid()
legend("topright", legend=c("Spark", "sparkPPIC", "SparkCP - Map", "SparkCP - Array"), lty=c(1,1),lwd=c(2,2), col=c("blue","red", "magenta", "green"), cex = 1)


#dev.off()