#Create directory, download data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzip data
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Set reference path
reference_path<-file.path("./data","UCI HAR Dataset")

#Read in movement data ("training" and "testing")
MoveDataTrain<-read.table(file.path(reference_path,"train","X_train.txt"),header=FALSE)
MoveDataTest<-read.table(file.path(reference_path,"test","X_test.txt"),header=FALSE)

#Read in movement labels ("training" and "testing")
MoveLabelsTrain<-read.table(file.path(reference_path,"train","y_train.txt"),header=FALSE)
MoveLabelsTest<-read.table(file.path(reference_path,"test","y_test.txt"),header=FALSE)

#Read in subject labels ("training" and "testing")
SubjectLabelTrain<-read.table(file.path(reference_path,"train","subject_train.txt"),header=FALSE)
SubjectLabelTest<-read.table(file.path(reference_path,"test","subject_test.txt"),header=FALSE)

#Read in feature labels
FeatureLabels<-read.table(file.path(reference_path,"features.txt"),header=FALSE)

#Merge Data Training and Testing Data
dataActLabel<-rbind(MoveLabelsTrain,MoveLabelsTest)
dataMovement<-rbind(MoveDataTrain,MoveDataTest)
dataSubject<-rbind(SubjectLabelTrain,SubjectLabelTest)

#Assign names to data
names(dataActLabel)<-c("Activity")
names(dataSubject)<-c("Subject")
names(dataMovement)<-FeatureLabels$V2

#Combine all data, get dimensions
CombineData<-cbind(dataMovement,dataSubject,dataActLabel)
dataSize<-dim(CombineData)

#Find indices of observations only measuring mean and std, append subject and activity notations (last two columns)
subsetMeanSTD<-c(grep("mean\\(\\)|std\\(\\)",FeatureLabels$V2),dataSize[2]-1,dataSize[2])

#Create separate data containing only measurements for mean and std
SubsetData<-CombineData[,subsetMeanSTD]

#Get dimensions of adjusted data
dataSize<-NULL
dataSize<-dim(SubsetData)
last_column<-dataSize[2]-1

#Read in activity labels
ActivityLabels<-read.table(file.path(reference_path,"activity_labels.txt"),header=FALSE)

#Convert original activity labels from numeric to factor
Activity<-factor(SubsetData[,dataSize[2]],levels=c("1","2","3","4","5","6"),ActivityLabels$V2)

#Add Activity Labels to data set, this will replace the original numeric notation
SubsetData<-cbind(SubsetData[,1:last_column],Activity)

#Alter names of variables to increase readability
names(SubsetData)<-gsub("^t","time",names(SubsetData))
names(SubsetData)<-gsub("Acc","Accelerometer",names(SubsetData))
names(SubsetData)<-gsub("Gyro","Gyroscope",names(SubsetData))
names(SubsetData)<-gsub("Mag","Magnitude",names(SubsetData))
names(SubsetData)<-gsub("^f","frequency",names(SubsetData))
names(SubsetData)<-gsub("BodyBody","Body",names(SubsetData))

#Create tidy data set
library(plyr)
TidyData1<-aggregate(. ~Subject + Activity, SubsetData, mean)
TidyData2<-TidyData1[order(TidyData1$Subject,TidyData1$Activity),]
write.table(TidyData2, file = "tidydata.txt",row.name=FALSE)