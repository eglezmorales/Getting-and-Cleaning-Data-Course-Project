---
title: "CodeBook"
author: "Elena Gonzalez"
date: "20 juni 2015"
output: html_document
---

#**Project Description**
The goal of this project is to prepare tidy data that can be used for later analisys.
 
#**Study design**
 
##_**Collection of the raw data**_
Raw data is collected from the accelerometers and gyroscopes embedded in the smartphones
of the subjects (a total of 30 people) of the study. The measurements were taking during
six different activities.

##_**Selecting the tidy-variables**_
According with project instructions, the variables that have be included in the tidy-data
set are those that represent the measurements on the mean and standar desviation, so only 
variables with "mean" or "std" in its name were selected.
On the other hand, some of the variables in the raw-data set are the result of subjecting
original measures to further calculations. For example, deriving in time to obtain Jerk 
signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ), using the Euclidean norm to obtain its 
magnitud (BodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag) or 
applying a Fast Fourier Transform (FFT) (fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, 
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag). So all these variables were not considered
for the tidy-data set.

##_**Process to create the tidy data set**_
The basic steps were:

1. download files from 'test' data
2. create a 'testData' table
3. download files from 'training' data
4. create 'trainData' table
5. merge 'testData' and 'trainData' into 'data' table
6. select variables for the tidy data set
7. calculate avarange of the variables for each activity and subject: 'dataAvg' table
8. reorganize table to create a tidy_data table: 'dataAvgTidy'
 
#**Code Book**
Description of the variables in the tidy-data table

* __Dataset:__ 'dataAvgTidy.txt'
* __Dimensions:__  360 observations and 16 variables
* __Variables:__

    + _Identifiers:_
    
        + Subject - The ID of the subjects of the study
            + Class: numeric, discrete
            + Unique values: 1:30
        + type - variable created to identify if the subject took place in the test or in the training study
            + Class: categorical
            + Unique values: test, training
        + Activity - The name of the test activities
            + Class: categorical
            + Unique values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
        + sensor - The name of the measurement instrument
            + Class: categorical
            + Unique values: Acc (accelerometer), Gyro (gyroscope)
            
    + _Measurements:_
    
        + tBody_mean_X - The mean of the body acceleration signals in the X direction
        + tBody_mean_Y - The mean of the body acceleration signals in the Y direction
        + tBody_mean_Z - The mean of the body acceleration signals in the Z direction
        + tBody_std_X - The standard desviation of the body acceleration signals in the X direction
        + tBody_std_Y - The standard desviation of the body acceleration signals in the Y direction
        + tBody_std_Z - The standard desviation of the body acceleration signals in the Z direction
        + tGravity_mean_X - The mean of the gravity acceleration signals in the X direction
        + tGravity_mean_Y - The mean of the gravity acceleration signals in the Y direction
        + tGravity_mean_Z - The mean of the gravity acceleration signals in the X direction
        + tGravity_std_X - The standard desviations of the gravity acceleration signals in the X direction
        + tGravity_std_Y - The standard desviations of the gravity acceleration signals in the Y direction
        + tGravity_std_Z - The standard desviations of the gravity acceleration signals in the Z direction
        
            + Class: numeric, continuous
            + Values: [-1,1]
