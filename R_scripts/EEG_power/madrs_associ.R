setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfO1<-subset(Baseline_EC_afterepoch,Channel==("O1"))
dfO1<-subset(dfO1,SE1_SE2=="1")
dfO1<-subset(dfO1,EO1_EC2=="1")

dfO1_<-subset(Baseline_EC_afterepoch,Channel==("O1"))
dfO1_<-subset(dfO1_,SE1_SE2=="2")
dfO1_<-subset(dfO1_,EO1_EC2=="1")

dfO1$Alpha2<-dfO1_$Alpha
dfO1<-subset(dfO1,EO1_EC2=="1",select=c(ID,SE1_SE2,Channel,Responder,Alpha,Alpha2))

write.csv (dfO1, "MADRS.csv")


plot(madrs$Diff, madrs$MADRS, pch = 16, cex = 1.3, col = "blue", main = "Alpha Diff vs. MADRS", xlab = "Alpha power difference", ylab = "MADRS difference")
abline(lm(formula = MADRS~Diff, data = madrs))

lm(formula = MADRS~Diff, data = madrs)

