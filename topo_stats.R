setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)

topo<-fread("SE1.csv")

topo3<-topo[(Region=="Parietal"),]
topo4<-topo[(Region=="Occipital"),]
topo2<-rbind(topo3,topo4)

topo22 <- topo2 %>% group_by(PID) %>%##
  summarise(##
    count = n(),##
    gamma = mean(gamma_diff, na.rm = TRUE),##
    alpha = mean(alpha_diff, na.rm = TRUE),##
    madrs = mean(MADRS_PI, na.rm = TRUE)
  )
  
alpha<-lm(madrs~alpha, data=topo22)
summary(alpha)  

gamma<-lm(madrs~gamma, data=topo22)
summary(gamma)