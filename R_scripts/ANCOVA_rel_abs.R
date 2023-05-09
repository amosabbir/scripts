setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
#library(ggplot2)
library(dplyr)
library(data.table)
library(emmeans)
library(lme4)
library(ez)

Power<-fread("Power_CANBIND2.csv")
Power<-Power[,c(1:7,137:155)]

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"
Power<-Power[!(Power$Region=="na"),]
Power<-Power[!(Power$EO_EC=="EC"),]

rel_gamma<-summary(aov(rel_gamma ~ MADRS_PI * Session * Region + Error(PID/Session*Region), data=Power))

ez_rel_gamma<-ezANOVA(
  data = Power,
  dv = .(rel_gamma),
  wid = .(PID),
  within = .(Session, Region),
  between = .(MADRS_PI),
  type = 3)
  

gamma<-summary(aov(gamma ~ MADRS_PI * Session * Region + Error(PID/Session*Region), data=Power))

ez_gamma<-ezANOVA(
  data = Power,
  dv = .(gamma),
  wid = .(PID),
  within = .(Session, Region),
  between = .(MADRS_PI),
  type = 3)
  

setwd("/Users/abdullahmosabbir/Desktop/CANBIND/ANOVA")  
capture.output(rel_gamma,file="gamma1.doc")
capture.output (ez_rel_gamma, file="gamma2.doc")
capture.output(gamma,file="gamma3.doc")
capture.output (ez_gamma, file="gamma4.doc")  

