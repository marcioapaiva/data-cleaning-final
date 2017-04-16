# CodeBook

Describes the format of the data output from the `run_analysis.R` script. The [README](README.md) describes how to read the output files to an R dataframe.

The features for the original database are described in the [UCI Website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

All of the measurements have been normalized.

# har_data
The variables in the dataset come from measurements on a set of 30 subjects doing a range of 6 activities each (Walking Upstairs, Walking Downstairs...). The variables "subject" and "activity" indicate the subject and activity being referred to, while the others are calculated from the raw accelerometer and gyroscope signals, captured at 50Hz.

The raw signals were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc and tGravityAcc) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk.XYZ and tBodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc.XYZ, fBodyAccJerk.XYZ, fBodyGyro.XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

The names of the variables therefore follow the pattern:

| Time or Frequency domain  | Measurement | Magnitude? (opt) | .Calculation | .component (opt) |
| ----- | ------------------------------------------------------------ | --- | --- | --- |
| t, f  | BodyAcc, BodyGyro, BodyAccJerk, GravityAcc, BodyGyroJerk  | Mag | .mean, .std, .meanFreq | .X, .Y, .Z |

The calculations are explained below:

| Calculation Type | Description |
| --- | --- |
| mean | Mean value |
| std | Standard deviation |
| meanFreq | Weighted average of the frequency components to obtain a mean frequency |

The measurements are detailed below:

| Measurement | Description |
| --- | --- |
| BodyAcc | Body linear acceleration signal |
| BodyGyro | Gyroscope signal (angular velocity) |
| BodyAccJerk | Linear Jerk, calculated from the derivative of BodyAcc |
| GravityAcc | Gravity acceleration signal |
| BodyGyroJerk | Angular Jerk, calculated from the second derivative of BodyGyro |

# har_data_means

These are the same as in har_data, but rows were grouped by subject and activity and every measurement was substituted by the mean across the same (subject, activity) pair, adding ".mean" to the column name.