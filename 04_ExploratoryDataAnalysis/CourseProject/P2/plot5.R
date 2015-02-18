# *****************************************************************************
# File plot5.R - Course Project 2
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************

# Question

# How have emissions from motor vehicle sources changed from 1999-2008 in 
# Baltimore City?



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


#We suppose that motor vehicle sources are all the sources related with the
#type ON-ROAD

BaltimoreData <- subset(NEI, fips == "24510" & NEI$type=="ON-ROAD")


vehicleBaltimoreYearEmissions <- aggregate(formula = Emissions ~ year, 
                                           data = BaltimoreData,
                                           FUN = sum,
                                           na.action = na.omit)

if(!file.exists("figures")) dir.create("figures")

png(filename = "./figures/plot5.png", bg = "white")


g <- ggplot(data=vehicleBaltimoreYearEmissions, 
            aes(x = vehicleBaltimoreYearEmissions$year, 
                y = vehicleBaltimoreYearEmissions$Emissions))
g <- g + labs(x = 'Year', y = 'Emissions (tons)')
g <- g + ggtitle('Total emissions from motor vehicle in Baltimore')
g <- g + geom_bar(stat="identity", fill="cadetblue1", color="black")
g <- g + geom_text(aes(label = round(Emissions, digits = 2), size = 2, vjust = 2, col="red"))
g <- g + theme(legend.position = 'none')
g <- g + scale_x_continuous(breaks = vehicleBaltimoreYearEmissions$year, 
                            labels=as.character(vehicleBaltimoreYearEmissions$year))

print(g)

dev.off()
