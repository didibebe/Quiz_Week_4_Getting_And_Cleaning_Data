# Quiz_Week_4_Getting_and_Cleaning_Data

run_analysis.R does the following:

1. Reads in all the relavant data from the Samsung datasets
2. Adds the subject number and the activitiy numbers for each row to the train and test datasets (from subject_train.txt, subject_test.txt and activity_labels.txt. Both are added as columns to both the train and test dataset. 
3. Replaces the activity numbers with the respective activity names for each row in the train and test datasets
4. Merges the train and test dataset.
5. Sets the column names for each of the 561 measured variables in the train and test datasets from features.txt
6. Removes duplicate columns
7. Collects only the columns with mean and standard deviation data (through greping the column headers)
8. returns the mean for each measurement column grouped by subject_number and activity
