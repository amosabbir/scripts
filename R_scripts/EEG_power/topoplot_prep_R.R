setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)

topo<-fread("SE1.csv")

Chan_Name<-topo$chan[1:64]
Channel_Num<-(1:64)
R_sq<-rep(0,64)
adR_sq<-rep(0,64)
df<-data.frame(Chan_Name,Channel_Num,R_sq,adR_sq)


for(i in 1:64) {
PowerFp1<-subset(topo, chan==(Chan_Name[i]))
lm<-lm(MADRS_PI~alpha_diff, data=PowerFp1)
summary(lm)
df[i,3]<-summary(lm)$r.squared
df[i,4]<-summary(lm)$adj.r.squared
df
}

write.csv(df,"alpha_cor.csv")


