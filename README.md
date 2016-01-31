# Getting and Cleaning Data - Course Project

### Reading meta-data

feature.names <- read.table("UCI HAR Dataset/features.txt")
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

### Reading training data

subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity.train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features.train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

### Reading testing data

subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity.test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features.test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

## Part 1 - Merge the training and the test sets to create a single dataset

### Step 1: Binding training and testing data, which we read from the files are bound into single dataset
subject <- rbind(subject.train, subject.test)
activity <- rbind(activity.train, activity.test)
features <- rbind(features.train, features.test)

### Step 2: Naming the "features" columns
colnames(features) <- t(feature.names[2])

### Step 3: Merging features, activity, and subject
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
complete.data <- cbind(features,activity,subject)

## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

### Step 1: Choose the columns which have "mean" or "std" in their names
columns.mean.std <- grep(".*Mean.*|.*Std.*", names(complete.data), ignore.case = TRUE)

### Step 2: Adding "Activity" and "Subject" columns for the completeness of data
required.columns <- c(columns.mean.std, 562, 563)

### Step 3: Extracting data for selected columns from the complete dataset
extracted.data <- complete.data[,required.columns]


## Part 3 - Uses descriptive activity names to name the activities in the data set
### Step 1: Change the data type of the "Activity" column
extracted.data$Activity <- as.character(extracted.data$Activity)

### Step 2: Assigning the corresponding activity names from activity labels
for (i in 1:6){
	extracted.data$Activity[extracted.data$Activity == i] <- as.character(activity.labels[i,2])
}

### Step 3: Changing the data type to factor to facilitate the future/probable uses
extracted.data$Activity <- as.factor(extracted.data$Activity)


























