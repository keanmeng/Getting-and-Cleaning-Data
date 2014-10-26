Getting-and-Cleaning-Data Course Project
========================================

##The script "run_analysis.R" does the following
1. Merges the training and the test sets to create one data set.
  - Uses Read.table to take in Train and Test X, y and subject, merge the data sets using rbind and cbind.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
  - Uses grep and gsub to extract the mean and std
  
3. Uses descriptive activity names to name the activities in the data set
  - Use tolower and gsub to clean up the activity names to create meaningful readable names.
  
4. Appropriately labels the data set with descriptive activity names.
  - Add-in "Activity" and "Subject" labels to complete the labelling for the data set.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Uses "for" loop to create the tidy data set.

## Running the script "run_analysis.R"
1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. In your working directory, create "UCI HAR Dataset" directory and extract the downloaded data into it.
3. In RStudio, source "run_analysis.R".
4. "Tidy_Data.txt" will be created in the "UCI HAR Dataset" directory.

