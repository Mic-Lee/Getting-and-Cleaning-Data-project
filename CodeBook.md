CodeBook
---------------
//Sometimes this file will show some encoding error, please open the raw file to take a insight
Show all details of the data set
---------------------------------

> str(dtTidy)
Classes ¡®data.table¡¯ and 'data.frame':	11880 obs. of  11 variables:
 $ subject         : int  1 1 1 1 1 1 1 1 1 1 ...
 $ activity        : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ featDomain      : Factor w/ 2 levels "Time","Freq": 1 1 1 1 1 1 1 1 1 1 ...
 $ featAcceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
 $ featInstrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...
 $ featJerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ...
 $ featMagnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ...
 $ featVariable    : Factor w/ 2 levels "Mean","SD": 1 1 1 2 2 2 1 2 1 1 ...
 $ featAxis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ...
 $ count           : int  50 50 50 50 50 50 50 50 50 50 ...
 $ average         : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ...
 - attr(*, "sorted")= chr  "subject" "activity" "featDomain" "featAcceleration" ...
 - attr(*, ".internal.selfref")=<externalptr> 

Descriptions of variables
----------------------------

 $ subject         : A group of 30 volunteers within an age bracket of 19-48 years
 $ activity        : The name of a activity
 $ featDomain      : Feature: Time domain signal or frequency domain signal (Time or Freq)
 $ featAcceleration: Feature: Acceleration signal (Body or Gravity)
 $ featInstrument  : Feature: Measuring instrument (Accelerometer or Gyroscope)
 $ featJerk        : Feature: Jerk signa
 $ featMagnitude   : Feature: Magnitude of the signals calculated using the Euclidean norm
 $ featVariable    : Feature: Variable (Mean or SD)
 $ featAxis        : Feature: 3-axial signals in the X, Y and Z directions (X, Y, or Z)
 $ count           : Feature: Count of data points used to compute average
 $ average 	   : Feature: Average of each variable for each activity and each subject

Summary
---------

> summary(dtTidy)
    subject                   activity    featDomain  featAcceleration
 Min.   : 1.0   LAYING            :1980   Time:7200   NA     :4680    
 1st Qu.: 8.0   SITTING           :1980   Freq:4680   Body   :5760    
 Median :15.5   STANDING          :1980               Gravity:1440    
 Mean   :15.5   WALKING           :1980                               
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                               
 Max.   :30.0   WALKING_UPSTAIRS  :1980                               
       featInstrument featJerk      featMagnitude  featVariable featAxis 
 Accelerometer:7200   NA  :7200   NA       :8640   Mean:5940    NA:3240  
 Gyroscope    :4680   Jerk:4680   Magnitude:3240   SD  :5940    X :2880  
                                                                Y :2880  
                                                                Z :2880  
                                                                         
                                                                         
     count          average        
 Min.   :36.00   Min.   :-0.99767  
 1st Qu.:49.00   1st Qu.:-0.96205  
 Median :54.50   Median :-0.46989  
 Mean   :57.22   Mean   :-0.48436  
 3rd Qu.:63.25   3rd Qu.:-0.07836  
 Max.   :95.00   Max.   : 0.97451 


All info about tables in the working directory
-----------------------------------------------

> tables()
      NAME               NROW NCOL MB
 [1,] dt              679,734   16 52
 [2,] dtActivity       10,299    1  1
 [3,] dtActivityNames       6    2  1
 [4,] dtActivityTest    2,947    1  1
 [5,] dtActivityTrain   7,352    1  1
 [6,] dtFeatures           66    3  1
 [7,] dtSubject        10,299    2  1
 [8,] dtSubjectTest     2,947    1  1
 [9,] dtSubjectTrain    7,352    1  1
[10,] dtTest            2,947  561 13
[11,] dtTidy           11,880   11  1
[12,] dtTrain           7,352  561 32
      COLS                                                                            
 [1,] featureCode,subject,activityNum,activityName,value,featureNum,featureName,activi
 [2,] activityNum                                                                     
 [3,] activityNum,activityName                                                        
 [4,] V1                                                                              
 [5,] V1                                                                              
 [6,] featureNum,featureName,featureCode                                              
 [7,] subject,activityNum                                                             
 [8,] V1                                                                              
 [9,] V1                                                                              
[10,] V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,V11,V12,V13,V14,V15,V16,V17,V18,V19,V20,V21,V22,V
[11,] subject,activity,featDomain,featAcceleration,featInstrument,featJerk,featMagnitu
[12,] V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,V11,V12,V13,V14,V15,V16,V17,V18,V19,V20,V21,V22,V
      KEY                                                                             
 [1,] subject,activity,featDomain,featAcceleration,featInstrument,featJerk,featMagnitu
 [2,]                                                                                 
 [3,]                                                                                 
 [4,]                                                                                 
 [5,]                                                                                 
 [6,]                                                                                 
 [7,]                                                                                 
 [8,]                                                                                 
 [9,]                                                                                 
[10,]                                                                                 
[11,] subject,activity,featDomain,featAcceleration,featInstrument,featJerk,featMagnitu
[12,]                                                                                 
Total: 106MB
