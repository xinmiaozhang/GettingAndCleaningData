#------------------------------------
# Getting and Cleaning Data - Project
#------------------------------------



#-----------------
# load data and descriptions
#-----------------
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",sep = "",nrows=-1)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",sep = "",nrows=-1)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",sep = "",nrows=-1)


X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",sep = "",nrows=-1)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",sep = "",nrows=-1)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep = "",nrows=-1)

features <- read.table("./UCI HAR Dataset/features.txt",sep = "",nrows=-1,stringsAsFactors=FALSE)

activities <- read.table("./UCI HAR Dataset/activity_labels.txt",sep = "",nrows=-1,stringsAsFactors=FALSE)


#-----------------
# get the column indexes for extracting
#-----------------
# mean columns to extract
index1<-grep("mean()",features[,2],fixed=TRUE)

# std columns to extract
index2<-grep("std",features[,2],fixed=TRUE)

# all columns to extract
indexes <-sort(c(index1,index2))


#-----------------
# Extracts only the measurements on the mean 
# and standard deviation for each measurement
#-----------------
test_extracted <- cbind(activity=activities$V2[unlist(y_test)],subject_test,X_test[,indexes])

train_extracted <- cbind(activity=activities$V2[unlist(y_train)],subject_train,X_train[,indexes])


#-----------------
# Merges the training and the test sets
#-----------------
AllExtracted<- rbind(test_extracted,train_extracted)
# label the resulted data set
names(AllExtracted) <- c('activity','subject',features[indexes,2])


#-----------------
# save the data set
#-----------------
write.table(AllExtracted, file='./UCI HAR Dataset/AllExtracted.txt',row.names = FALSE,quote=FALSE)


#-----------------
# Creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject
#-----------------
# split the data by activity for each subject
grouped <- split(AllExtracted[,3:68],list(AllExtracted[,1],AllExtracted[,2]))

# calculate the average of each variable for each subject
AvgSummary <- sapply(grouped,colMeans)
AvgSummary <- data.frame(t(unlist(AvgSummary)))
names(AvgSummary) <- features[indexes,2]
subAct <- data.frame(t(sapply(strsplit(row.names(AvgSummary),"[.]"),c)))
names(subAct) <- c('Activity','Subject')
AvgSummary<-cbind(subAct,AvgSummary)
row.names(AvgSummary) <- NULL
# save the data set
write.table(AvgSummary, file='./UCI HAR Dataset/AvgSummary.txt',row.names = FALSE,col.names=TRUE,quote=FALSE)


