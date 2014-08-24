# run_analysis.R for Coursera Getting and Cleaning Data


This script was generated for the Coursera Getting and Cleaning Data class.
The data file was obtained from the URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

>To run the script, first unzip the data in your working directory

### The assignment is, (source: Getting and Cleaning Data (get-006) website)
1. "Merges the training and the test sets to create one data set. 1
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 2 
3.  Uses descriptive activity names to name the activities in the data set 3
4.  Appropriately labels the data set with descriptive variable names.  4
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. " 5 

## What the script does:

The script takes a "test" and "training" data set and combines the two, extracts some information, provides
better labels for activities within then creates a tidy data set.

It follows this pattern:
* Step 1: Read in the data tables and data labels from their respective files
* Step 2: Combine the columns to form a single table for testing and training respectively.
* Step 3: Since the data sets contain the same info, append the rows of one table to the end of the other
* Step 4: Figure out which columns contain the desired information (e.g. mean and standard deviation)
* Step 5: Create a subset of the data with only the columns we want
* Step 6: Aggregate the data into a tidy data set

