#summary(lmer(dv ~ cov + group * time + (1 | ID), data=yourdata))

setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
#library(ggplot2)
library(dplyr)
library(data.table)
library(emmeans)
library(lme4)
library(lmerTest)
library(ez)
library(doBy)

Power<-fread("Power_CANBIND2.csv")
Power<-Power[,c(1:12,137:158)]

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"
Power<-Power[!(Power$Region=="na"),]


Power_aggregate<-summaryBy (MADRS_PI+gamma+rel_gamma+beta+rel_beta+theta+rel_theta+delta+rel_delta+gamma+rel_gamma ~ PID+EO_EC+Session+Responder+Region, data=Power, FUN=c(mean))

Power_aggregate<-Power_aggregate[!(Power_aggregate$EO_EC=="EC"),]


mad_delta<-summary(aov(delta ~ MADRS_PI * EO_EC * Session * Region + Error(PID), data=Power))

resp_delta<-anova(lmer(delta ~ MADRS_PI * EO_EC * Session * Region + (1 | PID), data=Power))

ez_delta<-ezANOVA(
  data = Power,
  dv = .(delta),
  wid = .(PID),
  within = .(Session, EO_EC, Region),
  between = .(Responder),
  type = 3)
  

Power<-Power[!(Power$EO_EC=="EC"),]

madeo_delta<-summary(aov(delta ~ MADRS_PI * Session * Region + Error(PID/Session*Region), data=Power))

respeo_delta<-anova(lmer(gamma ~ MADRS_PI * Session * Region + (1 | PID) + (1 | Session:PID) + (1 | Region:PID), data=Power))

anova(lmer(delta ~ MADRS_PI * Session * Region + (Session | PID) + (Region | PID), data=Power))

ezeo_delta<-ezANOVA(
  data = Power,
  dv = .(gamma),
  wid = .(PID),
  within = .(Session, Region),
  between = .(MADRS),
  type = 3)






aov_aggregated<-summary(aov(gamma.mean ~ MADRS_PI.mean * Session * Region + Error(PID), data=Power_aggregate))

aov_nonaggregated<-summary(aov(gamma ~ MADRS_PI * Session * Region + Error(PID/Region), data=Power))

lmer_aggregated<-anova(lmer(gamma.mean ~ MADRS_PI.mean * Session * Region  + (1 | PID), data=Power_aggregate))

lmer_nonaggregated<-anova(lmer(gamma ~ MADRS_PI * Session * Region + (1 | PID) + (1 | PID:Region), data=Power))






setwd("/Users/abdullahmosabbir/Desktop/CANBIND/ANCOVA")
capture.output(mad_delta,file="delta1.doc")
capture.output (resp_delta, file="delta2.doc")
capture.output(madeo_delta,file="delta3.doc")
capture.output (respeo_delta, file="delta4.doc")




madeo_delta<-summary(aov(delta ~ MADRS_PI * Session * Region + Error(PID/Session*Region), data=Power))





