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

## Part 4 - Appropriately labels the data set with descriptive variable names
###Step 1: Here goes the list of all the names for the extracted data
names(extracted.data)

 [1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                   
 [4] "tBodyAcc-std()-X"                     "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
 [7] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
[10] "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
[13] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"               
[16] "tBodyAccJerk-std()-X"                 "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
[19] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[22] "tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[25] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"              
[28] "tBodyGyroJerk-std()-X"                "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[31] "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                    "tGravityAccMag-mean()"               
[34] "tGravityAccMag-std()"                 "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[37] "tBodyGyroMag-mean()"                  "tBodyGyroMag-std()"                   "tBodyGyroJerkMag-mean()"             
[40] "tBodyGyroJerkMag-std()"               "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[43] "fBodyAcc-mean()-Z"                    "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                    
[46] "fBodyAcc-std()-Z"                     "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"               
[49] "fBodyAcc-meanFreq()-Z"                "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[52] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[55] "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"           
[58] "fBodyAccJerk-meanFreq()-Z"            "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[61] "fBodyGyro-mean()-Z"                   "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                   
[64] "fBodyGyro-std()-Z"                    "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"              
[67] "fBodyGyro-meanFreq()-Z"               "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                   
[70] "fBodyAccMag-meanFreq()"               "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"           
[73] "fBodyBodyAccJerkMag-meanFreq()"       "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"              
[76] "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"          
[79] "fBodyBodyGyroJerkMag-meanFreq()"      "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[82] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                
[85] "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                 "Activity"                            
[88] "Subject"  

###Step 2: Identifying the columns that need name change
		1.	"t" can be replaced by "time"
		2.	"f" can be replaced by "frequency"
		3.	"Acc" is replaced by "Accelerometer"
		4.	"BodyBody" is replaced by "Body"
		5.	"Gyro" is replaced by "Gyroscope"
		6.	"Mag" is replaced by "Magnitude"

### Step 3: Changing the column names		

names(extracted.data) <- gsub("^t", "time", names(extracted.data))
names(extracted.data) <- gsub("^f", "frequency", names(extracted.data))
names(extracted.data) <- gsub("Acc", "Accelerometer", names(extracted.data))
names(extracted.data) <- gsub("Gyro", "Gyroscope", names(extracted.data))
names(extracted.data) <- gsub("Mag", "Magnitude", names(extracted.data))
names(extracted.data) <- gsub("BodyBody", "Body", names(extracted.data))

## Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Step 1: Setting subject as factor variable and converting "extracted.data" into data.table

library(data.table)
extracted.data$Subject <- as.factor(extracted.data$Subject)
extracted.data <- data.table(extracted.data)

### Step 2: Getting the average (mean) data for each activity and subject combination
tidy.data <- aggregate(. ~Subject + Activity, extracted.data, mean)

### Step 3: Ordering the data according to the Subject and Activity
tidy.data <- tidy.data[order(tidy.data$Subject,tidy.data$Activity),]

### Step 4: Writing the file into disk for future upload
write.table(tidy.data, file = "Tidy.txt", row.names = FALSE)




















