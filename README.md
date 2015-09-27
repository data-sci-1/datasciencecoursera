## Code Book for Course Project for "Getting and Cleaning Data"

The data for this project comes from the "Human Activity Recognition Using Smartphones Dataset".

* The training and test data sets were read (from X_train.txt and X_test.txt), and merged.

* The feature names were read (from features.txt), cleaned up by removing parentheses, and
were used as column names for the data. Only columns names which contained the strings
"-std" or "-mean" were used.

* The subject numbers were read (from subject_train.tx and subject_test.txt) and the activity numbers 
(from y_train.txt an dy_test.txt) and merged.

* The activity names were read (from activity_labels.txt), and used to generate a list of activity
names corresponding to the activity numbers for the data.

* The subject numbers and activity names were added to teh data as additional columns.

* A summary of the data was created containing the mean of each activity and each subject.


