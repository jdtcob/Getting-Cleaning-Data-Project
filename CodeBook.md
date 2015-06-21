# Code Book

This is a code book that describes the variables, the data, and any transformations or work that I performed to clean up this data.

## Raw Data
Raw data was obtained from the UCI Machine Learning Repository
[Full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


### Attribute Information

For each record in the dataset the following is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## Raw Data Transformation

The raw data set are processed with the script run_analysis.R to create a tidy data set. The following steps were taken:

-Merges the training and the test sets: Combine the training and testing data along with the 
subject labels, activity labels, and names of each of the variables measured.
-Extract measurements on the mean and standard deviation. Retain only the measurements relating to mean and standard deviation.
-Uses descriptive activity names. Convert the activity labels from numeric to text desciptors.
-Label the data set with descriptive variable names. Alter the provided descriptions of the data measured to eliminate abbreviations and add clarity to the variable names.
-Create a second, independent tidy data set. Create an independent tidy data set with the average of each variable for each activity and each subject.


## Tidy Data Set

### Variables

The tidy data set contains the following:

- a variable identifying the subject named Subject: The variable range is 1 to 30.
- a variable identifying activity named Activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- mean of all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal: numeric value

Explaining the variable name convention:

-The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerometerJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerometerMag, timeGravityAccelerometerMag, timeBodyAccelerometerJerkMagnitude, timeBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). A Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAccelerometer-XYZ, frequencyBodyAccelerometerJerk-XYZ, frequencyBodyGyroscope-XYZ, frequencyBodyAccelerometerJerkMagnitude, frequencyBodyGyroscopeMagnitude, frequencyBodyGyroscopeJerkMagnitude.
-mean/std: mean or standard deviation of the measurement
-X/Y/Z: one direction of a 3-axial signal
-mean: global mean value

The data set is written to the file tidydata.txt