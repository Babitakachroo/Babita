## create variables in R, vector (<- assignment operator)
x<-25
x
x<-c(2,3,4,5)
y<-c(5,6,7,8)
z<-c("a","b","c","d")
## data frame 2 dimentional array (rows/columns)
df<-data.frame(x,y,z)
df
dim(df)
## add a new column
df$sum<-df$x+df$y
df$v<-c(6,7,8,9)
df
max(df$x)
min(df$y)
mean(df$x)
length(df$x)
unique(df$z)
df1<-edit(df)
df1
## remove a column
df$z<-NULL
df
## import csv file in R (basic_salary2.csv)
## set working directory
setwd
data<-read.csv("C:/Users/Babita/Desktop/DSI/DM  Datasets/basic_salary - 2.csv")
data
data1<-read.csv(file.choose())
head(data1) ## first 6 records of dataframe
tail(data1)
dim(data1)
summary(data1)
summary(data1$ba)
unique(data1$Location)
unique(data1$Grade)
## check for missing values (NA)
is.na(data1$ba)
sum(is.na(data1$ba))
sum(is.na(data1$ms))
mean(data1$ba, na.rm=TRUE)
mean(data1$ms)
mean(data1$ms,na.rm=TRUE)

## delete observations having NA
data2<-na.omit(data1)
dim(data2)
sum(is.na(data2$ms))

## create subset using indexing
subset_1<-data2[3:7,]
subset_1
subset_1<-data2[c(2,3,5,6),c(1,3,4,5)]

## subset using subset() function
subset_2<-subset(data2,Grade=="GR2" & Location=="MUMBAI")
subset_2
subset_3<-subset(data2,select=c(Grade,ba))
subset_3
subset_4<-subset(data2,Grade=="GR1"& ba>20000,select=c(Grade,ba,Location))
subset_4
sub1<-subset(data2,ba>=20000 & ba<=25000)
sub1

## data sorting
## by default it will sort in ascending order
names(data2) ## returns the column labels
attach(data2)
sort1<-data2[order(-ba,Grade),]
head(sort1)
sort2<-data2[order(ms),]
sort3<-data2[order(-ba),]
head(sort3)


## Merging sal_data (A) and bonus_data (B)
## left join, right join, outer join, inner join
sal_data<-read.csv(file.choose())
bonus_data<-read.csv(file.choose())
head(sal_data)
head(bonus_data)
leftjoin<-merge(sal_data,bonus_data,by=c("Employee_ID"),all.x=TRUE)
head(leftjoin)
rightjoin<-merge(sal_data,bonus_data,by=c("Employee_ID"),all.y=TRUE)
head(rightjoin)
outerjoin<-merge(sal_data,bonus_data,by=c("Employee_ID"),all=TRUE)
head(outerjoin)
innerjoin<-merge(sal_data,bonus_data,by=c("Employee_ID"))
head(innerjoin)

## dplyr package
install.packages("dplyr")
library(dplyr)
innerjoin1<-inner_join(sal_data,bonus_data,by=c("Employee_ID"))
head(innerjoin1)
## full_join, left_join, right_join,semi_join, anti_join
rightjoin1<-right_join(sal_data,bonus_data,by=c("Employee_ID"))
head(rightjoin1)
semijoin<-semi_join(sal_data,bonus_data,by=c("Employee_ID"))
head(semijoin)
antijoin<-anti_join(sal_data,bonus_data,by=c("Employee_ID"))
head(antijoin)

## aggregate function of Base R
agg1<-aggregate(ba~Location,data=data2,FUN=mean)
agg1
agg2<-aggregate(ba~Location+Grade,data=data2,FUN=mean)
agg2
## cbind - column bind
agg3<-aggregate(cbind(ba,ms)~Location,data=data2,FUN=sum)
agg3

## aggregation using dplyr package
loc<-group_by(data2,Location)
dplyr_agg<-summarize(loc,sum_ms=sum(ms,na.rm=TRUE))
dplyr_agg

## aggregate function from the package data.table
install.packages("data.table")
library(data.table)
data2_DT<-data.table(data2)
setkey(data2_DT,Location)
DT_agg<-data2_DT[,.(sum_ms=sum(ms,na.rm=TRUE)),by=Location]
DT_agg
