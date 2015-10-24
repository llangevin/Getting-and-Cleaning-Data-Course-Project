# Getting-and-Cleaning-Data-Course-Project
###Getting and Cleaning Data Course Project, Peer assessments
###October 2015

##Project Description

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.
Create one R script called run_analysis.R that does the following:
-Obtain the data files in raw format.
-Merges the training and the test sets to create one data set.
-Extracts only the measurements on the mean and standard deviation for each measurement. 
-Uses descriptive activity names to name the activities in the data set
-Appropriately labels the data set with descriptive variable names. 
-Finaly create an independent tidy data set with the average of each variable for each activity and each subject.


##The instruction list
###This section explain how to use the "run_analysis.R" an R script to obtain a tidy dataset for analysis
###of the Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set from www.smartlab.ws

*The script have been developped using RStudio Version 0.99.484 on Windows 7.

*To obtain the tidy dataset, run the script in R from Step1 to Step8.

*In the Step1 section of the script, you will have to specify your working directory in the 'setwd' function. The raw data will be store in a directory name "UCI HAR Dataset" in your set working directory.

*In Step2 the raw data will be read into R and store in data frames.

*Step3 to Step7 transforme, gather and summarize the data to obtain the tidy dataset.

*In Step8, you can specify the output destination of the tidy dataset in the 'file' parameter of the 'write.table' function.


##Analysis file details explanation of the "run_analysis.R"
###Step 1: Getting the data
###working directory specification
setwd("C:/Users/Luc/Documents/coursera/Getting and Cleaning Data/PA")
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "./PA_data.zip")
unzip("./PA_data.zip")
list.files("./UCI HAR Dataset")

###Step2
###reading the data into R
###features and activity label list
features<-read.csv("./UCI HAR Dataset/features.txt",header=FALSE, sep='')
activity_labels<-read.csv("./UCI HAR Dataset/activity_labels.txt",header=FALSE, sep='', stringsAsFactors=F)
names(activity_labels)<-c("activity_number","activity")

###train data, subjects, activities and measurements
subject_train<-read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep='')
names(subject_train)<-"subject"
y_train<-read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE, sep='')
names(y_train)<-"activity_number"
x_train<-read.csv("./UCI HAR Dataset/train/x_train.txt",header=FALSE, sep='')

###test data, subjects, activities and measurements
subject_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep='')
names(subject_test)<-"subject"
y_test<-read.csv("./UCI HAR Dataset/test/y_test.txt",header=FALSE, sep='')
names(y_test)<-"activity_number"
x_test<-read.csv("./UCI HAR Dataset/test/x_test.txt",header=FALSE, sep='')

###Step3
###Naming columns of measurements files and keeping only variables on the mean and standard deviation for each measurement.
names(x_train)<-as.character(features[,2])
names(x_test)<-as.character(features[,2])
x_train<-x_train[ , grep( "mean|std" , names( x_train ) ) ]
x_test<-x_test[ , grep( "mean|std" , names( x_test ) ) ]
x_train<-x_train[ , -grep( "Freq" , names( x_train ) ) ]
x_test<-x_test[ , -grep( "Freq" , names( x_test ) ) ]

###Step4
###Data gathering, side by side for each the train and test files, then appending of the 2 data frames.
train<-cbind(subject_train,y_train,x_train)
test<-cbind(subject_test,y_test,x_test)
dataset<-rbind(train,test)
str(dataset)
###'data.frame':	10299 obs. of  68 variables:

###Step5
###Appropriately label the measurements datasets with descriptive variable names.
tidy_names<-names(dataset)
tidy_names<-gsub("-","_",tidy_names,fixed=TRUE)
tidy_names<-sub("()","",tidy_names,fixed=TRUE)
tidy_names<-sub("^t","time_",tidy_names)
tidy_names<-sub("^f","frequency_",tidy_names)
tidy_names<-sub("Acc","_acceleration_",tidy_names)
tidy_names<-sub("Gyro","_gyroscope_",tidy_names)
tidy_names<-sub("Mag","_magnitude_",tidy_names)
tidy_names<-sub("BodyBody","body",tidy_names)
tidy_names<-gsub("__","_",tidy_names)
tidy_names<- tolower(tidy_names)
names(dataset)<-tidy_names

###Step6
###Calculate average per subject/activity for all measurements
mean_data<-aggregate(dataset,by=list(dataset$activity_number,dataset$subject), FUN=mean,na.rm=TRUE)
str(mean_data)

###Step7
###Uses descriptive activity names to name the activities in the data set
mean_data<-merge(mean_data[-c(1,2)],activity_labels,by.x="activity_number",by.y="activity_number",all.x=T,sort=F)
mean_data<-mean_data[ order(mean_data[,"subject"], mean_data[,"activity"]),]
tidy_data<-mean_data[c(2,69,3:68)]
str(tidy_data)
###'data.frame':	180 obs. of  68 variables:
head(tidy_data)

###Step8
###export tidy dataset to .txt
write.table(tidy_data,file="./Getting-and-Cleaning-Data-Course-Project/tidy_data.txt",row.name=FALSE)