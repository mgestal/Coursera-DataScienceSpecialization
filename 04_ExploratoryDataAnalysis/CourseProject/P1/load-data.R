# *****************************************************************************
# File load-data.R : download and load data for course project 1
#
# Course Project for Exploratory Data Analysis (Coursera)
# February 2015, (c) mgestal
# *****************************************************************************



## Create directory for downloaded data. If this dir does not exist, data will
## be downloaded, else we will assume the data is already available.

if(!file.exists("data")) {
  dir.create("data")
  f <- file.path(getwd(), "data/household_power_consumption.zip")
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, f) 
  downloadedTime <- Sys.time()
  unzip(f, exdir="./data")
  
}


# Loading the data (using fast load with colClasses inspection)

# initialData <- read.table("./data/household_power_consumption.txt", 
#                           header = TRUE, sep =";", na.strings = "?", nrows = 5)

# dataClasses <- sapply(initialData, class)

# data <- read.table("./data/household_power_consumption.txt", 
#                   header = TRUE, sep =";", na.strings = "?", colClasses = dataClasses)

# data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]


# Loading and Subseting data


library(sqldf)

dataFile <- file.path(getwd(), "data/household_power_consumption.txt")

data <- read.csv.sql(dataFile, header = TRUE, sep=";",
                    sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )


# Converting Date and Time variables

data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")