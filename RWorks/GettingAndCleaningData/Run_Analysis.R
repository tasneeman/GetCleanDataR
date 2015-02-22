library("reshape2")
#Step : 1 Reading test and train measures and merging.
dsTestTrain <- rbind(read.table("./data/test/X_test.txt",header=F),read.table("./data/train/X_train.txt",header=F));
# 2: Read features
dsFeaturs <- read.table("./data/features.txt");
# 3: Read Activities for test and train 
dsAct <- rbind(read.table("./data/test/y_test.txt", header=F),read.table("./data/train/y_train.txt", header=F))
# 4: Read activity labels 
activityNames <-  read.table("./data/activity_labels.txt", header=FALSE, col.names=c("Activity", "ActivityName"))
colnames(dsAct) <- "Activity"
# 5: joining/merging to associate Activity descriptive names to numeric value
dsAct <- merge(dsAct,activityNames)
# 6: Read subjects for test and train
dsSubj <- rbind(read.table("./data/test/subject_test.txt", header=F),read.table("./data/train/subject_train.txt", header=F))
colnames(dsSubj) <- "Subject"
# 7: As each subject performs set of activities for give window, link them using cbind() : please notice row counts are same: nrow(dsSubj) and nrow(dsAct)
dsSubjAct <- cbind(dsSubj,dsAct)
# 8: Assign colnames to merged train and test measures
names(dsTestTrain) <- dsFeaturs$V2;
# 9: Link complete by associating subject-activities - measures
dsTestTrain <- cbind(dsSubjAct, dsTestTrain)
# filter columns below
selectedCols <- append(c("Subject", "ActivityName"),as.character(dsFeaturs$V2[grepl(".*mean\\(\\)|.*std\\(\\)", dsFeaturs$V2)]));
tidyDS <- dsTestTrain[, selectedCols];
# 10: Now, melt all variables except subject and activities to perform group operations using dcast. 
meltedDS <-melt(tidyDS, id=c("Subject", "ActivityName"), measure.var=selectedCols[3:length(selectedCols)])
# perform mean on measures by grouping activity and subject.
tidyDS <- dcast(meltedDS, ActivityName + Subject ~ variable, mean)
# 11: Rename columns
selectedCols <- gsub('-mean',"-Mean", gsub('-std',"-Std", gsub('\\(|\\)',"", selectedCols)))
colnames(tidyDS) <- selectedCols
# 12: store tidy dataset
write.table(tidyDS, "finalActivity.txt")