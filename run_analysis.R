## Requires dplyr and tidyr packages are installed
library("dplyr")
library("tidyr")

## Column Bind Test Data
test_data <- 
  cbind(
    read.table( file="./UCI HAR Dataset/test/subject_test.txt",blank.lines.skip=FALSE,header=FALSE),
    read.table( file="./UCI HAR Dataset/test/y_test.txt",blank.lines.skip=FALSE,header=FALSE),
    read.table( file="./UCI HAR Dataset/test/X_test.txt",blank.lines.skip=FALSE,header=FALSE)
  )

## Column Bind Training Data
train_data <- 
  cbind(
    read.table( file="./UCI HAR Dataset/train/subject_train.txt",blank.lines.skip=FALSE,header=FALSE),
    read.table( file="./UCI HAR Dataset/train/y_train.txt",blank.lines.skip=FALSE,header=FALSE),
    read.table( file="./UCI HAR Dataset/train/X_train.txt",blank.lines.skip=FALSE,header=FALSE)
  )

## Row Bind Test and Training Data Sets
all_data <- rbind(test_data,train_data)

## Read in features data
features.txt <-read.table( file="./UCI HAR Dataset/features.txt",blank.lines.skip=FALSE,header=FALSE)

## Create column_names vector with Subject, Activity as first two names, then all of the feature names
column_names <- c("Subject","Activity", as.vector(features.txt[[2]]))

## Set column names for the all_data data set
colnames(all_data) <- c(column_names)

## Select only the columns named "Activity", "Subject", or containing "mean" or "std" in name
all_data<-all_data[,grep('.*(Activity)|(Subject)|(mean)|(std).*',colnames(all_data))]

## Remove columns containing "meanFreq" in name
all_data<-all_data[,-grep('.*(meanFreq).*',colnames(all_data))]

## Replace activity IDs with meaningful activity labels
all_data[all_data$Activity==1,2] <- "WALKING"
all_data[all_data$Activity==2,2] <- "WALKING_UPSTAIRS"
all_data[all_data$Activity==3,2] <- "WALKING_DOWNSTAIRS"
all_data[all_data$Activity==4,2] <- "SITTING"
all_data[all_data$Activity==5,2] <- "STANDING"
all_data[all_data$Activity==6,2] <- "LAYING"

## Create data set with the average of each variable for each activity and each subject
tidy_data <- all_data %>%
  group_by(Subject,Activity) %>%
  summarise_each(funs(mean(.)))

## Transform data from wide to long format
tidy_data <- tidy_data %>%
  gather(Feature,Average, -Subject, -Activity, na.rm = TRUE)

## Order Data
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity,tidy_data$Feature),]

## Write output to file
write.table(tidy_data,"tidy_data.txt")