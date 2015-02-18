# *****************************************************************************
# File plot2.R
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************


#Load and filter data
source("load-data.R")

# locale = English forces days in English in x-axis
Sys.setlocale("LC_TIME", "English") 

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

plot(data$DateTime, data$Global_active_power,
     type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")


# close graphic device
dev.off()