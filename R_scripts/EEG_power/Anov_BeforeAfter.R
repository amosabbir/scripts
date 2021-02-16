setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfP3<-subset(Baseline_EC_afterepoch, Channel==("P3"))

#Eyes Open
df_P3<-subset(dfP3,EO1_EC2=="2",select=c(ID,EO1_EC2,SE1_SE2,Responder,Gamma))
df_P3_summary <- df_P3 %>% group_by(SE1_SE2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Gamma, na.rm = TRUE),##
    sd = sd(Gamma, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_P3_summary$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R")
df_P3_summary

df_P3$SE1_SE2[which(df_P3$SE1_SE2=="1")]<-"SE1"
df_P3$SE1_SE2[which(df_P3$SE1_SE2=="2")]<-"SE2"

ez_outcome <- ezANOVA(
  data = df_P3,
  dv = Gamma,
  wid = ID,
  within = SE1_SE2,
  between = Responder,
  type = 3)


SE1_R<-df_P3[df_P3$SE1_SE2=="SE1" & df_P3$Responder=="R"]
SE2_R<-df_P3[df_P3$SE1_SE2=="SE2" & df_P3$Responder=="R"]
SE1_NR<-df_P3[df_P3$SE1_SE2=="SE1" & df_P3$Responder=="NR"]
SE2_NR<-df_P3[df_P3$SE1_SE2=="SE2" & df_P3$Responder=="NR"]


t.test(SE1_R$Gamma, SE2_R$Gamma, paired=T)
t.test(SE1_NR$Gamma, SE2_NR$Gamma, paired=T)
t.test(SE1_NR$Gamma, SE1_R$Gamma, paired=F)
t.test(SE2_NR$Gamma, SE2_R$Gamma, paired=F)
ez_outcome



