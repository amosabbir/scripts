setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Baseline_EC_all<-fread("Baseline_EC_all.csv")

#for choosing specific subsets
dfF3<-subset(Baseline_EC_all, EO1_EC2==("1"))

#F3 baseline
#df_F3<-subset(dfF3,SE1_SE2=="1",select=c(ID,EO1_SE22,SE1_SE2,Responder,Alpha))
df_F3_SE1<-subset(dfF3,SE1_SE2=="1")
df_F3_SE2<-subset(dfF3,SE1_SE2=="2")
df_F3_SE1$AlphaS2<-df_F3_SE2$Alpha
df_F3_SE1$Diff<-df_F3_SE1$AlphaS2-df_F3_SE1$Alpha


dfF3_SE1_R<-subset(df_F3_SE1, Responder==("R"))
dfF3_SE1_NR<-subset(df_F3_SE1, Responder==("NR"))
dfF3_SE1_R<-summaryBy (Diff ~ Channel, data=dfF3_SE1_R, FUN=c(length,mean,sd))
dfF3_SE1_NR<-summaryBy (Diff ~ Channel, data=dfF3_SE1_NR, FUN=c(length,mean,sd))

write.xlsx(dfF3_SE1_R$Diff.mean,"alpha_before_after_R.xlsx")
write.xlsx(dfF3_SE1_NR$Diff.mean,"alpha_before_after_NR.xlsx")



