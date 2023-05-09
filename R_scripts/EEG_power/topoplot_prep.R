setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)


Power<-fread("Power_CANBIND2.csv")
#Power<-subset(Power, chan==("O1"),select=c(PID,Session,Responder,chan,EO_EC,theta_cord))

#for choosing specific subsets
Power<-subset(Power, EO_EC==("EO"))

#O1 baseline
#Power<-subset(Power,Session=="1",select=c(PID,EO_EC,Session,Responder,theta_cord))
Power_SE1<-subset(Power,Session=="1")
Power_SE2<-subset(Power,Session=="2")

Power_SE1$theta_cord2<-Power_SE2$theta_cord
Power_SE1$diff<-Power_SE1$theta_cord2-Power_SE1$theta_cord


Power_SE1_R<-subset(Power_SE1, Responder==("Responder"),select=c(PID,EO_EC,Session,Responder,chan,diff))
Power_SE1_NR<-subset(Power_SE1, Responder==("Nonresponder"),select=c(PID,EO_EC,Session,Responder,chan,diff))
Power_SE1_R<-summaryBy (diff ~ chan, data=Power_SE1_R, FUN=c(length,mean,sd))
Power_SE1_NR<-summaryBy (diff ~ chan, data=Power_SE1_NR, FUN=c(length,mean,sd))

write.csv(Power_SE1_R$diff.mean,"theta_corddiff_O1_R.csv")
write.csv(Power_SE1_NR$diff.mean,"theta_corddiff_O1_NR.csv")



