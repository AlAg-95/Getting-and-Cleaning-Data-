# Getting and Cleaning Data Project
The "UCI HAR Dataset" folder should be in the working directory to run the R script.
## Training dataset
First I imported the data needed to create the training dataset using read.table() function:
+ the list of the 561 dataset's features' names
+ the components of the training dataset
  + the subject_train, which returns the subject of the record
  + the y_train, which returs the activity of the regord
  + the X_train, which contains the values of the 561 features reltive to the training dataset
Then I labeled the columns according to the corresponding feature's name using colnames() function.
So I assured the X_train columns to be "numeric" using as.numeric() to every column of the data frame with apply().
At the end I merged the component of the training dataset using cbind().
## Testing dataset
Second I imported the data needed to create the testing dataset using read.table() function:
+ the list of the 561 dataset's features' names was already imported
+ the components of the testing dataset
  + the subject_test, which returns the subject of the record
  + the y_test, which returs the activity of the regord
  + the X_test, which contains the values of the 561 features reltive to the testing dataset
Then I labeled the columns according to the corresponding feature's name using colnames() function.
So I assured the X_test columns to be "numeric" using as.numeric() to every column of the data frame with apply().
At the end I merged the component of the testing dataset using cbind().
## Total dataset
Third I merged tha training and the testing dataset to create one data set using rbind().
Then I replaced the Activity codes with their correspnding labels using gsub() function according to the activit_labels.txt
## Tidy data set
I identified the measurements on the mean and the standard deviation for each measurement using the grep() function with the regular expression "mean\\(\\)|std\\(\\)" on the colnames() of the total dataset in order to extract a tidier version of the dataset.
This data frame was grouped and arranged according to the variables: Activity and Subject, then summarized using the mean() function with summarize_all() to get tidy data set with the average of each variable for each activity and each subject
