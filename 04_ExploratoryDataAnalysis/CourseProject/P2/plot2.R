# *****************************************************************************
# File plot2.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************

# Question

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.


## Create directory for downloaded data. If this dir does not exist, data will
## be downloaded, else we will assume the data is already available.

if(!file.exists("data")) {
  dir.create("data")
  f <- file.path(getwd(), "data/household_power_consumption.zip")
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, f) 
  downloadedTime <- Sys.time()
  unzip(f, exdir="./data")
  
}


# Loading data 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subseting data. Batimore City, Mariland ==> fips

BaltimoreData <- subset(NEI, fips == "24510")


BaltimoreYearEmissions <- aggregate(formula = Emissions ~year, 
                                    data = BaltimoreData,
                                    FUN = sum,
                                    na.action = na.omit)

if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot2.png", bg = "white")

bp <- barplot(BaltimoreYearEmissions$Emissions, 
              names.arg = BaltimoreYearEmissions$year,
              main = expression('Total emissions from PM'[2.5]*' in Baltimore from 1999 to 2008'),
              ylab = expression('Emissions from PM'[2.5]*' (tons)'),
              xlab = "year",
              col = "cadetblue1")

# add as label text the value of emission inside the bar (position maxValue - 5% )
text(x=bp, y=BaltimoreYearEmissions$Emissions - 0.05*BaltimoreYearEmissions$Emissions,
     labels = as.character(round(BaltimoreYearEmissions$Emissions, 2)))


dev.off()