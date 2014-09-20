#################################################################################
# This code must be placed in the same folder where you placed the              #
#   'UCI HAR Dataset' so the folder paths work. The file outputed at the end    #
#   will be added to the same location and be named "tidyDataOutput.txt"        #
#################################################################################


run_analysis <-  function() {
    
    ####################################################################
    # 1. Merges the training and the test sets to create one data set. #
    ####################################################################
    
    # Starts by getting the testing data 
    xData <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, 
                        stringsAsFactors = F)
    
    # Grab the features files so we can rename the x data columns
    xDataName <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, 
                            stringsAsFactors = F)
    # Rename the columns to make naming the X data easier
    names(xDataName) <- c("index", "name")
    
    # Rename the X data columns
    names(xData) <- xDataName[['name']]
    
    # Grab the y data -- the activities and name the column read in 
    yData <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, 
                        stringsAsFactors = F)
    names(yData) <- c("ActivityNumber")
    
    #############################################################################
    # 3. Uses descriptive activity names to name the activities in the data set #
    #############################################################################
    
    # Read in the data for the activity labels
    activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                                header = FALSE, stringsAsFactors = F)
    # Rename the columns
    names(activityNames) = c("col1", "col2")
    
    # Create a new column in our Activity data (named acitivityName) that holds  
    #   the names of the activities. This is based on the activity number 
    #   column. This also replaces the underline within the activity name with
    #   a space and set the text to be lowercase instead of all capitals
    yData$ActivityName <- 
        tolower(gsub("_", " ", sapply(yData$ActivityNumber, function(x) {
            subset(activityNames, activityNames$col1 == x, col2)
        }), fixed=TRUE))
    
    ##############################################
    # End of step 3. returns to the main section #
    ##############################################
    
    # Grabs the subjects and names the column
    subjectData <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                            header = FALSE, stringsAsFactors = F)
    names(subjectData) <- c("Subject")
        
    # Combines the three datasets: subjects, activities, and the main (x) data
    testingData <- cbind(subjectData, yData, xData)
    
    # Removes all the variables used to get the testung data; except xDataName 
    #   and activityNames as we use it below as it doesn't change
    rm("xData")
    rm("yData")
    rm("subjectData")
    
    # Gets the training data
    xData <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, 
                        stringsAsFactors = F)
    
    # Renames the X data columns using the feature file information used for 
    #   the testing data in the first section
    names(xData) <- xDataName[['name']]
    
    # Grabs the y data - the activities - and names the column 
    yData <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, 
                        stringsAsFactors = F)
    names(yData) <- c("ActivityNumber")
    
    #############################################################################
    # 3. Uses descriptive activity names to name the activities in the data set #
    #############################################################################
    
    # Create a new column in our Activity data (named acitivityName) that holds  
    #   the names of the activities. This is based on the activity number 
    #   column. This also replaces the underline within the activity name with
    #   a space and set the text to be lowercase instead of all capitals
    yData$ActivityName <- 
        tolower(gsub("_", " ", sapply(yData$ActivityNumber, function(x) {
            subset(activityNames, activityNames$col1 == x, col2)
        }), fixed=TRUE))
    
    # Remove the activity names as we are now done with it
    rm("activityNames")
    
    ##############################################
    # End of step 3. Returns to the main section #
    ##############################################
    
    # Grab the subjects and names the column
    subjectData <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                              header = FALSE, stringsAsFactors = F)
    names(subjectData) <- c("Subject")
    
    # Combine the three datasets: subjects, activities, and the main data
    trainingData <- cbind(subjectData, yData, xData)
    
    # Remove all variables used to get the training data dataframe
    rm("xData")
    rm("xDataName")
    rm("yData")
    rm("subjectData")
    
    # Combine the training and test data
    mainData <- rbind(trainingData, testingData)
    
    # Remove the testing/training data as we no longer need it as its in 
    #   the mainData
    rm("trainingData")
    rm("testingData")
    
    ##################
    # End of step 1. #
    ##################
    
    #########################################################################
    # 2. Extracts only the measurements on the mean and standard deviation  #
    #   for each measurement.                                               #
    #########################################################################
    
    # Returns the two colums I added to the main data ("Subject" and 
    #  "ActivityNumber") along with any column containing either "mean" or 
    #  "std", but not containing meanfreq. 
    # This was determined as the features_info.txt file mentioned
    #       mean(): Mean value
    #       std(): Standard deviation
    #  Whereas the file says that the 'meanFreq()' is the "Weighted average of 
    #   the frequency components to obtain a mean frequency" thus I chose not 
    #   to see it as a mean or standard deviation
    # Going through the columns I noticed any occurance of the mean, that 
    #   wasn't associated with meanfreq was 'mean()' so I changed the matching
    #   to 'std' or 'mean()'
    
    mainData <- subset(mainData, 
                       select = c("Subject", "ActivityNumber", "ActivityName", 
                                  names(mainData[, grepl("mean\\(\\)|std", 
                                                         names(mainData))])))
    ##################
    # End of step 2. #
    ##################
    
    #########################################################################
    # 4. Appropriately labels the data set with descriptive variable names. # 
    #########################################################################
    
    # For the original column names, found in features.txt, there are two main 
    #   prefixs used: t and f. The 't' prefix is for time and the 'f' prefix is 
    #   for the Frequency Domain Signals. I chose to abbreviate these to "T" 
    #   and "FDS" respectfully:
    #       t = Time = T
    #       f = Frequency Domain Signals = FDS
    #   I am also choosing to abbreviate the standard deviation to SD so the 
    #   column headings don't get too large: 
    #       http://www.allacronyms.com/standard_deviation/abbreviated
    
    # I want this code to make the column headings more descriptive. 
    #   Specifically:
    #       tGravityAcc-mean()-X --> Mean Gravity Acc - X (T) 
    #       fBodyAcc-mean()-Z --> Mean Body Acc - Z (FDS) 
    #       tBodyAccJerkMag-std()-Z --> SD Body Acc Jerk - Z (T) 
    #   If there is no X, Y, or Z at the end of the heading then it will go 
    #   straight from main heading to the T/F abbreviation without the dash. 
    #   Also any repetitive words (side by side) were removed; as this only 
    #   occurs with 'BodyBody' it can be hardcoded.
    #       fBodyBodyGyroJerkMag-std() --> SD Body Gyro Jerk Mag (FDS)
    #   Additionally, we want to seperate our user defined columns at the 
    #   capitals:
    #       ActivityName --> Activity Name
    
    
    # i. Remove repetitive words.
    #   fBodyBodyGyroJerkMag --> fBodyGyroJerkMag-std()
    #   tGravityAcc-mean()-X --> tGravityAcc-mean()-X 
    
    tempNames <- gsub("BodyBody", "Body", names(mainData), fixed=FALSE)
    
    # ii. Seperate the words at the capitals. 
    #   fBodyBodyGyroJerkMag --> f Body Gyro Jerk Mag-std()
    #   tGravityAcc-mean()-X --> t Gravity Acc-mean()-X 
    #   ActivityName --> Activity Name
    
    tempNames <- gsub("([a-z])([A-Z])", "\\1 \\2", tempNames, fixed=FALSE)
    
    # iii. Move the 't' or 'f' to the end with the proper abbreviation in 
    #   brackets
    #       f Body Gyro Jerk Mag-std() --> Body Gyro Jerk Mag-std() (FDS)
    #       t Gravity Acc-mean()-X --> Gravity Acc-mean()-X (T)
    
    tempNames <- sapply(tempNames, function(x) {
        if (grepl("^[t] ", x)) {
            x <- gsub("^[t] ", "", x, fixed=FALSE)
            x <- paste(x, "(T)")
        } else if (grepl("^[f] ", x)) {
            x <- gsub("^[f] ", "", x, fixed=FALSE)
            x <- paste(x, "(FDS)")
        } else {
            x # OTherwise the rows that don't match the if or ifelse will be null
        } 
    }, simplify=TRUE, USE.NAMES = FALSE)
    
    
    # iv. Move the '-mean()' or '-std()' to the beginning with the proper abbr.. 
    #   Body Gyro Jerk Mag-std() (FDS) --> SD Body Gyro Jerk Mag (FDS)
    #   Gravity Acc-mean()-X (T) --> Mean Gravity Acc-X (T)
    
    tempNames <- sapply(tempNames, function(x) {
        if (grepl("-mean()", x, fixed = TRUE)) {
            x <- gsub("-mean()", "", x, fixed=TRUE)
            x <- paste("Mean", x)
        } else if (grepl("-std()", x, fixed = TRUE)) {
            x <- gsub("-std()", "", x, fixed=TRUE)
            x <- paste("SD", x)
        } else {
            x # OTherwise the rows that don't match the if or ifelse will be null
        } 
    }, simplify=TRUE, USE.NAMES = FALSE)
    
    # v. Add a space on either side of the dash
    #   SD Body Gyro Jerk Mag (FDS) --> SD Body Gyro Jerk Mag (FDS)
    #   Mean Gravity Acc-X (T) --> Mean Gravity Acc - X (T) 
    
    
    tempNames <- gsub("-", " - ", tempNames, fixed=TRUE)
    
    # vi. Set the names back to the data
    names(mainData) <- tempNames
    
    # and remove the temporary vector
    rm("tempNames")
    
    
    ##################
    # End of step 4. #
    ##################
        
    #########################################################################
    # 5. From the data set in step 4, creates a second, independent tidy    #
    #       data set with the average of each variable for each activity    # 
    #       and each subject.                                               #
    #########################################################################
    
    # For this step I chose to do the narrow representation for the tidy 
    #   dataset as you can then add more features without having to change the 
    #   schema; which would happen if each feature had it's own column. 
    
    # reshape2 is required to use the melt method.
    require(reshape2)
    
    # Create the narrow dataset by putting all the features into the two columns 
    tidyData <- melt(mainData, 
                     id=c("Subject", "Activity Number", "Activity Name"), 
                     na.rm=TRUE, variable.name = "Feature", value.name = "Value")
    
    # Aggregate the dataset so it is grouped by Subject, Activity Name, and 
    #   Feature. The mean of the Value column is also added.
    tidyData <- setNames(aggregate(tidyData$Value, 
                       by=list(tidyData$Subject, tidyData$"Activity Name", tidyData$Feature), 
                       FUN=mean, 
                       na.rm=TRUE), c("Subject", "Activity", "Feature", "Average"))
    
    # Order the tidy dataset by the first three columns 
    tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity, tidyData$Feature),]
    
    # Output the tidy data to the text file
    write.table(tidyData, "./tidyDataOutput.txt", sep="\t", row.name=FALSE)
    
    ##################
    # End of step 5. #
    ##################
}

