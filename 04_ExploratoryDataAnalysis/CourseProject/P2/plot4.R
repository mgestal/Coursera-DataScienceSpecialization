# *****************************************************************************
# File plot4.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************

# Question

# Across the United States, how have emissions from coal combustion-related
# sources changes from 1999-2008?


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


SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]
NEI.coal <- subset(NEI, NEI$SCC %in%  SCC.coal$SCC)

coalYearEmissions <- aggregate(formula = Emissions ~ year, 
                               data = NEI.coal,
                               FUN = sum,
                               na.action = na.omit)

if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot4.png", bg = "white", width=640)

library("ggplot2")

g <- ggplot(data=coalYearEmissions, aes(x = coalYearEmissions$year, y=coalYearEmissions$Emissions/1000))
g <- g + labs(x = 'Year', y = 'Emissions (kilotons)')
g <- g + ggtitle('Total emissions from coal combustion-related in United States from 1999 to 2008')
g <- g + geom_bar(stat="identity", fill="cadetblue1", color="black")
g <- g + geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, vjust = 2, col="red"))
g <- g + theme(legend.position = 'none')
g <- g + scale_x_continuous(breaks = coalYearEmissions$year, labels=as.character(coalYearEmissions$year))

print(g)

dev.off()
