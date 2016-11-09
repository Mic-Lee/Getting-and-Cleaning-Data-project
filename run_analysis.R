library(data.table)
library(reshape2)
#set wd
#setwd("'Your own path'/Getting-and-Cleaning-Data-project")

#load data
path <- getwd()
path.data <- file.path(path, "UCI HAR Dataset")
list.files(path.data, recursive = TRUE)
dtSubjectTrain <- fread(file.path(path.data, "train", "subject_train.txt"))
dtSubjectTest <- fread(file.path(path.data, "test", "subject_test.txt"))
dtActivityTrain <- fread(file.path(path.data, "train", "Y_train.txt"))
dtActivityTest <- fread(file.path(path.data, "test", "Y_test.txt"))
fileToDataTable <- function(f) {
  df <- read.table(f)
  dt <- data.table(df)
}
dtTrain <- fileToDataTable(file.path(path.data, "train", "X_train.txt"))
dtTest <- fileToDataTable(file.path(path.data, "test", "X_test.txt"))

#Merge data sets
dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)
dtSubject <- cbind(dtSubject, dtActivity)
dt <- cbind(dtSubject, dt)
setkey(dt, subject, activityNum)

#Extact mean and std
dtFeatures <- fread(file.path(path.data, "features.txt"))
setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))
dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]
dtFeatures$featureCode <- dtFeatures[, paste0("V", featureNum)]
head(dtFeatures)
dtFeatures$featureCode
select <- c(key(dt), dtFeatures$featureCode)
dt <- dt[, select, with = FALSE]

#use descriptive names
dtActivityNames <- fread(file.path(path.data, "activity_labels.txt"))
setnames(dtActivityNames, names(dtActivityNames), c("activityNum", "activityName"))
dt <- merge(dt, dtActivityNames, by = "activityNum", all.x = TRUE)
setkey(dt, subject, activityNum, activityName)
dt <- data.table(melt(dt, key(dt), variable.name = "featureCode"))
dt <- merge(dt, dtFeatures[, list(featureNum, featureCode, featureName)], by = "featureCode",all.x = TRUE)
dt$activity <- factor(dt$activityName)
dt$feature <- factor(dt$featureName)

#seperate features
grepthis <- function(regex) {
  grepl(regex, dt$feature)
}
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(grepthis("^t"), grepthis("^f")), ncol = nrow(y))
dt$featDomain <- factor(x %*% y, labels = c("Time", "Freq"))
x <- matrix(c(grepthis("Acc"), grepthis("Gyro")), ncol = nrow(y))
dt$featInstrument <- factor(x %*% y, labels = c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepthis("BodyAcc"), grepthis("GravityAcc")), ncol = nrow(y))
dt$featAcceleration <- factor(x %*% y, labels = c(NA, "Body", "Gravity"))
x <- matrix(c(grepthis("mean()"), grepthis("std()")), ncol = nrow(y))
dt$featVariable <- factor(x %*% y, labels = c("Mean", "SD"))
## Features with 1 category
dt$featJerk <- factor(grepthis("Jerk"), labels = c(NA, "Jerk"))
dt$featMagnitude <- factor(grepthis("Mag"), labels = c(NA, "Magnitude"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(grepthis("-X"), grepthis("-Y"), grepthis("-Z")), ncol = nrow(y))
dt$featAxis <- factor(x %*% y, labels = c(NA, "X", "Y", "Z"))

#Create a tidy data set
setkey(dt, subject, activity, featDomain, featAcceleration, featInstrument,featJerk, featMagnitude, featVariable, featAxis)
dtTidy <- dt[, list(count = .N, average = mean(value)), by = key(dt)]

#save tha data set
f <- file.path(path, "GCD-Project-Dataset.txt")
write.table(dtTidy, f, quote = FALSE, sep = "\t", row.names = FALSE)
