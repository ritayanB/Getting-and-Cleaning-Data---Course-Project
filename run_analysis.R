feature.names <- read.table("UCI HAR Dataset/features.txt")
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity.train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features.train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity.test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features.test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

## Part 1 - Merge the training and the test sets to create a single dataset

subject <- rbind(subject.train, subject.test)
activity <- rbind(activity.train, activity.test)
features <- rbind(features.train, features.test)

colnames(features) <- t(feature.names[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
complete.data <- cbind(features,activity,subject)

## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

columns.mean.std <- grep(".*Mean.*|.*Std.*", names(complete.data), ignore.case = TRUE)

required.columns <- c(columns.mean.std, 562, 563)

extracted.data <- complete.data[,required.columns]


## Part 3 - Uses descriptive activity names to name the activities in the data set
extracted.data$Activity <- as.character(extracted.data$Activity)

for (i in 1:6){
	extracted.data$Activity[extracted.data$Activity == i] <- as.character(activity.labels[i,2])
}

extracted.data$Activity <- as.factor(extracted.data$Activity)

## Part 4 - Appropriately labels the data set with descriptive variable names

names(extracted.data) <- gsub("^t", "time", names(extracted.data))
names(extracted.data) <- gsub("^f", "frequency", names(extracted.data))
names(extracted.data) <- gsub("Acc", "Accelerometer", names(extracted.data))
names(extracted.data) <- gsub("Gyro", "Gyroscope", names(extracted.data))
names(extracted.data) <- gsub("Mag", "Magnitude", names(extracted.data))
names(extracted.data) <- gsub("BodyBody", "Body", names(extracted.data))

## Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(data.table)
extracted.data$Subject <- as.factor(extracted.data$Subject)
extracted.data <- data.table(extracted.data)

tidy.data <- aggregate(. ~Subject + Activity, extracted.data, mean)

tidy.data <- tidy.data[order(tidy.data$Subject,tidy.data$Activity),]

write.table(tidy.data, file = "Tidy.txt", row.names = FALSE)




















