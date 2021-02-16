setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Anhedonia/Excel_output/SE2")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

result<-data.frame(matrix(ncol=2, nrow=52))
cname<-c("Part_Num","Reaction_Time")
colnames(result)<-cname

for(j in 1:20){
	sprintf("%s.xls", j)
	print(sprintf("%s.xls", j))
	data<-fread(sprintf("%s.xls", j))
 

for(i in 1:52){
	
	datasub<-subset(data, data$epoch==i)
	datasub
	if (52 %in% datasub$type) {
	a<-with(datasub, latency[type==52]) - with(datasub, latency[type==7])
	result[((j-1)*52)+i,2]<-a
	result[((j-1)*52)+i,1]<-j
	#} else if (14 %in% datasub$type) {
	#a<-with(datasub, latency[type==14]) - with(datasub, latency[type==7])
	#result[((j-1)*52)+i,2]<-a
	#result[((j-1)*52)+i,1]<-j
	} else {
	result[((j-1)*52)+i,2]<-"NA"
	result[((j-1)*52)+i,1]<-j
	}
#print(i)
}
	
	
	
}

write.csv(result, "Results_Incentive.csv")

