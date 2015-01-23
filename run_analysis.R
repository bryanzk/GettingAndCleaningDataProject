library(reshape2)
library(plyr)

features = read.table("features.txt")
activities = read.table("activity_labels.txt")
activities <- rename(activities, c(V1="activity", V2="activity_name"))
activities$activity <- factor(activities$activity)




# read test data
x_test = read.table("./test/X_test.txt")
colnames(x_test)  <- features[,2]
y_test = read.table("./test/y_test.txt")
y_test <- rename(y_test, c(V1="activity"))
subject_test = read.table("./test/subject_test.txt")
subject_test <- rename(subject_test, c(V1="subject"))
test_data <-cbind(subject_test, cbind(y_test, x_test))

# read train data
x_train = read.table("./train/X_train.txt")
colnames(x_train)  <- features[,2]
y_train = read.table("./train/y_train.txt")
y_train <- rename(y_train, c(V1="activity"))
subject_train = read.table("./train/subject_train.txt")
subject_train <- rename(subject_train, c(V1="subject"))
train_data <-cbind(subject_train, cbind(y_train, x_train))

# combind test and train data
all_data <- rbind(test_data, train_data)

# factor the subject and activity
all_data$subject <- factor(all_data$subject)
all_data$activity <- factor(all_data$activity)

mean_features = features[grep("mean\\(\\)", features$V2),]
std_features = features[grep("std\\(\\)", features$V2),]

result_features <- rbind(mean_features, std_features)

# get the result data
resultMelt <- melt(all_data, id=c("subject", "activity"), measure.vars=result_features[,2] )

rd = arrange(join(resultMelt, activities), activity)
rd$activity <- NULL
rd <- rename(rd, c(variable="signal_feature", value="signal_measurement"))
rd <- rd[,c(1,4,2,3)]

newds <- dcast(rd, subject+activity_name ~ signal_feature, mean)
write.table(newds,file="newmean.txt", row.names=FALSE)

