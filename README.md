## Introduction

The R script - run_analysis.R - is intended to prepare tidy data that can be used for later data analysis.  

## Data
The [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) referred in the R script is collceted from the accelerometers from the Samsung Galaxy S smartphone. [A full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is available at the site where the data was obtained.  

## Getting and Cleaning Data
The following steps are used in the R script for getting and cleaning data.  
1. Loading data and description files from local directory.  
2. Extracts only the measurements on the mean and standard deviation.  
3. Save the extracted data into a data frame and replace the activities id with descriptive actitivy name.  
3. Merge the training and the test sets to create one single data set.  
4. Calculate the average of each variable for each actitivies and each subject and Save the resulted data to a second, independent tidy data set.

