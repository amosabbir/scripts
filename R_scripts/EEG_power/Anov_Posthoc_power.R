setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Power<-fread("Power_CANBIND2.csv")
Power<-Power[,c(1,2,3,4,5,6,7,137,138,139,140,141,143,144,145,146,147,148)]
Power<-Power[!(Power$Hemisphere=="NA"),]

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"

Power2<-Power[!(Power$EO_EC=="EC"),]
Power2<-Power2[!(Power2$Region=="na"),]

ez_outcome <- ezANOVA(
  data = Power2,
  dv = .(TCD_abs),
  wid = .(PID),
  within = .(Region,Session),
  between = .(Responder),
  type = 3)
  
  
ez_outcome <- ezANOVA(
  data = Power_asym,
  dv = .(diff),
  wid = .(PID),
  within = .(Session),
  between = .(Responder),
  type = 3)

  

#for choosing specific subsets
PowerFp1<-subset(Power2, chan==("Fp1"),select=c(PID,Session,Responder,TC_abs))

#Fp1 
PowerFp1_summary <- PowerFp1 %>% group_by(Session,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(TC_abs, na.rm = TRUE),##
    sd = sd(TC_abs, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

PowerFp1_summary$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R")
PowerFp1_summary

Power2$EFp1_EC2[which(Power2$EFp1_EC2=="1")]<-"EO"
Power2$EFp1_EC2[which(Power2$EFp1_EC2=="2")]<-"EC"


SE1_R<-PowerFp1[PowerFp1$Session=="SE1" & PowerFp1$Responder=="Responder"]
SE2_R<-PowerFp1[PowerFp1$Session=="SE2" & PowerFp1$Responder=="Responder"]
SE1_NR<-PowerFp1[PowerFp1$Session=="SE1" & PowerFp1$Responder=="Nonresponder"]
SE2_NR<-PowerFp1[PowerFp1$Session=="SE2" & PowerFp1$Responder=="Nonresponder"]


t.test(SE1_R$TC_abs, SE2_R$TC_abs, paired=T)
t.test(SE1_NR$TC_abs, SE2_NR$TC_abs, paired=T)
t.test(SE1_R$TC_abs, SE1_NR$TC_abs, paired=F)
t.test(SE2_R$TC_abs, SE2_NR$TC_abs, paired=F)




