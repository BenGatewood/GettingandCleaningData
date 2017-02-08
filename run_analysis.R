library(reshape2)
library(readr)

## STEP 1 - Load and Merge the Training and Test data sets ##

# Column Names are in here:
colNames <- read.table("features.txt", 
                       header = FALSE)

# We don't need the first column of the names so drop it:
colNames <- colNames["V2"]

# Make all the variable names lower case:
colNames <- tolower(colNames$V2)

# Drop the parentheses:
colNames <- gsub("\\(|\\)", "", colNames)

# Drop the dashes:
colNames <- gsub("-", "", colNames)

# Read in all the initial data files:
testX <- read.table("X_test.txt", 
                    col.names = colNames)
trainX <- read.table("X_train.txt", 
                     col.names = colNames)
testY <- read.table("Y_test.txt")
trainY <- read.table("Y_train.txt")
test_sub <- read.table("subject_test.txt")
train_sub <- read.table("subject_train.txt")

# Set descriptive names for the activities and subjects:
names(testY) <- "activity"
names(trainY) <- "activity"
names(test_sub) <- "subject"
names(train_sub) <- "subject"

# Firstly, merge the components of each of the train and test sets:
test_set <- cbind(testX, testY, test_sub)
train_set <- cbind(trainX, trainY, train_sub)

# Then merge them into a single dataframe:
merged_set <- rbind(test_set, train_set)

## STEP 2 - Extract only the mean() and std() measurements ##

# Firstly, find the the columns which contain "mean" or "std"
# without losing our "activity" and "subject" columns:
mean_std_cols <- grepl("mean|std|^activity$|^subject$", names(merged_set))

# Now we can drop all the other columns:
merged_set <- merged_set[, mean_std_cols]

## STEP 3 and 4 - Label the data set with the descriptive activity names ##

# We'll do this by setting the "activity" variable to be a factor and 
# take advantage of the ordering of the "labels" parameter to set them to be
# the descriptive names:
merged_set$activity <- factor(merged_set$activity,
                              labels = c("Walking",
                                         "Walking Up Stairs",
                                         "Walking Down Stairs",
                                         "Sitting",
                                         "Standing",
                                         "Laying"))

## STEP 5 - Create a second, independant dataset with the average of each
## variable for each activity and subject

# Firstly, melt the merged set on "subject" and "activity":
melted_set <- melt(merged_set, id = c("subject", "activity"))

# Then dcast() the melted set via mean()
final_tidy <- dcast(melted_set, subject+activity ~ variable, mean)

# Write out the final, tidy dataset as a csv:
write.table(final_tidy, "final_tidy.txt", row.names=FALSE)



