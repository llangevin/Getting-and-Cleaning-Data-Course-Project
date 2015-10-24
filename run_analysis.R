#Getting and Cleaning Data Course Project / Peer Assessments
#Built a tidy dataset for analysis with the Smartphone-Based Recognition of 
#Human Activities and Postural Transitions Data Set

#Step 1
#Getting the data
setwd("C:/Users/Luc/Documents/coursera/Getting and Cleaning Data/PA")
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "./PA_data.zip")
unzip("./PA_data.zip")
list.files("./UCI HAR Dataset")

#Step2
#reading the data into R
#features and activity label list
features<-read.csv("./UCI HAR Dataset/features.txt",header=FALSE, sep='')
activity_labels<-read.csv("./UCI HAR Dataset/activity_labels.txt",header=FALSE, sep='', stringsAsFactors=F)
names(activity_labels)<-c("activity_number","activity")

#train data, subjects, activities and measurements
subject_train<-read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep='')
names(subject_train)<-"subject"
y_train<-read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE, sep='')
names(y_train)<-"activity_number"
x_train<-read.csv("./UCI HAR Dataset/train/x_train.txt",header=FALSE, sep='')

#test data, subjects, activities and measurements
subject_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep='')
names(subject_test)<-"subject"
y_test<-read.csv("./UCI HAR Dataset/test/y_test.txt",header=FALSE, sep='')
names(y_test)<-"activity_number"
x_test<-read.csv("./UCI HAR Dataset/test/x_test.txt",header=FALSE, sep='')

#Step3
#Naming columns of measurements files and keeping only variables on the mean and standard deviation for each measurement.
names(x_train)<-as.character(features[,2])
names(x_test)<-as.character(features[,2])
x_train<-x_train[ , grep( "mean|std" , names( x_train ) ) ]
x_test<-x_test[ , grep( "mean|std" , names( x_test ) ) ]
x_train<-x_train[ , -grep( "Freq" , names( x_train ) ) ]
x_test<-x_test[ , -grep( "Freq" , names( x_test ) ) ]

#Step4
#Data gathering
train<-cbind(subject_train,y_train,x_train)
test<-cbind(subject_test,y_test,x_test)
dataset<-rbind(train,test)
str(dataset)

#Step5
#Appropriately label the measurements datasets with descriptive variable names.
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

#Step6
#Calculate mean per subject/activity for all measurements
mean_data<-aggregate(dataset,by=list(dataset$activity_number,dataset$subject), FUN=mean,na.rm=TRUE)
str(mean_data)

#Step7
#Uses descriptive activity names to name the activities in the data set
mean_data<-merge(mean_data[-c(1,2)],activity_labels,by.x="activity_number",by.y="activity_number",all.x=T,sort=F)
mean_data<-mean_data[ order(mean_data[,"subject"], mean_data[,"activity"]),]
mean_data<-mean_data[c(2,69,3:68)]
str(mean_data)
#'data.frame':	180 obs. of  68 variables:
head(mean_data)

#Step8
#export tidy dataset to .txt
write.table(mean_data,file="./UCI HAR Dataset/summary_mean_data.txt",row.name=FALSE)