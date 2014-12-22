
mergeSets = function(){
  ## Read in the files 
  xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
  subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
  ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
  subtest <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  ## and create a merged data set
  xmerged <- rbind(xtrain,xtest)
  ymerged <- rbind(ytrain,ytest)
  submerged <- rbind(subtrain,subtest)
  
  ## Return the merged data
  list(x=xmerged, y=ymerged, subject=submerged)
}


stdmean = function(df){
  ##Identify the std and mean columns
  
}


createTidy = function() {
  
  
  
}