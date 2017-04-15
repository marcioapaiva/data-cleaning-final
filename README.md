Final project for coursera's Getting and Cleaning Data course.

The script 'run_analysys.R' is responsible for doing the data cleaning. It assumes the data, available in "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", is contained (unzipped) in a directory named "UCI HAR Dataset" in the same level as the script. The data is originally from "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones".

The script tidies the data according to the project's requirements, and outputs the files har_data.tbl and har_data_means.tbl. The transformations are described below.

- The main data is read from the files X_test.txt and X_train.txt. Subjects and activities are also read from subject_test.txt, subject_train.txt, y_test.txt and y_train.txt.

- Test and train data is merged using rbind, generating the variables har_data, subjects,
and activities.

- The name of the features is read from the "features.txt" file. The id for the non-duplicate features are selected, and the others are discarded. The names are used to name the columns of the har_data dataframe.

- har_data columns are filtered to discard the ones we're not interested in. Only columns contained std or mean were kept, except if they represented an angle. See [^1].

- subjects and activities vectors are incorporated to har_data as columns

- The values in the activities column are changed from numbers to a descriptive label. See [^2]

- Columns are renamed to be easier to work with in R. See [^3]

- A second data set is created from har_data, called har_data_means, that calculates the mean of each of the columns in har_data over each subject and each activity. See [^4]


[^1]: According to the requirements:
2. Extracts only the measurements on the mean and standard deviation for each measurement.
	This is worded in a somewhat open way so we had to draw the line somewhere. This was interpreted as "only means and stds should be extracted".
	- Angles were removed since they aren't exactly a proper mean or std
	- MeanFreq's were included since they are a weighted means of frequency components.

[^2]: According to the requirements:
3. Uses descriptive activity names to name the activities in the data set
	In the original dataset, activities correspond to number in the [1,6] range, corresponding respectively to "WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING". The new - tidy - dataset uses directly the names "Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying".

[^3]: According to the requirements:
4. Appropriately labels the data set with descriptive variable names.
	Parenthesis were removed and dashes were transformed to dots, to make the variables easier to work with in R (i.e. not requiring backticks to escape their names).

[^4]: According to the requirements:
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	The first dataset was grouped by subject and activity, using the group_by function, and then fed to the summarise function for average calculation for each group. The names of each of the new columns is the old name concatenated with ".".