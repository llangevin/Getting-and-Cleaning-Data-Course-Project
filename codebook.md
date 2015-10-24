#Coursera Getting and Cleaning Data Course Project CodeBook
###Getting and Cleaning Data Course Project, Peer assessments
###October 2015

#Codebook
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

##Study design and data processing

###Collection of the raw data

The data come from the Human Activity Recognition Using Smartphones Dataset, www.smartlab.ws.
The experiments have been carriy out with a group of 30 volunteers.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using the smartphone embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

More details on the experiment website:
http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions#

Weblink data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Notes and descrition of the original raw data

For each record it is provided:
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.
                                                  Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt'
 												  and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#### Additionnal Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- Details on the features available in the features_info.txt.


##Creating the tidy datafile

###Getting the data
The data are available on the web in a zip file, so the download.file and unzip function are used to obtain and decompresse
the data on are working directory.

Weblink for the data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

After the unzip, there is a directory name 'UCI HAR Dataset' containing 2 directories of data: train and test.
The subjects have been randomly assigned to one of the 2 groups (train or test), so the subjects observations are in only one of the directories.
The structure of data files is the same in each directory.
When regrouping the data, it is important to take account that there is 2 separated groups of observations (train and test)
and they must be append (rbind function).
Also in each of this 2 groups, 3 files (subject_, y_ and x_) with the same numbers of observations must be merge side by side without altering the data order (cbind function).
The files are loaded in R using the read.csv function and combine together using cbind and rbind functions.

###Cleaning of the data
Once the data have been combined, the variable names are added using the features.txt file and the name function.
Only the measurements on the mean and standard deviation are kept using subset and the grep function.
The variables are renamed to be human readable, by replacing abbreviation with full name using sub and gsub function.
In the tidy dataset, the actvity number have been replace with his appropriated label.
The average of each variable for each activity and each subject is calculated and stored in a wide form of tidy data.

##Summary choice

A tidy data in the wide form has been produced, we want for each combination of subject*activity all the average measurements on 1 line.

##Description of the variables in the tidy data (tidy_data.txt) file.

The tidy data is in a wide form, so the dimension are 180 observations (30 subjects * 6 activities) and 68 variables
(subject, activity and 66 average measurements)
tidy_data: 'data.frame':	180 obs. of  68 variables:

###Variable 1
 [1] "subject"
Subject number, (num) from 1 to 30. (no unit)

###Variable 2
 [2] "activity" 
Activity performed by the subjects, (char) WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING or LAYING

###Variable 3 to 68, (num) (no unit)
 [3] "time_body_acceleration_mean_x"                  
 [4] "time_body_acceleration_mean_y"                  
 [5] "time_body_acceleration_mean_z"                  
 [6] "time_body_acceleration_std_x"                   
 [7] "time_body_acceleration_std_y"                   
 [8] "time_body_acceleration_std_z"                   
 [9] "time_gravity_acceleration_mean_x"               
[10] "time_gravity_acceleration_mean_y"               
[11] "time_gravity_acceleration_mean_z"               
[12] "time_gravity_acceleration_std_x"                
[13] "time_gravity_acceleration_std_y"                
[14] "time_gravity_acceleration_std_z"                
[15] "time_body_acceleration_jerk_mean_x"             
[16] "time_body_acceleration_jerk_mean_y"             
[17] "time_body_acceleration_jerk_mean_z"             
[18] "time_body_acceleration_jerk_std_x"              
[19] "time_body_acceleration_jerk_std_y"              
[20] "time_body_acceleration_jerk_std_z"              
[21] "time_body_gyroscope_mean_x"                     
[22] "time_body_gyroscope_mean_y"                     
[23] "time_body_gyroscope_mean_z"                     
[24] "time_body_gyroscope_std_x"                      
[25] "time_body_gyroscope_std_y"                      
[26] "time_body_gyroscope_std_z"                      
[27] "time_body_gyroscope_jerk_mean_x"                
[28] "time_body_gyroscope_jerk_mean_y"                
[29] "time_body_gyroscope_jerk_mean_z"                
[30] "time_body_gyroscope_jerk_std_x"                 
[31] "time_body_gyroscope_jerk_std_y"                 
[32] "time_body_gyroscope_jerk_std_z"                 
[33] "time_body_acceleration_magnitude_mean"          
[34] "time_body_acceleration_magnitude_std"           
[35] "time_gravity_acceleration_magnitude_mean"       
[36] "time_gravity_acceleration_magnitude_std"        
[37] "time_body_acceleration_jerk_magnitude_mean"     
[38] "time_body_acceleration_jerk_magnitude_std"      
[39] "time_body_gyroscope_magnitude_mean"             
[40] "time_body_gyroscope_magnitude_std"              
[41] "time_body_gyroscope_jerk_magnitude_mean"        
[42] "time_body_gyroscope_jerk_magnitude_std"         
[43] "frequency_body_acceleration_mean_x"             
[44] "frequency_body_acceleration_mean_y"             
[45] "frequency_body_acceleration_mean_z"             
[46] "frequency_body_acceleration_std_x"              
[47] "frequency_body_acceleration_std_y"              
[48] "frequency_body_acceleration_std_z"              
[49] "frequency_body_acceleration_jerk_mean_x"        
[50] "frequency_body_acceleration_jerk_mean_y"        
[51] "frequency_body_acceleration_jerk_mean_z"        
[52] "frequency_body_acceleration_jerk_std_x"         
[53] "frequency_body_acceleration_jerk_std_y"         
[54] "frequency_body_acceleration_jerk_std_z"         
[55] "frequency_body_gyroscope_mean_x"                
[56] "frequency_body_gyroscope_mean_y"                
[57] "frequency_body_gyroscope_mean_z"                
[58] "frequency_body_gyroscope_std_x"                 
[59] "frequency_body_gyroscope_std_y"                 
[60] "frequency_body_gyroscope_std_z"                 
[61] "frequency_body_acceleration_magnitude_mean"     
[62] "frequency_body_acceleration_magnitude_std"      
[63] "frequency_body_acceleration_jerk_magnitude_mean"
[64] "frequency_body_acceleration_jerk_magnitude_std" 
[65] "frequency_body_gyroscope_magnitude_mean"        
[66] "frequency_body_gyroscope_magnitude_std"         
[67] "frequency_body_gyroscope_jerk_magnitude_mean"   
[68] "frequency_body_gyroscope_jerk_magnitude_std"

###Notes on variable 3 to 68:

Each variables correspond to a feature and are average of measurements for each combinations of suject*activity.
Features are normalized and bounded within [-1,1], so there are no unit.
Informations about the variables used on the feature vector are available in the features_info.txt file.

###Sources

http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions#