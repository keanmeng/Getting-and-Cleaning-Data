## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## 1. Merges the training and the test sets to create one data set.

##Read in Train data, label and subject
Train_Data <- read.table("./UCI HAR Dataset/train/X_train.txt")
Train_Label <- read.table("./UCI HAR Dataset/train/y_train.txt")
Train_Subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Train <- cbind(Train_Subject, Train_Label, Train_Data)

##Read in Test data,label and subject
Test_Data <- read.table("./UCI HAR Dataset/test/X_test.txt")
Test_Label <- read.table("./UCI HAR Dataset/test/y_test.txt")
Test_Subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Test <- cbind(Test_Subject, Test_Label, Test_Data)

##Merge Train and Test data sets
Data <- rbind(Train_Data, Test_Data)
Label <- rbind(Train_Label, Test_Label)
Subject <- rbind(Train_Subject, Test_Subject)

##Merge Train and Test to create one data set
AllData <- cbind(Subject, Label, Data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Feature <- read.table("./UCI HAR Dataset/features.txt")
Mean_Std <- grep("-mean\\(\\)|-std\\(\\)", Feature[, 2])
Data <- Data[, Mean_Std]
names(Data) <- gsub("\\(\\)", "", Feature[Mean_Std, 2])
names(Data) <- tolower(names(Data)) 


## 3. Uses descriptive activity names to name the activities in the data set
Activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
Activity[, 2] = tolower(gsub("_", "", Activity[, 2]))
Label[, 1] <- Activity[Label[, 1], 2]


## 4. Appropriately labels the data set with descriptive activity names.
names(Label) <- "Activity"
names(Subject) <- "Subject"
Merged_Data_Set <- cbind(Subject, Label, Data)



## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
numSubject <- length(table(Subject))
numActivity <- dim(Activity)[1]
numCol <- dim(Merged_Data_Set)[2]
Tidy_Data <- matrix(NA, nrow=numSubject*numActivity, ncol=numCol)
Tidy_Data <- as.data.frame(Tidy_Data)
colnames(Tidy_Data) <- colnames(Merged_Data_Set)

row = 1
for (s in 1:numSubject) {
    for (a in 1:numActivity) {
        Tidy_Data[row, 1] = sort(unique(Subject)[,1])[s]
        Tidy_Data[row, 2] = Activity[a, 2]
        tmp1 <- s == Merged_Data_Set$Subject
        tmp2 <- Activity[a, 2] == Merged_Data_Set$Activity
        Tidy_Data[row, 3:numCol] <- colMeans(Merged_Data_Set[tmp1&tmp2, 3:numCol])
        row = row+1
    }
}

##Create second independent tidy data set
write.table(Tidy_Data, "./UCI HAR Dataset/Tidy_Data.txt", row.name=FALSE)
