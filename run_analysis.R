if(!require(plyr)){  
    install.packages("plyr")
}
library(plyr)

#----------------------------------------------------------------------------
# 1. Load & Merges the training and the test sets to create one data set.
#----------------------------------------------------------------------------
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/Y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/Y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# merge both test and training data
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)

colnames(y_all) <- c("activity")
colnames(subject_all) <- c("subject")

#----------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#----------------------------------------------------------------------------

#name all x columns with appropriate names
features <- read.table(file = "features.txt")
names(x_all) <- features[,2]

#extract mean() and std() columns, 
mean_and_std <- grep("\\-(mean|std)\\(\\)", features[,2])

#subset and name them from X data
x_all <- x_all[,mean_and_std]

#----------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
#----------------------------------------------------------------------------

# Use descriptive activities in the dataset
activity_labels <- read.table(file = "activity_labels.txt")
y_all[,1] <- activity_labels[y_all[,1],2]


#----------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names.
#----------------------------------------------------------------------------

# Bind all the rest
everything <- cbind(x_all, y_all, subject_all)

#----------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#----------------------------------------------------------------------------

# apply ddply and column-wise + means function for Activity and Subject, numcolwise()
tidy_data_mean <- ddply(everything, c("activity","subject"), numcolwise(mean))
write.table(tidy_data_mean, file = "activity_final_data.txt", row.names = FALSE)
