require("data.table")
require("plyr")

#Read the "test" data (data found in the /test directory)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

#Read the activity code for each record in the X_test dataset
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

#Read the subject id for the X_test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Read the "training" data (data found in the /train directory)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

#Read the activity code for each record in the X_train dataset
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Read the subject id for the X_train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read the activity labels, the codes that represent the activity taking place
#while data was being taken
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#Read the record names (column names)
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#Create a truth table that returns only collumns that deal with mean or std deviation
selected_features <- grepl("std|mean", features)

#Descriptive Variable Names
features <- gsub("Mag", "Magnitude", features)
features <- gsub("^t", "time", features)
features <- gsub("Gyro", "Gyroscope", features)
features <- gsub("Acc", "Accelerometer", features)
features <- gsub("^f", "frequency", features)
features <- gsub("BodyBody", "Body", features)



#Name the columns in the X_test
names(X_test) <- features

#We will now change X_test so that it includes only the standard deviation/mean data
X_test <- X_test[,selected_features]

#In preparation to append the activity_code column, and the activity label, I will add a
#column to y_test filling it with the activity label corresponding to the code
activity_test <- cbind(as.data.table(y_test[,1]), activity_labels[y_test[,1]])


#name the columns in activity_test
names(activity_test) <- c('Activity_Code', 'Activity_Label')

#name the column in 1D subject_test
names(subject_test) <- "Subject_Code"

#Combine subject_test and activity_test
pre_add_test <- cbind(as.data.table(subject_test),activity_test)

#Combine pre_add_test and X_test to form the final test_data
test_data <- cbind(pre_add_test, X_test)

#Repeat this process for the train data set
names(X_train) <- features
X_train <- X_train[,selected_features]
activity_train <- cbind(as.data.table(y_train[,1]), activity_labels[y_train[,1]])
names(activity_train) <- c('Activity_Code', 'Activity_Label')
names(subject_train) <- "Subject_Code"
pre_add_train <- cbind(as.data.table(subject_train),activity_train)
train_data <- cbind(pre_add_train, X_train)

#Combine the test_data and train_data
data <- rbind(test_data, train_data)

#Average of each variable for each activity and each subject

tidy_data <- aggregate(. ~Subject_Code+Activity_Code, data, mean)
tidy_data <- tidy_data[order(tidy_data$Subject_Code, tidy_data$Activity_Code),]

#Write the cleaned up data to a *.txt file
write.table(tidy_data, file="./tidy_data.txt")



