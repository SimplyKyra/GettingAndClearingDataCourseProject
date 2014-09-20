
#################################################
# CodeBook: Run Analysis on the UCI HAR Dataset #
#################################################


Wearable Computing: Creating a tidy dataset using a Human Activity Recognition 
database built from the recordings of 30 subjects performing activities of 
daily living (ADL) while carrying a waist-mounted Samsung Galaxy S smartphone 
with embedded inertial sensors

##################################################

Raw Data: 
The raw data was taken from the files found within the 'UCI HAR Dataset' folder 
found where this CodeBook is located. It is the combination of the training and 
testing data that each contain:     
    * subject numbers (subject_train/test.txt)
    * activities the subjects do (y_train/text.txt)
    * measurements taken from the fitness devices (X_train/text.txt) 
The measurements taken from the Samsung Galaxy S smartphone has no units ad the 
information was normalized. The measurements are labelled using the 
features.txt file directly within 'UCI HAR Dataset'. The complete list of the 
variables taken from this raw information can be found in the Appendix I below. 
For a more complete description of these values you can read the 
features_info.txt file that resides in the 'UCI HAR Dataset' folder and 
describes the features.txt contents. The raw data was taken from:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##################################################

Final Data: 

There are only four columns in the resulting tidy dataset: Subject, Activity, 
Feature, and Average. These are described in detail below:

######

The ID/Number of the Subject who the recordings are for. There were 30 subjects 
performing the activities so this number ranges from 1 to 30. 

######

The name of the activity performed. The Activity Number (1 through 6) was read 
in and combined with the raw data from the test|train/y_test|train.txt file. 
This resulting column was then used to create a secondary column for the 
Activity Name. This colum was created by reading in activity_labels.txt and 
matching the activity number with the name of the activity. There were six 
activities. There raw version was: 
            1 WALKING
            2 WALKING_UPSTAIRS
            3 WALKING_DOWNSTAIRS
            4 SITTING
            5 STANDING
            6 LAYING
When the column was created the activity names were adjusted to be in lowercase 
and the underscores were replaced with spaces resulting in the final six 
possible values:     
            laying
            sitting
            standing
            walking
            walking downstairs
            walking upstairs

######
            
The final two columns (Feature and Average) come from the original data found 
in the test|train/X_test|train.txt file and whose labels were derived from the 
features.txt file. This resulted in 561 columns and 10299 rows of data. 

I proceeded to clean the data by removing any unneeded columns from the dataset 
by only keeping the columns associated with the mean or standard deviation. 
This was determined by looking at the column headers and matching the text. To 
choose how to match the headers I looked at the description of the feature 
labels found within the features_info.txt file. It 
said the following:
    mean():     Mean value
    std():      Standard deviation
    meanFreq(): Weighted average of the frequency components to obtain a mean 
    frequency
Because of this I chose to keep the columns that containing the text 'std' or 
'mean()'. I chose to keep the brackets to match the mean as I wanted to exclude 
the 'meanFreq' columns.     

I then went on to make the column headers more user friendly by renaming them. 
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

The Feature and Average columns were then created when I took this wide dataset 
(an example in Appendix II Table 1) and made it narrow (Appendix II Table 2). I 
chose to narrow it as then we could easily add more features without having to 
change the schema; which would happen if each feature had it's own column (by 
staying wide). When narrowing each feature column became a new row. The 
resulting rows were then decreased by taking the average value for each unique 
Subject, Activity, and Feature column set (example in Appendix II Table 3).

The resulting tidy dataset is then outputed: 'tidyDataOutput.txt'.    
    

##################################################    

Appendix I - References

    * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##################################################

Appendix II - Example Tables

Table 1: Example of a Wide Dataset 
Subject Activity    Feature1    Feature2    Feature3
1       laying      .2216       -.0405      -.1132
1       laying      -.9280      -.8368      -.8260
2       walking     .7055       .4458       -.8968       
    
    
Table 2: Resulting Narrowed Dataset
Subject Activity    Feature     Value
1       laying      Feature1    .2216 
1       laying      Feature2    -.0405
1       laying      Feature3    -.1132
1       laying      Feature1    -.9280
1       laying      Feature2    -.8368      
1       laying      Feature3    -.8260
2       walking     Feature1    .7055       
2       walking     Feature2    .4458       
2       walking     Feature3    -.8968 


