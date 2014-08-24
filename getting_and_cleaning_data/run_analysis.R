# This script was generated for the Coursera Getting and Cleaning Data class.
# The data file was obtained from the URL:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# to run the script, first unzip the data in your working directory

#  The assignment is, (source: Getting and Cleaning Data (get-006) website)
# 1) "Merges the training and the test sets to create one data set.
# 2)  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3)  Uses descriptive activity names to name the activities in the data set
# 4)  Appropriately labels the data set with descriptive variable names. 
# 5)  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. " 

# First read in all tables
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F)
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F)
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)

# Activity/Feature Lablels (for assignment part 3)
actlabels = read.table("UCI HAR Dataset/activity_labels.txt", header=F)
features = read.table('UCI HAR Dataset/features.txt',header=F);

# Assign meaningful column names... keeping things the same on both set for a merge
# test
colnames(actlabels)  = c('act_ID','act_type')
colnames(subtest)  = "sub_ID"
colnames(xtest)        = features[,2] 
colnames(ytest)        = "act_ID"
# training
colnames(subtrain)  = "sub_ID"
colnames(xtrain)        = features[,2] 
colnames(ytrain)        = "act_ID"


# Bind the test data columns together into one table, same for training
testdata = cbind(ytest,subtest,xtest)
traindata = cbind(ytrain,subtrain,xtrain)

# Now we can bind all rows together...
test_train = rbind(testdata,traindata)


# Extracting mean and standard deviation 

# Getting the columns
cnames = colnames(test_train)
cselect = (grepl("act..",cnames) | grepl("sub..",cnames) | grepl("mean..",cnames) | grepl("std..",cnames) );

# Keeping only columns related to mean and std
mean_std = test_train[cselect==T];

# Using descriptive activity names by merging activity names
mean_std = merge(mean_std,actlabels,by='act_ID',all.x=T);

# Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy = aggregate(mean_std, by=list(activity = mean_std$act_ID, subject=mean_std$sub_ID), mean)
write.table(tidy, "tidy.csv", sep=",")
