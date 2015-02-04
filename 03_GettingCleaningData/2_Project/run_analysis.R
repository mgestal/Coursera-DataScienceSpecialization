# *****************************************************************************
# File run_analysis.R
#
# Course Project for Getting and Cleaning Data (Coursera)
# January 2015, (c) mgestal
# *****************************************************************************

# Download data

f <- file.path(getwd(), "UCI-HAR-DATABASE.zip")

# Unzip command will extract data into "UCI HAR Dataset" directory, so
# we stablish it as rootDir
rootDir <- file.path(getwd(), "UCI HAR Dataset")


if (!file.exists(f)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, f)
  downloadedTime <- Sys.time()
  unzip(f)
}

# Load training data
subject_Train <- read.table(file.path(rootDir, "train/subject_train.txt"))
X_Train <- read.table(file.path(rootDir, "train/X_train.txt"))
Y_Train <- read.table(file.path(rootDir, "train/Y_train.txt"))

# Load test data
subject_Test<- read.table(file.path(rootDir, "test/subject_test.txt"))
X_Test <- read.table(file.path(rootDir, "test/X_test.txt"))
Y_Test <- read.table(file.path(rootDir, "test/Y_test.txt"))


# Load labels and features
features <- read.table(file.path(rootDir, "features.txt"))
activityLabels <- read.table(file.path(rootDir, "activity_labels.txt"))


# *****************************************************************************
# Task 1 : Merge the training and test sets to create one data set
# *****************************************************************************


# First, we create temporary datasets to add the subject and the activity info 
# to the train and test data
trainDataSet <- cbind(subject_Train, Y_Train, X_Train)
testDataSet <- cbind(subject_Test, Y_Test, X_Test)

# Now, the original data can be removed
rm(subject_Train, X_Train, Y_Train)
rm(subject_Test, X_Test, Y_Test)

# FullDataSet is the concatenation of train and test observations
fullData <- rbind(trainDataSet, testDataSet)

# Once the merged dataset is created, the temporary train and test datasets
# can be erased to decrease the memory usage
rm(trainDataSet, testDataSet)

names(features) <- c("featureId", "featureName")
names(fullData) <- c("subject", "activityId", features$featureName)


# *****************************************************************************
# Task 2: Extracts only the measurements on the mean and standard deviation
#         for each measurement
# *****************************************************************************

# rows 1&2 in fullData are subject and activityId, and we must preserve it

filterData <- fullData[, c(1:2, grep("meanFreq|mean()|std()", features$featureName) + 2)]


# *****************************************************************************
# Task 3: Uses descriptive activity names to name the activities in the dataset
# *****************************************************************************

activityNames <- as.character(activityLabels[filterData$activityId, 2])
names(activityNames) <- c("activityName")


# we insert a new column with the activity data names replacing the activityId
# The final format of filterData is (subject, activityName, dataFeatures)
numFeatures <- length(filterData)
filterData <- cbind(filterData$subject, activityNames, filterData[, 3:numFeatures])


# *****************************************************************************
# Task 4: Label the data set with the descriptive variable names
# *****************************************************************************


names(filterData) <- c("subject", "activityName", 
                      as.character(features[grep("meanFreq|mean()|std()", features$featureName), 2]))

write.table(filterData, "mean_std_dataset.txt")



# *****************************************************************************
# Task 5: Creates a second dataset, independent tidy data set with the average 
# of each variable for each activity and each subject
# *****************************************************************************

# We generate the tidy dataset, ignoring the first and second columns from
# filterData, because they correspond with the subject and the activity name
# and we do not want to make the mean for them
#
# This tidy dataset have the following format:
#
#  Column 1 : activity   (1st grouping element)
#  Column 2 : subject    (2nd grouping element)
#
#  Column 3 and above: features (related with mean and std). 
#                      Element i in Column n corresponds with the average for
#                      the feature n for the activity and the user in row i

tidyData = aggregate(x = filterData[, 3:length(filterData)], 
                    by = list(activity = filterData$activity, subject=filterData$subject), 
                    FUN = mean)

write.table(tidyData, "tidy.txt", col.names = TRUE, row.name = FALSE)
