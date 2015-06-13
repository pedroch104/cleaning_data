
##setting the directories
mother<-"~/UCI HAR Dataset"
train<-"~/UCI HAR Dataset/train"
test<-"~/UCI HAR Dataset/test"

##getting raw tables 
setwd(test)
subject_test <- read.table("./subject_test.txt")
X_test <- read.table("./X_test.txt")
Y_test <- read.table("./Y_test.txt")

setwd(train)
subject_train <- read.table("./subject_train.txt")
X_train <- read.table("./X_train.txt")
Y_train <- read.table("./Y_train.txt")

setwd(mother)
features<-read.table("./features.txt")
activity_labels<-read.table("./activity_labels.txt")

library(dplyr)
library(reshape2)

##STEP N°1: 
##Merging the training and the test sets to create one data set.
test<-cbind(subject=subject_test,activity=Y_test,group="test",X_test)
train<-cbind(subject=subject_train,activity=Y_train,group="train",X_train)
##naming the raw data
raw_data<-rbind(train,test)
names(raw_data)[1]<-paste("subject")
names(raw_data)[2]<-paste("activity")


##STEP N°2: 
##Extracts only the measurements on the mean and standard deviation
## for each measurement. 
keep<-as.matrix(features[,2],ncol = 1) ## keep is a matrix with the labels for 
						   ## each variable
keepmean<-grep("mean()", keep)
keepstd<-grep("std", keep)		   ## we apply the function grep to know which 
						   ## are the colums that we want to keep 
keepall<-c(keepstd,keepmean)		   
keepall<-sort(keepall)				   ## binding and sorting with the numbers of 
						   ## colums that we want to extract
keep<-keep[keepall]			   ## we extract also the labels for the colums
						   ## in the right order
extract<-keepall+3			   ## we have 3 colums (subject, category and 
						   ## group)in our raw data so we need to add +3
##extracting the measurement of mean and std for each mesurement
subset1<-raw_data[,c(1:3,extract)]



##STEP N°3: 
##Uses descriptive activity names to name the activities in the data set
##We replace the column activity on subset1 using the value on the activity_labels array
##Works like a VLOOKUP in EXCEL
subset1$activity<-activity_labels$V2[match(subset1$activity,activity_labels$V1)]



##STEP N°4:
##Appropriately labels the data set with descriptive variable names.
##we will use the keep array which holds the labels of the 79 columns that we want
label<-c("subject","activity","group",keep)  ##vector with all the labels
colnames(subset1)<-label 



##STEP N°5:
##From the data set in step 4, creates a second, independent tidy data set with 
##the average of each variable for each activity and each subject.

##merge the data by subject and activity
subset2<-subset1
subset2$group<-NULL			##drop variable group
subset2 <- melt(subset2, id=c("subject","activity"))

##we use the tapply to calculate the mean for all groups and sub categorys (variable,
## activity and subject)
data_try<-tapply(subset2$value, list(subset2$subject,subset2$activity,subset2$variable), mean)
data_tidy<-melt(data_try) ##have to melt the data_try to make it readable

##adding labels
final_label<-c("Subject","Activity","Variable","Mean") ##label for my final output
colnames(data_tidy)<-final_label
final_label



