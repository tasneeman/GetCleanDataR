Accelerometer

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Approach:

Using "reshape2" package: Please note that code file Run_Analysis.R has step wise comments 

#1 Reading test and train MEASURES and merging since we need to have merged values.
#2 Read features which is described in the features_info.txt which can be downloaded from above locations.
   This feature is each row in the train and test data set.
#3 Read activity values in a dataset(dsAct) and labels in other dataset i.e. WALKING, STANDING etc. and associate/link by merging based on activity

#4 Read Subject data set (dsSub.); Link Activity data set got in step 3. since data is organized as each subject performs activitites in a window. This is direct association so bind them with column bind.
#5 Assign colnames to merged train and test MEASURES (dsTestTrain)
#6 Complete the by association od  subject-activities -measures [dsTestTrain <- cbind(dsSubjAct, dsTestTrain)]
#7 Link complete by associating subject-activities - measures
#8 filter columns related to Mean and STD measure only
#9 melt all variables except subject and activities to perform group operations.
#10 perform mean on measures by grouping activity and subject.
#11 Rename some of the columns for better reading 
#12 Save the final Tidy Data set.
