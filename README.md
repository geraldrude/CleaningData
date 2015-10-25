# Getting and Cleaning Data

## Course Project

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data source
2. Run ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```. This will produce the tidy_data.txt described above



### Dependencies

Script depends on two libraries. It requires ```plyr``` and ```data.table```. 