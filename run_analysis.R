## Clean up the Human Activity Recognition Using Smartphones Dataset
## Add the subject numbers and the activities for each row in the datasets
## Merge of the test and train dataset
## Provide descriptive column names in the merged datasets for all signals and the subjects and activities
run_analysis <- function()
{
  
  # define variables for all files relative to the Working Directory
  testDataSetFile <- "./UCI HAR Dataset/test/X_test.txt"
  testSubjectsDataSetFile <- "./UCI HAR Dataset/test/subject_test.txt"
  testActivitiesDataSetFile <- "./UCI HAR Dataset/test/y_test.txt"
  trainDataSetFile <- "./UCI HAR Dataset/train/X_train.txt"
  trainSubjectsDataSetFile <- "./UCI HAR Dataset/train/subject_train.txt"
  trainActivitiesDataSetFile <- "./UCI HAR Dataset/train/y_train.txt"
  activityLabelsDataSetFile <- "./UCI HAR Dataset/activity_labels.txt"
  featuresDataSetFile <-  "./UCI HAR Dataset/features.txt"
  
  # read all files required
  trainSubjectsDataSet <- read.table(trainSubjectsDataSetFile, quote="\"", comment.char="")
  trainDataSet <- read.table(trainDataSetFile, quote="\"", comment.char="")
  trainActivitiesDataSet <- read.table(trainActivitiesDataSetFile, quote="\"", comment.char="")
  testSubjectsDataSet <- read.table(testSubjectsDataSetFile, quote="\"", comment.char="")
  testDataSet <- read.table(testDataSetFile, quote="\"", comment.char="")
  testActivitiesDataSet <- read.table(testActivitiesDataSetFile, quote="\"", comment.char="")
  activityLabelsDataSet <- read.table(activityLabelsDataSetFile, quote="\"", comment.char="")
  featuresDataSet <- read.table(featuresDataSetFile, quote="\"", comment.char="")
  
  # add to the train and test datasets both the subject numbers and the activity numbers 
  # as additional columns
  trainDataSet$Subject_Number <- trainSubjectsDataSet[, "V1"]
  trainDataSet$Activities <- trainActivitiesDataSet[, "V1"]
  testDataSet$Subject_Number <- testSubjectsDataSet[, "V1"]
  testDataSet$Activities <- testActivitiesDataSet[, "V1"]
  
  # replace the activity numbers in the column Activity in both datasets with the corresponding activity labels 
  for (activity in 1:dim(activityLabelsDataSet[1]))
  {
    trainDataSet$Activities[trainDataSet$Activities == activity] <- as.character(activityLabelsDataSet[activity, "V2"])
    testDataSet$Activities[testDataSet$Activities == activity] <- as.character(activityLabelsDataSet[activity, "V2"])  
  }
  # merge the train and test datasets with all columns, since the varibales in both datasets are identical
  allDataSet <- merge(trainDataSet, testDataSet, all = TRUE)
  # replace the variable names with the 561 names from the features data set
  # preserve the names for the activities and the subject numbers
  colnames(allDataSet) <- c(as.character(featuresDataSet[,2]), "Subject_Number", "Activity")
  # remove duplicate columns from the dataset for cleaning but also to avoid errors from the code
  allDataSet <- allDataSet[ ,!duplicated(colnames(allDataSet))]
  # -- allDataSetTable <- tbl_df(allDataSet) --
  # isolate only the columns which have mean or std in the column name
  # matches argument by default has ignore.case = TRUE
  meanStdDataSet <- select(allDataSet, matches("mean"), matches("std"))
  # Calculates and returns the mean for each column based on a grouping by subject (number) and activity
  meanGroupAllColumns <- allDataSet %>% group_by(Subject_Number, Activity) %>% summarise_each(funs(mean(., na.rm=TRUE)))
  return(meanGroupAllColumns)
}