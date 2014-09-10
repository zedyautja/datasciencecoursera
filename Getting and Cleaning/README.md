#The files - README.md, run_analysis.R, tidy_data5.txt, and CodeBook.md are submitted to answer the following project outline.

##Project introduction as outlined within the Getting and Cleaning Data course website

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 You should create one R script called run_analysis.R that does the following. 

  ## Step 1  Merges the training and the test sets to create one data set.
  ## Step 2  Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## Step 3  Uses descriptive activity names to name the activities in the data set
  ## Step 4  Appropriately labels the data set with descriptive variable names. 
  ## Step 5  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
## Data source on drive

All data are contained in ./data/UCI HAR Dataset/
The data provided included the following files:

activity_labels.txt       >  Contains character descriptors of the type of activities tested 6 groups
features.txt              >  Contains variable names. 561 different variables
features_info.txt         >  Descriptive document explaining the naming convention in features.txt - not called by my code
README.txt                >  Original readme outlining data supplied - not called by my code
test/subject_test.txt     >  Participant number in the "test" grouping
test/X_test.txt           >  Observation data for the "test" cohort. 561 variables 2947 obs
test/y_test.txt           >  This document contains numeric activity values which correspond to values in the activity_labels.txt
test/Inertial Signals/*.* > data that are not interrogated by my code
train/Inertial Signals/*.* > data that are not interrogated by my code
train/subject_train.txt     >  Participant number in the "train" grouping
train/X_train.txt           >  Observation data for the "train" cohort. 561 variables 7352 obs
train/y_train.txt           >  This document contains numeric activity values which correspond to values in the activity_labels.txt

## All 5 steps are successfully completed by the code submitted.

Please see the CodeBook.md for stepwise breakdown of the process.