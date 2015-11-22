---
title: "Readme"
author: "David Anderson"
date: "November 22, 2015"
output: html_document
---
## Getting and Cleaning Data Project


### Overview
This goal of this project is to demonstrate the collection, cleaning and production of a tidy data set that can be used for subsequent
analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Preparation
This script checks to see if the data has been downloaded.  If it has not been, it downloads the data for you.

### Project Instructions

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Additional Information
Additional information about the variables, data and transformations can be found in CodeBook.MD