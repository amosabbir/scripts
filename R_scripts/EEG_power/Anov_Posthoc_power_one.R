setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Power<-fread("Power_CANBIND2.csv")
Power<-Power[,c(1,2,3,4,5,6,7,8,136,137,138,139,140,141,142,143,144,145,146,147,148,149,151,152)]
#Power<-Power[!(Power$Hemisphere=="NA"),]

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"

Power2<-Power2[!(Power2$EO_EC=="EC"),]
Power2<-Power[!(Power$Region=="na"),]

ez_outcome <- ezANOVA(
  data = Power2,
  dv = .(beta),
  wid = .(PID),
  within = .(Region,Session),
  between_covariates = .(MADRS_PI),
  #between = .(EO_EC),
  type = 3)
  
  
ez_outcome <- ezANOVA(
  data = Power_asym,
  dv = .(diff),
  wid = .(PID),
  within = .(Session),
  between = .(EO_EC),
  type = 3)

  

#for choosing specific subsets
PowerF3<-subset(Power2, chan==("F3"),select=c(PID,Session,EO_EC,alpha))

#F3 
PowerF3_summary <- PowerF3 %>% group_by(Session,EO_EC) %>%##
  summarise(##
    count = n(),##
    mean = mean(alpha, na.rm = TRUE),##
    sd = sd(alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

PowerF3_summary$x<-c("SE1_EC","SE1_EO","SE2_EC","SE2_EO")
PowerF3_summary

Power2$EF3_EC2[which(Power2$EF3_EC2=="1")]<-"EO"
Power2$EF3_EC2[which(Power2$EF3_EC2=="2")]<-"EC"


SE1_EO<-PowerF3[PowerF3$Session=="SE1" & PowerF3$EO_EC=="EO"]
SE2_EO<-PowerF3[PowerF3$Session=="SE2" & PowerF3$EO_EC=="EO"]
SE1_EC<-PowerF3[PowerF3$Session=="SE1" & PowerF3$EO_EC=="EC"]
SE2_EC<-PowerF3[PowerF3$Session=="SE2" & PowerF3$EO_EC=="EC"]



t.test(SE1_EO$alpha, SE2_EO$alpha, paired=T)
t.test(SE1_EC$alpha, SE2_EC$alpha, paired=T)
t.test(SE1_EO$alpha, SE1_EC$alpha, paired=F)
t.test(SE2_EO$alpha, SE2_EC$alpha, paired=F)



