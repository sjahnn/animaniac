#' Animated monthly plot
#'
#' @param data Input data
#' @param start.date  Start date
#' @param end.date End date
#' @param months Months
#' @param outputname Name of the animated monthly plot
#'
#' @importFrom assertthat is.date
#'
#' @return
#' @export
#'
#' @examples
animated.monthly.report = function(data, start.date, end.date, months, outputname){

        # The function will not run if any of conditions below occurs:
        # 0. Start date (or end date) is not in character format.
        # 1. Start date (or end date) is not in date format.
        # 2. End date occurs before start date.
        # 3. Negative months
        # 4. Months less than 1 or greater than 12
        # 5. Start date has to be larger than the first date of the data.
        # 6. End date has to be smaller than the last date of the data.
        # In addition, stopifnot() will generate an error message if any of conditions
        # have missing value.
        stopifnot(is.character(start.date) == 1, is.character(end.date) ==1,
                  is.date(as.Date(start.date)) == 1, is.date(as.Date(end.date)) == 1, start.date < end.date,
                  months %in% 1:12, rownames(data.frame(data))[1] >= as.Date(start.date),
                  rownames(data.frame(data))[length(data)] <= as.Date(end.date) )


        x = window(data, start=as.Date(start.date), end=as.Date(end.date))
        m = data.frame(prep=daily2monthly(x, FUN=sum)) # monthly values of precipitation
        year = substr(rownames(m),1,4)
        m2 = cbind(m, year=year, month=as.numeric(format(as.POSIXct(rownames(m)),"%m")))
        m3 = m2[m2$month %in% months,] # only specific months

        png(file="plot%02d.png")

        for(i in unique(year)){
                mdat = m3[which(m3$year==i),]
                barplot(mdat$prep, main=paste("Year =",i), ylim=c(0,max(m$prep)), las=2, names.arg=month.name[months])
        }
        dev.off()
        png_files = list.files(pattern=".*png$", full.names=TRUE)
        # Customize the name of your output.
        gifski(png_files, gif_file=paste(outputname,".gif",sep=""), width=800, height=600, delay=1)

        file.remove(list.files(pattern=".png"))
}
