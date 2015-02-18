# *****************************************************************************
# File plot3.R
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************


#Load and filter data
source("load-data.R")

# locale = English forces days in English in x-axis
Sys.setlocale("LC_TIME", "English")            


png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

with(data, {
  
  plot(DateTime, Sub_metering_1, type = "l", col="black",
       xlab = "", ylab = "Energy sub metering")

  lines(DateTime, Sub_metering_2, type = "l", col="red")

  lines(DateTime, Sub_metering_3, type = "l", col="blue")

  legend("topright", lwd = 1, col=c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

})

# close graphic device
dev.off()