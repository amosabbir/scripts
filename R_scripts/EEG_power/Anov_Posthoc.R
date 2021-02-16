setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfP3<-subset(Baseline_EC_afterepoch, Channel==("P3"))

#P3 baseline
df_P3<-subset(dfP3,SE1_SE2=="1",select=c(ID,EO1_EC2,SE1_SE2,Responder,Gamma))
df_P3_summary <- df_P3 %>% group_by(EO1_EC2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Gamma, na.rm = TRUE),##
    sd = sd(Gamma, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_P3_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_P3_summary

df_P3$EO1_EC2[which(df_P3$EO1_EC2=="1")]<-"EO"
df_P3$EO1_EC2[which(df_P3$EO1_EC2=="2")]<-"EC"

ez_outcome <- ezANOVA(
  data = df_P3,
  dv = Gamma,
  wid = ID,
  within = EO1_EC2,
  between = Responder,
  type = 3)


EO_R<-df_P3[df_P3$EO1_EC2=="EO" & df_P3$Responder=="R"]
EC_R<-df_P3[df_P3$EO1_EC2=="EC" & df_P3$Responder=="R"]
EO_NR<-df_P3[df_P3$EO1_EC2=="EO" & df_P3$Responder=="NR"]
EC_NR<-df_P3[df_P3$EO1_EC2=="EC" & df_P3$Responder=="NR"]


t.test(EO_R$Gamma, EC_R$Gamma, paired=T)
t.test(EO_NR$Gamma, EC_NR$Gamma, paired=T)
t.test(EO_NR$Gamma, EO_R$Gamma, paired=F)
t.test(EC_NR$Gamma, EC_R$Gamma, paired=F)
ez_outcome



