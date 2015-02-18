# *****************************************************************************
# File plot3.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************

# Question

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 


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

BaltimoreYearEmissions <- aggregate(formula = Emissions ~ year + type, 
                                    data = BaltimoreData,
                                    FUN = sum,
                                    na.action = na.omit)

BaltimoreYearEmissions$type <- factor(BaltimoreYearEmissions$type)



if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot3.png", bg = "white", width=780)

library("ggplot2")

g <- qplot(x = year, Emissions, data=BaltimoreYearEmissions, facets = . ~ type, 
           main = 'Emissions per Type in Baltimore City, Maryland',
           ylab = expression('Emissions from PM'[2.5]*' (tons)'),
           xlab = 'Year')
g <- g + geom_bar(stat="identity", fill="cadetblue1", color="black")
g <- g + scale_x_continuous(breaks = BaltimoreYearEmissions$year, 
                            labels=as.character(BaltimoreYearEmissions$year))

print(g)

dev.off()