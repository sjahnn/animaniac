
#' Animated histogram with varying kernel density estimates
#'
#' @param x Variable of interest
#' @param nbreaks Number of breaks for histogram
#' @param bw.min Minimum bandwidth for kernel density
#' @param bw.max Maximum bandwidth for kernel density
#' @param bw.n Number of bandwidth numbers to consider for an animated plot. Default is 20.
#' @param outputname Output name to be saved
#'
#' @importFrom gifski gifski
#'
#' @export
#'
#' @examples setwd("/Users/seungjunahn/Documents/temp") #set the directory with a new folder
#' @examples animated.hist.kernel(x=iris$Sepal.Length, nbreaks=30, bw.min=0.1, bw.max=0.5, bw.n=20, outputname="animated1")
animated.hist.kernel = function(x, nbreaks, bw.min, bw.max, bw.n=20, outputname){
        # The function will not run if any of conditions below occurs:
        # 1. Negative breaks number (nbreaks)
        # 2. Negative bandwidth range (bw.min and bw.max)
        # 3. Bandwidth max is less than bandwidth min
        # 4. Negative bandwidth numbers (bw.n)
        # 5. Variable (x) is not continuous.
        # In addition, stopifnot() will generate an error message if any of conditions
        # have missing value.
        stopifnot(nbreaks > 0, bw.min > 0, bw.max > 0, bw.max > bw.min, is.numeric(x) == 1)


        myparam = seq(bw.min, bw.max, length.out=bw.n)
        png(file="plot%02d.png")

        for(i in 1:length(myparam)){
                hist(x, freq=FALSE, breaks=nbreaks, main=paste("Bandwidth =", round(myparam[i],4)))
                d = density(x, bw=myparam[i])
                lines(d, lwd=2, col="red")
        }

        dev.off()
        png_files = list.files(pattern=".*png$", full.names=TRUE)
        gifski(png_files, gif_file=paste(outputname,".gif",sep=""), width=800, height=600, delay=0.5)

        # We do not want all of PNG files created, and we get our GIF (animated plots) ONLY!
        # Again, please make sure you create a new empty folder for animated plots without
        # PNG files. Otherwise, the command below will also remove your existing PNG files.
        file.remove(list.files(pattern=".png"))
}
