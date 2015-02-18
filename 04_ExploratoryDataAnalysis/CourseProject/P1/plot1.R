# *****************************************************************************
# File plot1.R
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************


#Load and filter data
source("load-data.R")

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

hist(data$Global_active_power,
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     col = "red")

# close graphic device
dev.off()