Table 3: Resulting Narrowed Averaged Dataset
Subject Activity    Feature     Average
1       laying      Feature1    -.3532
1       laying      Feature2    -.4387
1       laying      Feature3    -.4696
2       walking     Feature1     .7055       
2       walking     Feature2    .4458       
2       walking     Feature3    -.8968 


##################################################

Appendix III - Columns in the Raw Data and Where They Were Located

test|train/subject_test|train.txt
    Subject Number
test|train/y_test|train.txt    
    Activity Number
Data from test|train/X_test|train.txt    
Labels from features_info.txt    
    tBodyAcc-mean()-X
    tBodyAcc-mean()-Y
    tBodyAcc-mean()-Z
    tBodyAcc-std()-X
    tBodyAcc-std()-Y
    tBodyAcc-std()-Z
    tBodyAcc-mad()-X
    tBodyAcc-mad()-Y
    tBodyAcc-mad()-Z
    tBodyAcc-max()-X
    tBodyAcc-max()-Y
    tBodyAcc-max()-Z
    tBodyAcc-min()-X
    tBodyAcc-min()-Y
    tBodyAcc-min()-Z
    tBodyAcc-sma()
    tBodyAcc-energy()-X
    tBodyAcc-energy()-Y
    tBodyAcc-energy()-Z
    tBodyAcc-iqr()-X
    tBodyAcc-iqr()-Y
    tBodyAcc-iqr()-Z
    tBodyAcc-entropy()-X
    tBodyAcc-entropy()-Y
    tBodyAcc-entropy()-Z
    tBodyAcc-arCoeff()-X1
    tBodyAcc-arCoeff()-X2
    tBodyAcc-arCoeff()-X3
    tBodyAcc-arCoeff()-X4
    tBodyAcc-arCoeff()-Y1
    tBodyAcc-arCoeff()-Y2
    tBodyAcc-arCoeff()-Y3
    tBodyAcc-arCoeff()-Y4
    tBodyAcc-arCoeff()-Z1
    tBodyAcc-arCoeff()-Z2
    tBodyAcc-arCoeff()-Z3
    tBodyAcc-arCoeff()-Z4
    tBodyAcc-correlation()-XY
    tBodyAcc-correlation()-XZ
    tBodyAcc-correlation()-YZ
    tGravityAcc-mean()-X
    tGravityAcc-mean()-Y
    tGravityAcc-mean()-Z
    tGravityAcc-std()-X
    tGravityAcc-std()-Y
    tGravityAcc-std()-Z
    tGravityAcc-mad()-X
    tGravityAcc-mad()-Y
    tGravityAcc-mad()-Z
    tGravityAcc-max()-X
    tGravityAcc-max()-Y
    tGravityAcc-max()-Z
    tGravityAcc-min()-X
    tGravityAcc-min()-Y
    tGravityAcc-min()-Z
    tGravityAcc-sma()
    tGravityAcc-energy()-X
    tGravityAcc-energy()-Y
    tGravityAcc-energy()-Z
    tGravityAcc-iqr()-X
    tGravityAcc-iqr()-Y
    tGravityAcc-iqr()-Z
    tGravityAcc-entropy()-X
    tGravityAcc-entropy()-Y
    tGravityAcc-entropy()-Z
    tGravityAcc-arCoeff()-X1
    tGravityAcc-arCoeff()-X2
    tGravityAcc-arCoeff()-X3
    tGravityAcc-arCoeff()-X4
    tGravityAcc-arCoeff()-Y1
    tGravityAcc-arCoeff()-Y2
    tGravityAcc-arCoeff()-Y3
    tGravityAcc-arCoeff()-Y4
    tGravityAcc-arCoeff()-Z1
    tGravityAcc-arCoeff()-Z2
    tGravityAcc-arCoeff()-Z3
    tGravityAcc-arCoeff()-Z4
    tGravityAcc-correlation()-XY
    tGravityAcc-correlation()-XZ
    tGravityAcc-correlation()-YZ
    tBodyAccJerk-mean()-X
    tBodyAccJerk-mean()-Y
    tBodyAccJerk-mean()-Z
    tBodyAccJerk-std()-X
    tBodyAccJerk-std()-Y
    tBodyAccJerk-std()-Z
    tBodyAccJerk-mad()-X
    tBodyAccJerk-mad()-Y
    tBodyAccJerk-mad()-Z
    tBodyAccJerk-max()-X
    tBodyAccJerk-max()-Y
    tBodyAccJerk-max()-Z
    tBodyAccJerk-min()-X
    tBodyAccJerk-min()-Y
    tBodyAccJerk-min()-Z
    tBodyAccJerk-sma()
    tBodyAccJerk-energy()-X
    tBodyAccJerk-energy()-Y
    tBodyAccJerk-energy()-Z
    tBodyAccJerk-iqr()-X
    tBodyAccJerk-iqr()-Y
    tBodyAccJerk-iqr()-Z
    tBodyAccJerk-entropy()-X
    tBodyAccJerk-entropy()-Y
    tBodyAccJerk-entropy()-Z
    tBodyAccJerk-arCoeff()-X1
    tBodyAccJerk-arCoeff()-X2
    tBodyAccJerk-arCoeff()-X3
    tBodyAccJerk-arCoeff()-X4
    tBodyAccJerk-arCoeff()-Y1
    tBodyAccJerk-arCoeff()-Y2
    tBodyAccJerk-arCoeff()-Y3
    tBodyAccJerk-arCoeff()-Y4
    tBodyAccJerk-arCoeff()-Z1
    tBodyAccJerk-arCoeff()-Z2
    tBodyAccJerk-arCoeff()-Z3
    tBodyAccJerk-arCoeff()-Z4
    tBodyAccJerk-correlation()-XY
    tBodyAccJerk-correlation()-XZ
    tBodyAccJerk-correlation()-YZ
    tBodyGyro-mean()-X
    tBodyGyro-mean()-Y
    tBodyGyro-mean()-Z
    tBodyGyro-std()-X
    tBodyGyro-std()-Y
    tBodyGyro-std()-Z
    tBodyGyro-mad()-X
    tBodyGyro-mad()-Y
    tBodyGyro-mad()-Z
    tBodyGyro-max()-X
    tBodyGyro-max()-Y
    tBodyGyro-max()-Z
    tBodyGyro-min()-X
    tBodyGyro-min()-Y
    tBodyGyro-min()-Z
    tBodyGyro-sma()
    tBodyGyro-energy()-X
    tBodyGyro-energy()-Y
    tBodyGyro-energy()-Z
    tBodyGyro-iqr()-X
    tBodyGyro-iqr()-Y
    tBodyGyro-iqr()-Z
    tBodyGyro-entropy()-X
    tBodyGyro-entropy()-Y
    tBodyGyro-entropy()-Z
    tBodyGyro-arCoeff()-X1
    tBodyGyro-arCoeff()-X2
    tBodyGyro-arCoeff()-X3
    tBodyGyro-arCoeff()-X4
    tBodyGyro-arCoeff()-Y1
    tBodyGyro-arCoeff()-Y2
    tBodyGyro-arCoeff()-Y3
    tBodyGyro-arCoeff()-Y4
    tBodyGyro-arCoeff()-Z1
    tBodyGyro-arCoeff()-Z2
    tBodyGyro-arCoeff()-Z3
    tBodyGyro-arCoeff()-Z4
    tBodyGyro-correlation()-XY
    tBodyGyro-correlation()-XZ
    tBodyGyro-correlation()-YZ
    tBodyGyroJerk-mean()-X
    tBodyGyroJerk-mean()-Y
    tBodyGyroJerk-mean()-Z
    tBodyGyroJerk-std()-X
    tBodyGyroJerk-std()-Y
    tBodyGyroJerk-std()-Z
    tBodyGyroJerk-mad()-X
    tBodyGyroJerk-mad()-Y
    tBodyGyroJerk-mad()-Z
    tBodyGyroJerk-max()-X
    tBodyGyroJerk-max()-Y
    tBodyGyroJerk-max()-Z
    tBodyGyroJerk-min()-X
    tBodyGyroJerk-min()-Y
    tBodyGyroJerk-min()-Z
    tBodyGyroJerk-sma()
    tBodyGyroJerk-energy()-X
    tBodyGyroJerk-energy()-Y
    tBodyGyroJerk-energy()-Z
    tBodyGyroJerk-iqr()-X
    tBodyGyroJerk-iqr()-Y
    tBodyGyroJerk-iqr()-Z
    tBodyGyroJerk-entropy()-X
    tBodyGyroJerk-entropy()-Y
    tBodyGyroJerk-entropy()-Z
    tBodyGyroJerk-arCoeff()-X1
    tBodyGyroJerk-arCoeff()-X2
    tBodyGyroJerk-arCoeff()-X3
    tBodyGyroJerk-arCoeff()-X4
    tBodyGyroJerk-arCoeff()-Y1
    tBodyGyroJerk-arCoeff()-Y2
    tBodyGyroJerk-arCoeff()-Y3
    tBodyGyroJerk-arCoeff()-Y4
    tBodyGyroJerk-arCoeff()-Z1
    tBodyGyroJerk-arCoeff()-Z2
    tBodyGyroJerk-arCoeff()-Z3
    tBodyGyroJerk-arCoeff()-Z4
    tBodyGyroJerk-correlation()-XY
    tBodyGyroJerk-correlation()-XZ
    tBodyGyroJerk-correlation()-YZ
    tBodyAccMag-mean()
    tBodyAccMag-std()
    tBodyAccMag-mad()
    tBodyAccMag-max()
    tBodyAccMag-min()
    tBodyAccMag-sma()
    tBodyAccMag-energy()
    tBodyAccMag-iqr()
    tBodyAccMag-entropy()
    tBodyAccMag-arCoeff()1
    tBodyAccMag-arCoeff()2
    tBodyAccMag-arCoeff()3
    tBodyAccMag-arCoeff()4
    tGravityAccMag-mean()
    tGravityAccMag-std()
    tGravityAccMag-mad()
    tGravityAccMag-max()
    tGravityAccMag-min()
    tGravityAccMag-sma()
    tGravityAccMag-energy()
    tGravityAccMag-iqr()
    tGravityAccMag-entropy()
    tGravityAccMag-arCoeff()1
    tGravityAccMag-arCoeff()2
    tGravityAccMag-arCoeff()3
    tGravityAccMag-arCoeff()4
    tBodyAccJerkMag-mean()
    tBodyAccJerkMag-std()
    tBodyAccJerkMag-mad()
    tBodyAccJerkMag-max()
    tBodyAccJerkMag-min()
    tBodyAccJerkMag-sma()
    tBodyAccJerkMag-energy()
    tBodyAccJerkMag-iqr()
    tBodyAccJerkMag-entropy()
    tBodyAccJerkMag-arCoeff()1
    tBodyAccJerkMag-arCoeff()2
    tBodyAccJerkMag-arCoeff()3
    tBodyAccJerkMag-arCoeff()4
    tBodyGyroMag-mean()
    tBodyGyroMag-std()
    tBodyGyroMag-mad()
    tBodyGyroMag-max()
    tBodyGyroMag-min()
    tBodyGyroMag-sma()
    tBodyGyroMag-energy()
    tBodyGyroMag-iqr()
    tBodyGyroMag-entropy()
    tBodyGyroMag-arCoeff()1
    tBodyGyroMag-arCoeff()2
    tBodyGyroMag-arCoeff()3
    tBodyGyroMag-arCoeff()4
    tBodyGyroJerkMag-mean()
    tBodyGyroJerkMag-std()
    tBodyGyroJerkMag-mad()
    tBodyGyroJerkMag-max()
    tBodyGyroJerkMag-min()
    tBodyGyroJerkMag-sma()
    tBodyGyroJerkMag-energy()
    tBodyGyroJerkMag-iqr()
    tBodyGyroJerkMag-entropy()
    tBodyGyroJerkMag-arCoeff()1
    tBodyGyroJerkMag-arCoeff()2
    tBodyGyroJerkMag-arCoeff()3
    tBodyGyroJerkMag-arCoeff()4
    fBodyAcc-mean()-X
    fBodyAcc-mean()-Y
    fBodyAcc-mean()-Z
    fBodyAcc-std()-X
    fBodyAcc-std()-Y
    fBodyAcc-std()-Z
    fBodyAcc-mad()-X
    fBodyAcc-mad()-Y
    fBodyAcc-mad()-Z
    fBodyAcc-max()-X
    fBodyAcc-max()-Y
    fBodyAcc-max()-Z
    fBodyAcc-min()-X
    fBodyAcc-min()-Y
    fBodyAcc-min()-Z
    fBodyAcc-sma()
    fBodyAcc-energy()-X
    fBodyAcc-energy()-Y
    fBodyAcc-energy()-Z
    fBodyAcc-iqr()-X
    fBodyAcc-iqr()-Y
    fBodyAcc-iqr()-Z
    fBodyAcc-entropy()-X
    fBodyAcc-entropy()-Y
    fBodyAcc-entropy()-Z
    fBodyAcc-maxInds-X
    fBodyAcc-maxInds-Y
    fBodyAcc-maxInds-Z
    fBodyAcc-meanFreq()-X
    fBodyAcc-meanFreq()-Y
    fBodyAcc-meanFreq()-Z
    fBodyAcc-skewness()-X
    fBodyAcc-kurtosis()-X
    fBodyAcc-skewness()-Y
    fBodyAcc-kurtosis()-Y
    fBodyAcc-skewness()-Z
    fBodyAcc-kurtosis()-Z
    fBodyAcc-bandsEnergy()-18
    fBodyAcc-bandsEnergy()-916
    fBodyAcc-bandsEnergy()-1724
    fBodyAcc-bandsEnergy()-2532
    fBodyAcc-bandsEnergy()-3340
    fBodyAcc-bandsEnergy()-4148
    fBodyAcc-bandsEnergy()-4956
    fBodyAcc-bandsEnergy()-5764
    fBodyAcc-bandsEnergy()-116
    fBodyAcc-bandsEnergy()-1732
    fBodyAcc-bandsEnergy()-3348
    fBodyAcc-bandsEnergy()-4964
    fBodyAcc-bandsEnergy()-124
    fBodyAcc-bandsEnergy()-2548
    fBodyAcc-bandsEnergy()-18
    fBodyAcc-bandsEnergy()-916
    fBodyAcc-bandsEnergy()-1724
    fBodyAcc-bandsEnergy()-2532
    fBodyAcc-bandsEnergy()-3340
    fBodyAcc-bandsEnergy()-4148
    fBodyAcc-bandsEnergy()-4956
    fBodyAcc-bandsEnergy()-5764
    fBodyAcc-bandsEnergy()-116
    fBodyAcc-bandsEnergy()-1732
    fBodyAcc-bandsEnergy()-3348
    fBodyAcc-bandsEnergy()-4964
    fBodyAcc-bandsEnergy()-124
    fBodyAcc-bandsEnergy()-2548
    fBodyAcc-bandsEnergy()-18
    fBodyAcc-bandsEnergy()-916
    fBodyAcc-bandsEnergy()-1724
    fBodyAcc-bandsEnergy()-2532
    fBodyAcc-bandsEnergy()-3340
    fBodyAcc-bandsEnergy()-4148
    fBodyAcc-bandsEnergy()-4956
    fBodyAcc-bandsEnergy()-5764
    fBodyAcc-bandsEnergy()-116
    fBodyAcc-bandsEnergy()-1732
    fBodyAcc-bandsEnergy()-3348
    fBodyAcc-bandsEnergy()-4964
    fBodyAcc-bandsEnergy()-124
    fBodyAcc-bandsEnergy()-2548
    fBodyAccJerk-mean()-X
    fBodyAccJerk-mean()-Y
    fBodyAccJerk-mean()-Z
    fBodyAccJerk-std()-X
    fBodyAccJerk-std()-Y
    fBodyAccJerk-std()-Z
    fBodyAccJerk-mad()-X
    fBodyAccJerk-mad()-Y
    fBodyAccJerk-mad()-Z
    fBodyAccJerk-max()-X
    fBodyAccJerk-max()-Y
    fBodyAccJerk-max()-Z
    fBodyAccJerk-min()-X
    fBodyAccJerk-min()-Y
    fBodyAccJerk-min()-Z
    fBodyAccJerk-sma()
    fBodyAccJerk-energy()-X
    fBodyAccJerk-energy()-Y
    fBodyAccJerk-energy()-Z
    fBodyAccJerk-iqr()-X
    fBodyAccJerk-iqr()-Y
    fBodyAccJerk-iqr()-Z
    fBodyAccJerk-entropy()-X
    fBodyAccJerk-entropy()-Y
    fBodyAccJerk-entropy()-Z
    fBodyAccJerk-maxInds-X
    fBodyAccJerk-maxInds-Y
    fBodyAccJerk-maxInds-Z
    fBodyAccJerk-meanFreq()-X
    fBodyAccJerk-meanFreq()-Y
    fBodyAccJerk-meanFreq()-Z
    fBodyAccJerk-skewness()-X
    fBodyAccJerk-kurtosis()-X
    fBodyAccJerk-skewness()-Y
    fBodyAccJerk-kurtosis()-Y
    fBodyAccJerk-skewness()-Z
    fBodyAccJerk-kurtosis()-Z
    fBodyAccJerk-bandsEnergy()-18
    fBodyAccJerk-bandsEnergy()-916
    fBodyAccJerk-bandsEnergy()-1724
    fBodyAccJerk-bandsEnergy()-2532
    fBodyAccJerk-bandsEnergy()-3340
    fBodyAccJerk-bandsEnergy()-4148
    fBodyAccJerk-bandsEnergy()-4956
    fBodyAccJerk-bandsEnergy()-5764
    fBodyAccJerk-bandsEnergy()-116
    fBodyAccJerk-bandsEnergy()-1732
    fBodyAccJerk-bandsEnergy()-3348
    fBodyAccJerk-bandsEnergy()-4964
    fBodyAccJerk-bandsEnergy()-124
    fBodyAccJerk-bandsEnergy()-2548
    fBodyAccJerk-bandsEnergy()-18
    fBodyAccJerk-bandsEnergy()-916
    fBodyAccJerk-bandsEnergy()-1724
    fBodyAccJerk-bandsEnergy()-2532
    fBodyAccJerk-bandsEnergy()-3340
    fBodyAccJerk-bandsEnergy()-4148
    fBodyAccJerk-bandsEnergy()-4956
    fBodyAccJerk-bandsEnergy()-5764
    fBodyAccJerk-bandsEnergy()-116
    fBodyAccJerk-bandsEnergy()-1732
    fBodyAccJerk-bandsEnergy()-3348
    fBodyAccJerk-bandsEnergy()-4964
    fBodyAccJerk-bandsEnergy()-124
    fBodyAccJerk-bandsEnergy()-2548
    fBodyAccJerk-bandsEnergy()-18
    fBodyAccJerk-bandsEnergy()-916
    fBodyAccJerk-bandsEnergy()-1724
    fBodyAccJerk-bandsEnergy()-2532
    fBodyAccJerk-bandsEnergy()-3340
    fBodyAccJerk-bandsEnergy()-4148
    fBodyAccJerk-bandsEnergy()-4956
    fBodyAccJerk-bandsEnergy()-5764
    fBodyAccJerk-bandsEnergy()-116
    fBodyAccJerk-bandsEnergy()-1732
    fBodyAccJerk-bandsEnergy()-3348
    fBodyAccJerk-bandsEnergy()-4964
    fBodyAccJerk-bandsEnergy()-124
    fBodyAccJerk-bandsEnergy()-2548
    fBodyGyro-mean()-X
    fBodyGyro-mean()-Y
    fBodyGyro-mean()-Z
    fBodyGyro-std()-X
    fBodyGyro-std()-Y
    fBodyGyro-std()-Z
    fBodyGyro-mad()-X
    fBodyGyro-mad()-Y
    fBodyGyro-mad()-Z
    fBodyGyro-max()-X
    fBodyGyro-max()-Y
    fBodyGyro-max()-Z
    fBodyGyro-min()-X
    fBodyGyro-min()-Y
    fBodyGyro-min()-Z
    fBodyGyro-sma()
    fBodyGyro-energy()-X
    fBodyGyro-energy()-Y
    fBodyGyro-energy()-Z
    fBodyGyro-iqr()-X
    fBodyGyro-iqr()-Y
    fBodyGyro-iqr()-Z
    fBodyGyro-entropy()-X
    fBodyGyro-entropy()-Y
    fBodyGyro-entropy()-Z
    fBodyGyro-maxInds-X
    fBodyGyro-maxInds-Y
    fBodyGyro-maxInds-Z
    fBodyGyro-meanFreq()-X
    fBodyGyro-meanFreq()-Y
    fBodyGyro-meanFreq()-Z
    fBodyGyro-skewness()-X
    fBodyGyro-kurtosis()-X
    fBodyGyro-skewness()-Y
    fBodyGyro-kurtosis()-Y
    fBodyGyro-skewness()-Z
    fBodyGyro-kurtosis()-Z
    fBodyGyro-bandsEnergy()-18
    fBodyGyro-bandsEnergy()-916
    fBodyGyro-bandsEnergy()-1724
    fBodyGyro-bandsEnergy()-2532
    fBodyGyro-bandsEnergy()-3340
    fBodyGyro-bandsEnergy()-4148
    fBodyGyro-bandsEnergy()-4956
    fBodyGyro-bandsEnergy()-5764
    fBodyGyro-bandsEnergy()-116
    fBodyGyro-bandsEnergy()-1732
    fBodyGyro-bandsEnergy()-3348
    fBodyGyro-bandsEnergy()-4964
    fBodyGyro-bandsEnergy()-124
    fBodyGyro-bandsEnergy()-2548
    fBodyGyro-bandsEnergy()-18
    fBodyGyro-bandsEnergy()-916
    fBodyGyro-bandsEnergy()-1724
    fBodyGyro-bandsEnergy()-2532
    fBodyGyro-bandsEnergy()-3340
    fBodyGyro-bandsEnergy()-4148
    fBodyGyro-bandsEnergy()-4956
    fBodyGyro-bandsEnergy()-5764
    fBodyGyro-bandsEnergy()-116
    fBodyGyro-bandsEnergy()-1732
    fBodyGyro-bandsEnergy()-3348
    fBodyGyro-bandsEnergy()-4964
    fBodyGyro-bandsEnergy()-124
    fBodyGyro-bandsEnergy()-2548
    fBodyGyro-bandsEnergy()-18
    fBodyGyro-bandsEnergy()-916
    fBodyGyro-bandsEnergy()-1724
    fBodyGyro-bandsEnergy()-2532
    fBodyGyro-bandsEnergy()-3340
    fBodyGyro-bandsEnergy()-4148
    fBodyGyro-bandsEnergy()-4956
    fBodyGyro-bandsEnergy()-5764
    fBodyGyro-bandsEnergy()-116
    fBodyGyro-bandsEnergy()-1732
    fBodyGyro-bandsEnergy()-3348
    fBodyGyro-bandsEnergy()-4964
    fBodyGyro-bandsEnergy()-124
    fBodyGyro-bandsEnergy()-2548
    fBodyAccMag-mean()
    fBodyAccMag-std()
    fBodyAccMag-mad()
    fBodyAccMag-max()
    fBodyAccMag-min()
    fBodyAccMag-sma()
    fBodyAccMag-energy()
    fBodyAccMag-iqr()
    fBodyAccMag-entropy()
    fBodyAccMag-maxInds
    fBodyAccMag-meanFreq()
    fBodyAccMag-skewness()
    fBodyAccMag-kurtosis()
    fBodyBodyAccJerkMag-mean()
    fBodyBodyAccJerkMag-std()
    fBodyBodyAccJerkMag-mad()
    fBodyBodyAccJerkMag-max()
    fBodyBodyAccJerkMag-min()
    fBodyBodyAccJerkMag-sma()
    fBodyBodyAccJerkMag-energy()
    fBodyBodyAccJerkMag-iqr()
    fBodyBodyAccJerkMag-entropy()
    fBodyBodyAccJerkMag-maxInds
    fBodyBodyAccJerkMag-meanFreq()
    fBodyBodyAccJerkMag-skewness()
    fBodyBodyAccJerkMag-kurtosis()
    fBodyBodyGyroMag-mean()
    fBodyBodyGyroMag-std()
    fBodyBodyGyroMag-mad()
    fBodyBodyGyroMag-max()
    fBodyBodyGyroMag-min()
    fBodyBodyGyroMag-sma()
    fBodyBodyGyroMag-energy()
    fBodyBodyGyroMag-iqr()
    fBodyBodyGyroMag-entropy()
    fBodyBodyGyroMag-maxInds
    fBodyBodyGyroMag-meanFreq()
    fBodyBodyGyroMag-skewness()
    fBodyBodyGyroMag-kurtosis()
    fBodyBodyGyroJerkMag-mean()
    fBodyBodyGyroJerkMag-std()
    fBodyBodyGyroJerkMag-mad()
    fBodyBodyGyroJerkMag-max()
    fBodyBodyGyroJerkMag-min()
    fBodyBodyGyroJerkMag-sma()
    fBodyBodyGyroJerkMag-energy()
    fBodyBodyGyroJerkMag-iqr()
    fBodyBodyGyroJerkMag-entropy()
    fBodyBodyGyroJerkMag-maxInds
    fBodyBodyGyroJerkMag-meanFreq()
    fBodyBodyGyroJerkMag-skewness()
    fBodyBodyGyroJerkMag-kurtosis()
    angle(tBodyAccMeangravity)
    angle(tBodyAccJerkMean)gravityMean)
    angle(tBodyGyroMeangravityMean)
    angle(tBodyGyroJerkMeangravityMean)
    angle(XgravityMean)
    angle(YgravityMean)
    angle(ZgravityMean)
