# *****************************************************************************
# File plot4.R
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************


#Load and filter data
source("load-data.R")

# locale = English forces days in English in x-axis
Sys.setlocale("LC_TIME", "English")            

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

par( mfrow = c(2, 2) )

with(data, {
  
  # Graph (1,1)

  plot(DateTime, Global_active_power,
       type = "l",
       xlab = "", ylab = "Global Active Power (kilowatts)")

  # Graph (1, 2)
       
  plot(DateTime, Voltage,
       type = "l",
       xlab = "datetime", ylab = "Voltage")
  
  # Graph (2, 1)
  
  plot(DateTime, Sub_metering_1, type = "l", col="black",
         xlab = "", ylab = "Energy sub metering")

  lines(DateTime, Sub_metering_2, type = "l", col="red")

  lines(DateTime, Sub_metering_3, type = "l", col="blue")

  legend("topright", lwd = 1, bty = "n", col=c("black", "red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  # Graph (2, 2)

  plot(DateTime, Global_reactive_power,
       type = "l",
       xlab = "datetime", ylab = "Global_reactive_power")

})

# close graphic device
dev.off()