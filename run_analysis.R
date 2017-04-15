# Script created inside a function to avoid polluting the global namespace.
# Actually exports variables har_data and har_data_means
(analysis <- function() {
  library(dplyr)
  
  data_dir = "UCI HAR Dataset/"
  
  # Paths to relevant files
  test_data_path <- paste(data_dir, "test/X_test.txt", sep = "")
  test_subjects_path <- paste(data_dir, "test/subject_test.txt", sep = "")
  test_activities_path <- paste(data_dir, "test/y_test.txt", sep = "")
  
  train_data_path <- gsub("test", "train", test_data_path)
  train_subjects_path <- gsub("test", "train", test_subjects_path)
  train_activities_path <- gsub("test", "train", test_activities_path)
  
  features_path <- paste(data_dir, "features.txt", sep = "")
  activity_labels_path <- paste(data_dir, "activity_labels.txt", sep = "")
  
  # Reading train and test data
  test_data <- read.table(test_data_path, sep = "")
  test_subjects = as.integer(readLines(test_subjects_path))
  test_activities = as.integer(readLines(test_activities_path))
  
  train_data <- read.table(train_data_path, sep = "")
  train_subjects = as.integer(readLines(train_subjects_path))
  train_activities = as.integer(readLines(train_activities_path))
  
  # Merging train and test data.
  # HAR == Human Activity Recognition
  har_data <- rbind(test_data, train_data)
  subjects <- c(test_subjects, train_subjects)
  activities <- c(test_activities, train_activities)
  
  # Removing duplicate columns and setting their names
  features <- read.table(features_path)
  unique_features <- features[!duplicated(features$V2),]
  unique_features_ids <- unique_features$V1
  unique_features_names <- unique_features$V2
  
  har_data <- har_data[,unique_features_ids]
  colnames(har_data) <- unique_features_names
  
  # Select only columns that contain "std" or "mean", and remove angles
  har_data <- har_data %>% 
    select(matches("(mean)|(std)")) %>%
    select(-starts_with("angle"))
  har_data$subject <- subjects
  har_data$activity <- activities
  
  # Better formatting for activity names
  
  ## This takes a vector of strings of the form "aBc_DEF_ghi" and
  ## transforms them to "Abc Def Ghi"
  ## (slightly modified from the capwords function in the help file for "toupper")
  cap_underscore <- function(s) {
    cap <- function(s) paste(toupper(substring(s, 1, 1)),
                             tolower(substring(s,2)),
                             sep = "", collapse = " " )
    sapply(strsplit(s, split = "_"), cap, USE.NAMES = !is.null(names(s)))
  }
  activity_labels <- read.table(activity_labels_path, stringsAsFactors = FALSE)
  activity_labels = cap_underscore(activity_labels$V2)
  
  ## Sets the activities in the dataset to the new names
  har_data$activity = sapply(har_data$activity, function(x) activity_labels[[x]])
  
  # Columns are renamed to make them easier to work with in R
  colnames(har_data) <- gsub("()", "", colnames(har_data), fixed = TRUE)
  colnames(har_data) <- gsub("-", ".", colnames(har_data), fixed = TRUE)
  
  # Second dataset - Contains the mean of each variable for each subject and each activity
  har_data_means <- har_data %>%
    group_by(activity, subject) %>%
    summarise_each(funs(mean = mean(.)))
  
  colnames(har_data_means) <- gsub("_mean$", ".mean", colnames(har_data_means))
  
  # Outputs the datasets to files
  write.table(har_data, "har_data.tbl", row.name=FALSE)
  write.table(har_data_means, "har_data_means.tbl", row.name=FALSE)
  
  # Exports har_data and har_data_means to global namespace
  har_data <<- har_data
  har_data_means <<- har_data_means
})()