## Description of this file

The purpose of this file is to explain the repository. This repository contains all files required for the Getting and Cleaning Data course project. Contained in this repository:
- CodeBook.md: information about the raw and tidy data sets
- README.md: this file, describing the course project and steps taken to transform the data from raw to tidy
- run_analysis.R: the R script completing the assignment


## Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!


## R script explanation

This is a thorough explanation of how the data for this course project is transformed from raw to tidy. For the rest of this discussion the term line 7 will refer to the 7th line of the file run_analysis.R

Lines 1-10 download the data, creata a separate folder to store the data, and unzip the file.


Lines 12-25 read in the raw data. MoveDataTrain is the raw measurements. MoveLabelsTrain is a separate file containing numeric labels indicating, WALKING, WALKING_UPSTAIRS ... etc for each observation contained in MoveDataTrain. SubjectLabelTrain indicates the subject associated with each observation in MoveDataTrain. It should be noted that each of the named variables created in the script are data frames and there are three additional data frames where Train is replaced by Test. This is due to the fact that the data that was downloaded was divided into training and testing sets. FeatureLabels is also created which indicates the names of each of the raw variables, or the length of FeatureLabels equals the number of variables of MoveDataTrain.

At this point we have 7 data frames
- MoveDataTrain
- MoveDataTest
- MoveLabelsTrain
- MoveLabelsTest
- SubjectLabelTrain
- SubjectLabelTest
- FeatureLabels


Lines 27-39 combine the training and testing sets. This is necessary because at the onset the data was divided for machine learning problems. 

MoveDataTrain and MoveDataTest are combined into one dataframe, dataMovement, where the number of variables remains the same. The number of observations increases.

MoveLabelsTrain and MoveLabelsTest are combined into one dataframe, dataActLabel, indicating the numeric labels for each of the six possible activities (full description found in CodeBook.md)

SubjectLabelTrain and SubjectLabelTest are combined into one dataframe, dataSubject, indicating all subjects included in the data set. 

Names are then applied to each variable in dataMovement. These names are the variable names given from the variable FeatureLabels. “Subject” and “Activity” are manually applied to dataSubject and dataActLabel respectively. Finally the three dataframes, dataMovement, dataSubject, and dataActLabel are combined into one dataframe, CombineData. At this point the requirement “Merges the training and the test sets to create one data set” is satisfied.


Lines 41-45 find all variables that measure either mean or standard deviation. This is accomplished via a string search for mean() or std() with the R function gsub. This function returns a numeric vector, subsetMeanSTD, whose values indicate the variables of CombineData that measure mean or standard deviation. A new dataframe, SubsetData, is now formed containing only these values. The number of observations does not change, however, the number of variables is not significantly reduced. At this point the requirement “Extracts only the measurements on the mean and standard deviation for each measurement” is satisfied.


Lines 52-59 aim to alter the “Activity” column of our dataframe SubsetData. This is accomplished by creating a dataframe ActivityLabels. This dataframe contains the information necessary to translate the numeric data (1,2,3,4,5,6) into text descriptions of the activities being performed. The R function “factor” is employed to accomplish this goal. The result of this function is stored in the variable, Activity which is of type factor. See the R documentation on the factor class for more information. Next, we simply replace the original numeric labels with this factor variable. At this point the requirement “Uses descriptive activity names to name the activities in the data set” is satisfied.


Lines 61-67 employ the R function gsub to expand the descriptions of each of the variable names in our data set. The following changes are made:

- t -> time
- Acc -> Accelerometer
- Gyro-> Gyroscope
- Mag -> Magnitude
- f -> frequency
- BodyBody -> Body

To visually confirm the variables names are sufficiently descriptive we can use the R command “names(SubsetData)”. At this point the requirement “Appropriately labels the data set with descriptive variable names” is satisfied.


Finally, in lines 70-73, we are asked to create a “tidy data set with the average of each variable for each activity and each subject”. This is accomplished with the R function “aggregate”. This function is used to collapse data in R using one or more BY variables and a defined function. In this case we wish to return “the average of each variable for each activity and each subject”. The data is then ordered by subject and activity and then written to a file “tidydata.txt”. At this point the requirement “Create a second, independent tidy data set with the average of each variable for each activity and each subject” is satisfied.