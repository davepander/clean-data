# This R script gets and performs some cleaning on human activity data, built
# from recordings of subjects performing daily activities while carrying
# smartphone. The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#Prep:  
#Ensure working directory is set prior to running
#Download the data


download.data = function() {
  "Checks for data directory and creates one if it doesn't exist"
  if (!file.exists("data")) {
    message("Creating data directory")
    dir.create("data")
  }
  if (!file.exists("data/UCI HAR Dataset")) {
    # download the data
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile="data/UCI_HAR_data.zip"
    message("Downloading")
    download.file(fileURL, destfile=zipfile, method="curl")
    unzip(zipfile, exdir="data")
  }
}
download.data()

#1: Merge the sets

#1a: Read in the data from files
features     = read.table('data/UCI HAR Dataset/features.txt',header=FALSE); 
activityType = read.table('data/UCI HAR Dataset/activity_labels.txt',header=FALSE); 
subjectTrain = read.table('data/UCI HAR Dataset/train/subject_train.txt',header=FALSE);
xTrain       = read.table('data/UCI HAR Dataset/train/x_train.txt',header=FALSE); 
yTrain       = read.table('data/UCI HAR Dataset/train/y_train.txt',header=FALSE);

subjectTest = read.table('data/UCI HAR Dataset/test/subject_test.txt',header=FALSE);
xTest       = read.table('data/UCI HAR Dataset/test/x_test.txt',header=FALSE);
yTest       = read.table('data/UCI HAR Dataset/test/y_test.txt',header=FALSE);

colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";

# 1b: Merge yTrain, subjectTrain, and xTrain
trainingData = cbind(yTrain,subjectTrain,xTrain);

# 1c: Merge xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest);

# 1d: Create final dataset
finalData = rbind(trainingData,testData);

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(finalData); 

# 2 Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE];

# 3 Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names
colNames  = colnames(finalData); 

# 4. Appropriately label the data set with descriptive activity names. 

# Updating the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Use clearer descriptive column naming
colnames(finalData) = colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, finalDataNoType without the activityType column
finalDataNoType  = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoType table with the mean for each activity and each subject
tidyData    = aggregate(finalDataNoType[,names(finalDataNoType) != c('activityId','subjectId')],by=list(activityId=finalDataNoType$activityId,subjectId = finalDataNoType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, 'UCI HAR tidyData.txt',row.names=TRUE,sep='\t');