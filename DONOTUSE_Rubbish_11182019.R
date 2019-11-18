library(devtools)
library(roxygen2)

#document()
setwd("..")
#setwd("/Users/seungjunahn/Desktop/University of Florida/Biostatistical Computing/FinalProject/animaniac")
install("animaniac")
library(animaniac)
# #' @usage data(SanMartinoPPts)

?animated.hist.kernel
?animated.monthly.report


setwd("/Users/seungjunahn/Desktop/University of Florida/Biostatistical Computing/FinalProject/TempPNG")

animated.hist.kernel(x=iris$Sepal.Length, nbreaks=30, bw.min=0.1, bw.max=0.5, bw.n=20, outputname="animated1")


