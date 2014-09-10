setwd("~/GitHub/datasciencecoursera/Getting and Cleaning") # delete this before submission



#Step 1  Merges the training and the test sets to create one data set.
#load data and combine the 3 files on similar dim() from manual check.

features <- read.table("./data/UCI HAR Dataset/features.txt") #load the features text to give better names to columns
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names=features[,2])    # import file and name columns from the features.txt
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names=features[,2])  # import file and name columns from the features.txt
combx <- rbind(x_test, x_train)                   # combine the files with rbind to maintain the number of columns

rm("x_test", "x_train")   #delete no longer needed data


#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.

features1 <- features[grep("(mean|std)\\(", features[,2]),]   # get the columns which contain main or std
mean_std_only <- combx[,features1[,1]]                        # new table with just the data stipulated in Step 2

rm("features")   #delete no longer needed data

#Step 3 Uses descriptive activity names to name the activities in the data set

activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt") #load the activities text for labelling purposes
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names= c('activity'))    # import file and name columns.... col2 contains key
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names= c('activity'))  # import file and name columns.... col2 contains key
comby <- rbind(y_test, y_train)                   # combine the files with rbind to maintain the number of columns

rm("y_test", "y_train")   #delete no longer needed data

for (i in 1:nrow(activities)) {                         #loop through row by row from 1 to nrow
        key <- as.numeric(activities[i, 1])             #declare key as the number in the 2nd column
        actname <- as.character(activities[i, 2])       # declare actname as the "word"description provided in the file
        comby[comby$activity == key, ] <- actname       # replace the numeric key with the words    
}

s4 <- cbind(comby, mean_std_only)    # combine the observation labels in comby with the earlier mean and std data. Put Labels first. Named s4 to remind me to take it forward into Step 4


#Step 4 Appropriately labels the data set with descriptive variable names.
# I take this to mean label the columns with descriptive names

names(s4) <- gsub("BodyBody","Body", names(s4))    # remove strange double Body ref in last few lines
names(s4) <- gsub("^t", "Time ", names(s4))                             # step through renaming columns
names(s4) <- gsub("BodyAcc", "Body Accelerometer ", names(s4))
names(s4) <- gsub("GravityAcc", "Gravity Accelerometer ", names(s4))
names(s4) <- gsub("BodyAccJerk", "Body Acceleration Jerk ", names(s4))
names(s4) <- gsub("BodyGyro", "Body Gyroscopic ", names(s4))
names(s4) <- gsub("BodyGyroJerk", "Body Gyroscopic Jerk ", names(s4))
names(s4) <- gsub("Mag", "Normalised Magnitude ", names(s4))
names(s4) <- gsub("^f", "Frequency Fast Fourier Transformed ", names(s4))
names(s4) <- gsub(".mean()", "Mean ", names(s4))
names(s4) <- gsub(".std()", "Standard Deviation ", names(s4))
names(s4) <- gsub("...X$", "X axis Measurement", names(s4))
names(s4) <- gsub("...Y$", "Y axis Measurement", names(s4))
names(s4) <- gsub("...Z$", "Z axis Measurement", names(s4))


# 5. From the data in step 4 Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))    # load the subject data files and label the columns to match
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c('subject')) # load the subject data files and label the columns to match
subject <- rbind(subject_test, subject_train)                                                           # combine
averages <- aggregate(s4, by = list(activity = comby[,1], subject = subject[,1]), mean)
averages <- averages[,-3]        # remove column of na's in "new" activity column resulting from previous line
write.table(averages, file='tidy_data5.txt', row.names=FALSE)
