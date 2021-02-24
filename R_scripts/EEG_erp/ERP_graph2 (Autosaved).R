setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Anhedonia_erp")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)


for (i in 1:8) {

data<-fread("PO7_data.csv")
data<-subset(data,data$Value=="Mean")
data<-subset(data,data$I1_NI2=="Incentive")

data_1<-data[i,]
library(tidyr)
data_1long<-gather(data_1,timepoint,value,V1:V3072, factor_key=T)
data_1long$time<-1:3072
data_1long$time<-((data_1long$time/512)-1)*1000
data_1long<-data_1long[c(409:2048),]
data_1[,c(1,2,3,4,5,6)]

#p3<-ggplot(data_1long, aes(time, value, group=factor(Responder))) + geom_line(aes(color=factor(Responder)))+ scale_x_continuous(breaks=c(-200,-100,0,100,200,300,400,500,600,700))
#ggsave("Linegraph.png", width=8, height=6,dpi=300)

Fname <- paste(data$Responder[i], data$I1_NI2[i], data$SE1_SE2[i], data$Channel[i], sep ="_")
Filename<-paste(Fname, ".png", sep ="")

p3<-ggplot(data1, aes(time, value, group=factor(Responder))) +
  geom_line(aes(y = value), color = "darkred") + 
  geom_line(aes(y = value2), color="steelblue", linetype="twodash") +
  scale_colour_grey(start=0.2, end=0.9) +
  ylim(-4,4)+
  labs(x="Time (ms)", y = "Amplitude")+
scale_x_continuous(breaks=c(-200,-100,0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000))+
  theme_classic(base_size=10)+ 
  geom_vline(xintercept=c(0), linetype='dashed')+
  ggtitle("PO7 R before vs. after")+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  ggsave("PO7_R_SE12.png", width=8, height=6,dpi=300)
  
 }
 
 
 
 
 ggplot(data1, aes(x=time)) + 
  geom_line(aes(y = value), color = "darkred") + 
  geom_line(aes(y = value2), color="steelblue", linetype="twodash") 
