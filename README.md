
# README: Run Analysis on the UCI HAR Dataset 

The only script required is the run_analysis.R file that should be located in 
the same directory as this README. To run the script the 'UCI HAR Dataset' 
folder must also be in this directory so the script can access the data files 
within the 'UCI HAR Dataset' folder structure. If you don't already have the 
data it can be downloaded and unzipped from:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Though the run_analysis.R file has to be in the same folder as 'UCI HAR 
Dataset' to run the script you can source the file and run the method from 
another location if you prefer: 
    source("YourDirectoryStructure/run_analysis.R")
    run_analysis()
    
The output of this function will be the narrow, tidy representation of the data 
found in the 'UCI HAR Dataset' folder. I chose to do the narrow representation 
of the tidy dataset as you can then add more features, if needed, without 
having to change the schema; which would happen if each feature had it's own 
column (was a wide representation). This outputted file is named 
'tidyDataOutput.txt' and will be added to the same directory you have the 
run_analysis.R file in. You can read the text file into R with the following 
code:
    importedData <- read.table("./tidyDataOutput.txt", header=TRUE, sep="\t")

Note the run_analysis method uses 'reshape2' so it is require'd during 
execution.

# Overview of run_analysis 

The run_analysis method starts by assemblying the information needed to create 
the starting main dataset. It starts by reading in all the testing information, 
combining it into a testing dataset (cbind), then reading in the training 
information, combining that into a training dataset (cbind), and then finally 
combining the two datasets, via the rbind, into one dataset. 

To do this it reads in the main information from the test/train x_test/train.txt 
and then names the columns in the resulting dataset with the information 
contained in the features.txt file found in the main directory. 

It then grabs the activity column, from the test/train y_test/train.txt, and 
adds a seconds column (Activity Name) by reading in the activity_labels.txt 
file in the main directory and matching the names with the activity numbers. 
This results in a two column dataset containing Activity Numbers and Activity 
Names. 

Finally the subject numbers are read in via test/train subject_test/train.txt.

These three dataset are combinined using the cbind method to create the entire 
testing dataframe. This process is repeated for the training data and then the 
testing and training data are combined (using rbind) to create the dataframe 
containing all the raw data. This was called mainData.

As any objects are no longer required they are removed from the environment.

This completes step 1 and 3 from the assignment directives. 

######################################################################

We then extract only the Subject Number and Activity Name columns along with 
the mean and standard deviation columns from the main data and discard all the 
other columns (step 2).

The columns chosen for the mean and standard deviation requirements were 
determined using the descriptions found within the features_info.txt file. It 
said the following:
    mean():     Mean value
    std():      Standard deviation
    meanFreq(): Weighted average of the frequency components to obtain a mean 
    frequency
Thus it was determined to only match the columns containing the text 'std' or 
'mean()'. The brackets are used to match the mean as we want to exclude the 
'meanFreq' columns. 

######################################################################

After we removed the columns that were no longer needed for the tidy dataset 
the run_analysis method goes on to appropriately label the remaining columns 
with descriptive variable names (step 4).

The original column names, found in features.txt, use two prefixs: t and f. 
The 't' prefix is for time and the 'f' prefix is for the Frequency Domain 
Signals. I chose to abbreviate these to "T" and "FDS" respectfully:
        t = Time = T
        f = Frequency Domain Signals = FDS
I am also choosing to abbreviate the standard deviation to SD so the column 
headings don't get too large: 
        http://www.allacronyms.com/standard_deviation/abbreviated
    
I want this code to make the column headings more descriptive. If there is no 
X, Y, or Z at the end of the heading then it will go straight from main heading 
to the T/F abbreviation without the dash. Also any repetitive words (side by 
side) were removed; as this only occurs with 'BodyBody' it can be hardcoded. 
Additionally, we want to seperate our user defined columns at the capitals. 
Specifically these points are shown through these examples:
        tGravityAcc-mean()-X --> Mean Gravity Acc - X (T) 
        fBodyAcc-mean()-Z --> Mean Body Acc - Z (FDS) 
        tBodyAccJerkMag-std()-Z --> SD Body Acc Jerk - Z (T) 
        fBodyBodyGyroJerkMag-std() --> SD Body Gyro Jerk Mag (FDS)
        ActivityName --> Activity Name
    
The code removes the repetitive words and seperates the words at the capitals 
by running two different global replacements (gsub):
        gsub("BodyBody", "Body", names(mainData), fixed=FALSE)
        gsub("([a-z])([A-Z])", "\\1 \\2", tempNames, fixed=FALSE)
It then goes on to check if the column header starts with a 't' or an 'f'. If 
it starts with a 't' it removes the prefix (gsub) and adds "(T)" to the end of 
the header (paste); if it starts with an 'f' it removes it (gsub) and adds 
"(FDS)" to to the end of the header (paste). If it starts with neither prefix 
it leaves it as is. The '-mean()' and '-std()' text replacements are done 
similarly. If matched it removes the text using the global replacement (gsub) 
and then adds the specific text to the beginning of the column header (using 
paste). If '-mean()' was matched it adds "Mean" to the string and if '-std()' 
was matched it adds "SD" to the string instead. Finally, a space is added to 
either side of any dashes preset (gsub) so it looks more presentable.

The final resulting names are then used to overwrite the column headings for 
the main dataset and the storage vector that was used to hold them is removed.     
    
######################################################################
    
Finally a second, independent tidy data set with the average of each variable 
for each activity and each subject is created (step 5). For this step I chose 
to do the narrow representation for the tidy dataset as you can then add more 
features without having to change the schema; which would happen if each 
feature had it's own column. 
    
I created the narrow dataset by conbining all feature columns into two columns: 
Feature (name) and the value (melt). I then proceeded by aggregating the 
information so each unique subject/activity/feature combination would have only
one row showing the mean value. The final resulting data was then sorted by 
Subject, Activity, and then finally the Feature. The resulting tidy dataset is 
then outputed, to the folder run_analysis.R resides in, as 'tidyDataOutput.txt'.


##############
# References #
##############
 * https://class.coursera.org/getdata-007/forum/thread?thread_id=142
 * https://class.coursera.org/getdata-007/forum/thread?thread_id=214
  
 