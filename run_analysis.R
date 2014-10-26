## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## 1. Merges the training and the test sets to create one data set.
## Read all required .txt files and label the datasets

##Load library reshape2 for required functions
library(reshape2)

## Read the features names
features <- read.table("./UCI HAR Dataset/features.txt")
feature_names <-  features[,2]


## Read the activity names and assign column name
Activity_Label <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("Activity_ID","Activity_Name"))


##Read in Train data, activity, subject and assign column name
Train_Data <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names=feature_names)
Train_Activity <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("Activity_ID"))
Train_Subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("Subject_ID"))
Train <- cbind(Train_Subject, Train_Activity, Train_Data)


##Read in Test data, activity, subject and assign column name
Test_Data <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names=feature_names)
Test_Activity <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("Activity_ID"))
Test_Subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("Subject_ID"))
Test <- cbind(Test_Subject, Test_Activity, Test_Data)


##Merge Train and Test to create one data set
AllData <- rbind(Train, Test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##Keep the columns with mean() or std() values

Mean_Std <- grep("mean|std",names(AllData),ignore.case=TRUE)
Mean_Std_names <- names(AllData)[Mean_Std]
Mean_Std_data <- AllData[,c("Subject_ID","Activity_ID", Mean_Std_names)]


## 3. Uses descriptive activity names to name the activities in the data set
##Merge the activity names with data set to provide the descriptive names.
Des_name <- merge(Activity_Label, Mean_Std_data, by.x="Activity_ID",by.y="Activity_ID",all=TRUE)


## 4. Appropriately labels the data set with descriptive activity names.
Data_Melt <- melt(Des_name,id=c("Activity_ID","Activity_Name","Subject_ID"))


## 5. Creates a second, independent data frame using dcast with the average of each variable for each activity and each subject.
Mean_Data <- dcast(Data_Melt, Activity_ID + Activity_Name + Subject_ID ~ variable, mean)

## Create a file with the new tidy dataset
write.table(Mean_Data,"./UCI HAR Dataset/Tidy_Data.txt",row.name=FALSE)
