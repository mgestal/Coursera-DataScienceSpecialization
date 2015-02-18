# *****************************************************************************
# File plot6.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************

# Question

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


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

# Subseting data. Batimore City, Mariland && Los Angeles County==> fips

CitiesData <- subset(NEI, (fips == "24510" | fips == "06037") & NEI$type=="ON-ROAD")

# Changes labels for factor fips
CitiesData$fips <- factor(CitiesData$fips)


# levels(CitiesData$fips)
# [1] "06037" "24510"
levels(CitiesData$fips) <- c("Los Angeles", "Baltimore")
  
if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot6.png", bg = "white")

library("ggplot2")

g <- ggplot(data=CitiesData, 
            aes(x = year, y = Emissions, color=fips))
# g <- g + facet_grid(. ~ fips)   ## Descomment for facets
g <- g + ggtitle('Emissions from motor vehicle sources: Baltimore vs Los Angeles')
g <- g + labs(x = 'Year', y = 'Emissions (tons)')
g <- g + geom_line(stat="summary", fun.y="sum", size=1)
g <- g + scale_x_continuous(breaks = CitiesData$year, labels=as.character(CitiesData$year))
g <- g + scale_color_discrete(name="City")

print(g)

dev.off()