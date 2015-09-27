run_analysis <- function() {
	# This code assumes that install.packages("dplyr") has been run successfully.
	library(dplyr)

	# Read data sets
	train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
	test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")

	# Merge the data sets
	mergedData <- rbind(train, test, make.row.names = TRUE)

	# Read feature names for data sets, and set column names to feature names
    features <- read.csv(".\\UCI HAR Dataset\\features.txt", header = FALSE, sep = " ")
	names(mergedData) <- features[,2]
	# Clean up column names a little
	colnames(mergedData) <- sapply(colnames(mergedData), function(elt) { gsub("[()]", "", elt) })

	# Select only cols whose names contain "-std" or "-mean"
	fullFiltered <- mergedData[, grep("-mean|-std", names(mergedData), ignore.case = TRUE)]

	# Read subject numbers for data sets, and merge
	trainSubject <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE, sep = " ")
	testSubject <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, sep = " ")
	fullSubject <- rbind(trainSubject, testSubject, make.row.names = TRUE)

	# Read activity numbers for data sets, and merge
	trainActivity <- read.csv(".\\UCI HAR Dataset\\train\\y_train.txt", header = FALSE, sep = " ")
	testActivity <- read.csv(".\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, sep = " ")
	fullActivity <- rbind(trainActivity, testActivity, make.row.names = TRUE)

	# Read activity labels for data sets
    activityLabels <- read.csv(".\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = " ")

	# Calculate the activity names from the activity numbers for the training data set
	activityNames <- get_activity_names_from_numbers(fullActivity, activityLabels)

	# Add columns for subject number and activity name
	fullData <- mutate(fullFiltered, SubjectNumber = fullSubject[,1], ActivityName = activityNames)

	# Create summary of means of each activity and each subject
	dataSummary <- group_by(fullData, SubjectNumber, ActivityName) %>% summarise_each(c("mean"))

#   Write out result
#	write.table(dataSummary, file = "uciSummary.txt")

	dataSummary
}

get_activity_names_from_numbers <- function(activityData, activityLabels) {
	activityNames <- c()
	for(i in 1:nrow(activityData)) {
		for(j in 1:nrow(activityLabels)) {
			if(activityLabels[j,1] == activityData[i,])
				activityNames <- c(activityNames, toString(activityLabels[j,2]))
		}
	}
	return(activityNames)
}
