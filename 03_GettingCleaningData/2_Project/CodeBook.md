
#Getting and Cleaning Data: Course Project
##Code Book

---

Code Book for the Project of the Course Getting and Cleaning Data from Coursera. This codebook describes what transformations are applied to the original data within the script run_analysis.R

Please, refer to run_analysis.R if you want to know HOW that transformations are performed (the file is also 
heavily commented)


Course WebSite: https://class.coursera.org/getdata-010/

---


## Data

The data used in this course project represent data collected from the accelerometers
from de Samsung Galaxy S smartphone.

The data for the project is available at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

A full description about the data can be found at the UCI Machine Learning Respository:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The script run_analysis.R download the zip file and extract it under the "UCI HAR Dataset" from where the data
will be read.

### Data Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See features_info.txt, included in the downloaded zip file, for more details. 

For each record it is provided a normalized measure in the range [-1..1] for the next features:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Data related with Inertial Signals is ignored in this project.


## Data transformations


The script run_analysis.R performs the 5 steps described in the course project's definition.

- Merge training and test data in one data set

First two auxiliar datasets are created. The first one combines all the data
available for train: the subject (subject_train.txt), the activity (Y_train.txt)
and the measures for the different time and frequency domain variables (X_train.txt).
Those variables are combined in that order by means the cbind() function.

The second one uses the same data but, in this case, from the test folder and are
also combined with cbind().

After that those the dataset with the training data and the test data are combined
in a single dataset by means of the function rbind()

As result, this dataset contains 10299 rows/observations with 563 variables each one
of them. Once the fullDataset is created the previouly loaded data and the auxiliar
data frames created are removed to decrease the memory usage.

### Feature Selection (mean and std features)

Once the dataset with train and test data is created, we perform a "manual" feature selection phase.

There is no an explicit criteria to select the features related with the mean and standard deviation, so 
the reasoning behind my selection was include all the features with the sequences mean() or std() at
the end of the name (i.e. tBodyAcc-mean()-X or tGravityAcc-std()-Z) or the word MeanFreq in an earlier part
of the name as well (i.e. fBodyAcc-meanFreq()-Z) to capture features related with MeanFrequency measures.

Last three features angle(_,gravityMean) [where _ is one of the axis X, Y or Z] were not considered, because they
use data from Mean measures but they are really angles.

This give us a total of 79 features (from the original 561). Remember that the full dataset contains also a columns for subject and activityId, so the filtered dataset will contain the same 10299 rows/observations but only 81 columns.


### Descriptive activity names

At this point, the activityId row in the filter data set is replaced with the related descriptive names, extracted
from the file activity_labels.txt.

A row is deleted (activityId) and another is added (activityName), so the dimensions remain unchanged.

### Using descriptive variable names

The labels for each feature are available at the file features.txt, and are read at the beginning of the script and applied to the filter dataset.

This filter data set can be checked at the file `mean_std_dataset.txt` created in your working directory.

### Tidy data set


Finally, from the filter data set, a second data set is crated. This new dataset is an independent tidy data set with the average of each variable for each activity and each subject.


According to Hadley Wickham [^1], tidy data is a standard way of mapping the meaning of a dataset to its structure. A dataset is messy or tidy depending on how rows, columns and tables are matched up with observations,
variables and types. In tidy data:
1. Each variable/feature forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

In this case, the new dataset contais tidy data because each row contains one subject, one of the activities and after those values the average for each one of the features (considering the combination of subject, activity and variable measure). This new dataset has 180 rows (30 subjects * 6 activities) and 81 columns (subject + activity name + 79 features selected). 

The tidy data set is saved as `tidy.txt` and uploaded to this repository.

[^1]: Wickham, H. Tidy Data. Available at: [http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf)