library(plyr)
library(dplyr)
library(tidyr)
#Import the list of the 561 dataset's features
Features <- read.table("UCI HAR Dataset/features.txt")
#Import the components of the training dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#Label the variables
colnames(X_train) <- Features$V2
colnames(subject_train) <- "Subject"
colnames(y_train) <- "Activity"
#Make the columns of X_train of type "numeric"
X_train <- apply(X_train, 2, as.numeric)
#Generating a training dataset
training <- cbind(subject_train, y_train, X_train) 
#Import the Testing dataset
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#Label the variables
colnames(X_test) <- Features$V2
colnames(subject_test) <- "Subject"
colnames(y_test) <- "Activity"
#Make the columns of X_test of type "numeric"
X_test <- apply(X_test, 2, as.numeric)
#Generating a testing dataset
testing <- cbind(subject_test, y_test, X_test)
#Merge the training and the test sets to create one data set
df <- rbind(training, testing)
#Use descriptive activity names to name the activities in the data set
df$Activity <- gsub("1", "WALKING",df$Activity)
df$Activity <- gsub("2", "WALKING_UPSTAIRS",df$Activity)
df$Activity <- gsub("3", "WALKING_DOWNSTAIRS",df$Activity)
df$Activity <- gsub("4", "SITTING",df$Activity)
df$Activity <- gsub("5", "STANDING",df$Activity)
df$Activity <- gsub("6", "LAYING",df$Activity)
#Identify the measurements on the mean and standard deviation for each measurement
grep("mean\\(\\)", colnames(df), value = TRUE)
grep("std\\(\\)", colnames(df), value = TRUE)

grep("mean\\(\\)|std\\(\\)", colnames(df), value = TRUE)
#Extract only the measurements on the mean and standard deviation for each measurement
df <- df[,c(1:2,grep("mean\\(\\)|std\\(\\)", colnames(df)))]
#Appropriately label the data set with descriptive variable names
colnames(df)
#Tidy data set with the average of each variable for each activity and each subject
By_Activity_Subject <- group_by(df, Activity, Subject) %>% 
  arrange(Activity, Subject) %>% 
  summarise_all("mean")

write.table(By_Activity_Subject, file = "Tidy_dataset.txt", row.name=FALSE) 


