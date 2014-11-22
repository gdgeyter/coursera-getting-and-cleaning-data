library(data.table)
# SETUP: download, unzip and read in the necessary data files.
fileUrl <- paste("https://d396qusza40orc.cloudfront.net/getdata%2Fproj",
                "ectfiles%2FUCI%20HAR%20Dataset.zip", sep="")
download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")
testX <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testy <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# 1. 
# Column bind all test and train data. Rowbind both data sets to the full sample
testX_0<-cbind(testX,testy)
testX_0<-cbind(testX_0,testSub)col
trainX_0<-cbind(trainX,trainy)
trainX_0<-cbind(trainX_0,trainSub)
FullSample<-rbind(testX_0,trainX_0)

#2
# Calculate mean and standard deviation values for all variables
means <- sapply(FullSample,mean,na.rm=TRUE)
stds <- sapply(FullSample,mean,na.rm=TRUE)

#3
# Reading in activities and placing decripte activities instead of levels.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",
                         header=FALSE,colClasses="character")
testy$V1 <- factor(testy$V1, levels=activities$V1, labels=activities$V2)
trainy$V1 <- factor(trainy$V1, levels=activities$V1, labels=activities$V2)


#4
#Label the data set with approriate label names
features <- read.table("./UCI HAR Dataset/features.txt",
                       header=FALSE,colClasses="character")
colnames(testX)<-features$V2
colnames(trainX)<-features$V2
colnames(testy)<-c("Activity")
colnames(trainy)<-c("Activity")
colnames(testSub)<-c("Subject")
colnames(trainSub)<-c("Subject")

#5
# Redo step 1 and 2
# Calculate mean and standard deviation values for all variables
testX<-cbind(testX,testy)
testX<-cbind(testX,testSub)
trainX<-cbind(trainX,trainy)
trainX<-cbind(trainX,trainSub)
FullSample<-rbind(testX,trainX)
means <- sapply(FullSample,mean,na.rm=TRUE)
stds <- sapply(FullSample,mean,na.rm=TRUE)
datatab <- data.table(FullSample)
tidy_set<-datatab[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy_set,file="tidy.txt",sep=",",row.names = FALSE)

