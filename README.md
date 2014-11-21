cleaning_data
=============

Github repository for course asignement Getting and Cleaning Data

The objective of this file is to explain the different steps in my R script
It is the first time I write such a file so please understand if my structure is atypical.
We will explain in detail each point of the asignature and how I did the work in R

First thing I did, I assign the data that I shall use in R:
      the test subjects data
      the train subjects data
      the features data with the name of each variable
      and lastly the activity labels data
each of this data is declared in R in different data frame so I can use it when needed.

Part 1: Merges the training and the test sets to create one data set.
we manipulate the diferent data sets using the cbind column to match the subject data to the measurements data 
    and to the a variable called group that indicates if the subject is in the train or test group (actually I
    initially thought that this variable will be usefull but it was not the case for this asignement).
We repeat this procedure for the test and train datasets.
afterwards we consolidate the info using the rbind instruction to have the complete data set with subjects in both
  train and test groups.


Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
This one was more tricky since I did not knew a instruction that allows me to chose the right measurements
I am lazy so making a list of the variables was out of the question, so I google a little and came up with the grep function
    to my understanding it works like a "contain" instruction. 
I use the function to find the variables that contains two values "mean()" for the average values, and "std" for the standard   deviation values) the output is number thought that correspond to the id in the list of each variable.
We bind the 2 arrays obtained with the functions and we will call it the mean-standard-array and we sort the combined array   to make sure we do not lose the correct order.
But we do have one problem because we have 3 more variable in the raw data, if we need to keep first variable N°1 this         correspond to the 4th column. Hence we need to change the combined array by adding 3 to know with colums to keep.
afterwards we can extract the info we need by subsetting only the columns that we have in the mean-standard-array +3.

Note: I did had a little problem, because the meanFreq() values are also in my subsetted data frame, I was not sure if these were meant to be in it in the assignement so I kept it but I am not sure if I should had erase this variables.


Part 3: Uses descriptive activity names to name the activities in the data set
We replace the column activity on subset1 using the value on the activity_labels array and the function match which 
  works like a VLOOKUP in EXCEL

Part 4: Appropriately labels the data set with descriptive variable names. 
we create and array using the info from the part two which will have the names of all the colums in a single row.
we use then the colnames function to assign the wanted labels

STEP N°5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each   activity and each subject.
using the subset data the first thing we need to do is to drop the group variable as it holds none value for the asignement.



  
  


