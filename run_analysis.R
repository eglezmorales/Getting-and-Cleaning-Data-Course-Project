library(data.table)
## A) Merges the training and the test sets to create one data set ->"data"
##  1.- work with "test" datasets:
##   1.1- read data tables
featureName<-read.table("./UCI HAR Dataset/features.txt")
testX<-read.table("./UCI HAR Dataset/test/X_test.txt")
testY<-read.table("./UCI HAR Dataset/test/Y_test.txt")
testSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
##   1.2.- join data tables in one
testData<-data.table(cbind(testSubject,testY,testX))
##   1.3.- rename columns with feature's file
##setnames(testData,1:563,c("Subject","Activity",as.character(levels(featureName$V2))[featureName$V2]))
##  2.- work with "train" datasets:
##   2.1.- read data tables
trainX<-read.table("./UCI HAR Dataset/train/X_train.txt")
trainY<-read.table("./UCI HAR Dataset/train/Y_train.txt")
trainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
##   2.2.- join data tables in one
trainData<-data.table(cbind(trainSubject,trainY,trainX))
##   2.3.- rename columns with feature's file
##setnames(trainData,1:563,c("Subject","Activity",as.character(levels(featureName$V2))[featureName$V2]))
##  3.- Join "test" and "train":
##   3.1.- add a new variable "type" with value "test" for testData observations and "training" for 
##trainData observations
testData<-testData[,type:="test"]
trainData<-trainData[,type:="training"]
##   3.2.- join tables in one->"data"
data<-rbind(testData,trainData,fill=TRUE)
## B) Extracts only the measurements on the mean and standard deviation for each measurement ->"dataSimp"
## First of all, work with tbl_df
library(dplyr)
library(tidyr)
##  1.- rename columns with feature's file
setnames(data,1:563,c("Subject","Activity",as.character(levels(featureName$V2))[featureName$V2]))
setnames(data,1:564,make.names(colnames(data),unique=TRUE)) #eliminate "()" from column's name
##  2.- selecte columns with "mean" or "std" in its name as well as "Activity", "Subject" and "type" variables
dataSimp<-data%>%tbl_df%>%select(Activity,Subject,type,contains("mean"),contains("std"))%>%select(-contains("Jerk"),-contains("Mag"),-contains("f"),-contains("angle"))
## C) Uses descriptive activity names to name the activities in the data set.
dataSimp<-data.table(dataSimp)
act_labels<-data.table(read.table("./UCI HAR Dataset/activity_labels.txt"))
labels<-act_labels$V2
dataSimp[,Activity:=as.character(Activity)]
for (i in 1:6){dataSimp[Activity==i,Activity:=labels[i]]}
## D) Appropriately labels the data set with descriptive variable names.
## Previously done (see line 34 and 35)
n<-gsub(".mean...","_mean_",names(dataSimp)) #simplify names with _ separating components instead of ...
n<-gsub(".std...","_std_",n)
n<-gsub("Acc_","_Acc_",n)
n<-gsub("Gyro_","_Gyro_",n)
setnames(dataSimp,names(dataSimp),n)
## E) From the data set in step D), creates a second, independent tidy data set with the average of each variable 
##for each activity and each subject: "dataAvgTidy" 
dataAvg<-dataSimp %>% tbl_df %>% group_by(Activity, Subject, type) %>% summarise_each(funs(mean))
## To have one observation in each row it would be: each subject-each activity-each measurement instrument("sensor")
## it means, accelerometer and gyroscope. 
## 1.- separate variables into its diferent components: "motionComp", "sensor", "calc" and "axis"
dataAvgLong<-dataAvg%>%gather(motionComp_sensor_calc_axis,value,-c(Activity,Subject,type))%>% separate(motionComp_sensor_calc_axis,c("motionComp","sensor","calc","axis"))
DT<-data.table(dataAvgLong)
## 2.- combine "motionComp", "calc" and "axis" in a unique new_col and bind new_col to data table
new_col<-paste(DT$motionComp,DT$calc,DT$axis,sep="_")
DTlong<-cbind(dataAvgLong,new_col)
## 3.- to get the finally tidy data table, select the columns and spread new_col in its value
dataAvgTidy<-DTlong%>%tbl_df%>%select(-c(motionComp,calc,axis))%>%spread(new_col,value)
write.table(dataAvgTidy,file="dataAvgTidy.txt",row.name=FALSE)
