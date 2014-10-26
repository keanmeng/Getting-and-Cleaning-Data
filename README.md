Getting-and-Cleaning-Data Course Project
========================================

##The script "run_analysis.R" does the following
1. Merges the training and the test sets to create one data set.
  - Use read.table to take in Train and Test X, y and subject, merge the data sets using cbind and rbind.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
  - Use grep to extract the mean() or std() values.
  
3. Uses descriptive activity names to name the activities in the data set
  - Merge the activity names with data set to provide the descriptive names.
  
4. Appropriately labels the data set with descriptive activity names.
  - Melt the data set for easy handling and reading.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Uses dcast to reshape the data and calculate the mean.
  - Create "Tidy_Data.txt" in "UCI HAR Dataset" directory

## Running the script "run_analysis.R"
1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. In your working directory, create "UCI HAR Dataset" directory and extract the downloaded data into it.
3. Ensure reshape2 library is installed, in RStudio source "run_analysis.R".
4. "Tidy_Data.txt" will be created in the "UCI HAR Dataset" directory.

