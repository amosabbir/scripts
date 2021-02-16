setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Anhedonia/Event_output")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

df_N2<-data.frame(1,1,1,1,1,1)
names(df_N2)<-c("Num","RT","Epoch","I1_NI2","Part_Num","Session")
dat<-fread("NI_SE2.csv")

for(j in 1:20){
print(j)
for(i in 1:52) {
  i_sub<-subset(dat,epoch==i & Part_Num==j)
  if (52 %in% i_sub$type) {
a<-subset(i_sub,type==7 & epoch==i)
b<-subset(i_sub,type==52 & epoch==i)
dat_fra<-data.frame(a$number,b$latency-a$latency,a$epoch,a$I1_NI2,a$Part_Num,a$Session)
names(dat_fra)<-c("Num","RT","Epoch","I1_NI2","Part_Num","Session")
df_N2<-rbind(df_N2,dat_fra)
}

}
}

df_N2<-df_N2[!(df_N2$RT==1),]
df_N2$RT<-(df_N2$RT/512)*1000

total$Responder<-rep(1,nrow(total))

total$Responder <- ifelse(total$Part_Num == c(1,3,5,9,13,15,20),"R","NR")

total$Responder <- ifelse(total$Part_Num == 1,"R",
	ifelse(total$Part_Num == 3,"R",
	ifelse(total$Part_Num == 5,"R",
	ifelse(total$Part_Num == 9,"R",
	ifelse(total$Part_Num == 13,"R",
	ifelse(total$Part_Num == 15,"R",
	ifelse(total$Part_Num == 20,"R",
	"NR")))))))



total$Session <- ifelse(total$Session == 1,"SE1","SE2")
	


