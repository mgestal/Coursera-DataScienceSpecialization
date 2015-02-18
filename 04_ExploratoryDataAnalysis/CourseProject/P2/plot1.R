# *****************************************************************************
# File plot1.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************


# Question

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.



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


yearEmissions <- aggregate(formula = Emissions ~ year, 
                           data = NEI,
                           FUN = sum,
                           na.action = na.omit)


if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot1.png", bg = "white")

bp <- barplot(yearEmissions$Emissions, names.arg = yearEmissions$year,
        main = expression('Total emissions from PM'[2.5]*' in United States from 1999 to 2008'),
        ylab = expression('Emissions from PM'[2.5]*' (tons)'),
        xlab = "year",
        col = "cadetblue1")

# add as label text the value of emission inside the bar (position maxValue - 5%)
text(x=bp, y = yearEmissions$Emissions - 0.05*yearEmissions$Emissions,
     labels = as.character(round(yearEmissions$Emissions, 2)))

dev.off()
