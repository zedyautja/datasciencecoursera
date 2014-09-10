#Step 1  Merges the training and the test sets to create one data set.

##Load data and combine the 3 files on found to be similar dim() from manual check.

1 load the features text to give better names to columns
2 import X_test file and name columns from the features.txt
3 import X_train file and name columns from the features.txt
4 combine the x_train and X_test with rbind to maintain the number of columns

5 delete no longer needed x_test and x_train data - not strictly necessary but trying to maintain  a   tidy environment for when I work with larger datasets


#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.

1 Get the columns which contain main or std using "grep" >> grep(value = FALSE) returns a vector of the indices of the elements of x that yielded a match (or not, for invert = TRUE. This will be an integer vector unless the input is a long vector, when it will be a double vector.

2 Generate a new table with just the data stipulated in Step 2 as ascertained by previous grep    coding

3 Delete no longer needed features data. Again just best practice for a clean environment.

#Step 3 Uses descriptive activity names to name the activities in the data set

##Load the activities text for as this file contains the labelling data

import the y_test file and name the columns.... column 2 contains the data we need.
import the y_train file and name the columns.... column 2 contains the data we need.

combine the files y_test and y_train files with rbind to maintain the number of columns

delete no longer needed separate y_test and y_train data

##Replace the numeric column data with the text descriptions
 1 loop through row by row from 1 to nrow
 2 declare key as the number in the 2nd column
 3 declare actname as the "word"description provided in the file
 4 replace the numeric key with the words    
 5 combine the observation labels in comby with the earlier mean and std data. Put Labels first.  Named s4 to remind me to take it forward into Step 4


#Step 4 Appropriately labels the data set with descriptive variable names.
##( I take this to mean label the columns with descriptive names)


Rather than create specific titles by hand and then apply to column ranges or individual columns I wanted to write code that would chack for text and replace it in stages without losing coherence. This was not necesarily important for this dataset as it only has <70 columns, but I wanted to practice for larger data sets. In theory my solution could be used for any number of columns.

There was a strange double Body ref in the last few column names. I chose to change the "BodyBody" to "Body" as I could not see any reason in the data for the double entry.

##I used gsub() to find and replace text strings in the column names.

"gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,   
     fixed = FALSE, useBytes = FALSE)"              As seen in the help documentation
     
"names(s4) <- gsub("^t", "Time ", names(s4))"       As implemented in my code.

My code utilises mutliple iterations of the gsub() code shown above to "build" descriptive names for the columns.


# 5. From the data in step 4 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.



load the subject_test.txt data file and label the columns so that it makes sense to me
load the subject_train.txt data files and label the columns so that it makes sense to me 
combine subject_test and subject_train data into one file

Use aggregate() to subset and compute the mean of those subsets
This did leave me with a second column labelled activity with NA's in it. Unfortunatley I have been unable to work out what I am doing wrong in this regard. Instead there is an additional line of code removing this column 

This data is then written to a text file called tidy_data5.txt

