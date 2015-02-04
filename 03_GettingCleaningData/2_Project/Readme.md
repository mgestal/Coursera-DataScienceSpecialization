
#Getting and Cleaning Data: Course Project


The folder Project under the repository [https://github.com/mgestal/Coursera-Getting-and-Cleaning-Datarepository](https://github.com/mgestal/Coursera-Getting-and-Cleaning-Data) contains the course project for the "Getting and Cleaning data"



### Data Files

The data for the project is available at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

A full description about the data can be found at the UCI Machine Learning Respository:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Script run_analysis.R 

This script download and unzip the files under the folder `UCI HAR Dataset` that will be created in the working directory.

It performs all the task included in the course project definition:
 
 1. Merge the training and test sets to create one data set
 1. Extracts only the measurements on the mean and standard deviation for each measurement
 1. Uses descriptive activity names to name the activities in the dataset
 1. Label the data set with the descriptive variable names
 1. Creates a second dataset, independent tidy data set with the average of each variable for each activity and each subject

The dataset created in this last step is called `tidy.txt`, and is uploaded to the repository.

The script run_analysis.R is heavily comment to explain how the original is transformed.

To run the script, it should be located at our working directory and then it should be executed by means of

```
source("run_analysis.R")
```

... or simply copy&paste its contents in the RStudio Console.


### CodeBook.md

Markdown file that describes what transformations are applied to the original data within the script run_analysis.R

### Tidy data set

The independent set of data created by taking the results of the step 5 in the script. It contains 180 rows (30 subjects * 6 activities) and 81 columns (subject + activity name + 79 features selected). 

The tidy data set can be imported into R using the next command

```
tidy <- read.table("tidy.txt", headers = TRUE)
```