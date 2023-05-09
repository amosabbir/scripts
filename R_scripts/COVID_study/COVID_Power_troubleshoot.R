setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative")
#setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Spectra")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


spectrum<-fread("All_spectra_relative2.csv")
#spectrum<-fread("All_spectra.csv")

df_summary <- spectrum %>% group_by(PID,Group,Session,EO1_EC2,Channel) %>%##
  summarise(across(everything(),mean),
  .groups = 'drop') %>%
  as.data.frame()
df_summary[1:10,1:8]  

library(matrixStats)
X<-transform(spectrum[,6:262], SD=apply(spectrum[,6:262],1,sd, na.rm=TRUE))
A<-spectrum[,1:5]
A$SD<-X$SD

X<-transform(spectrum[,6:15], SD_9=apply(spectrum[,6:15],1,sd, na.rm=TRUE))
A$SD_9<-X$SD_9


X<-transform(spectrum[,15:50], SD_50=apply(spectrum[,15:50],1,sd, na.rm=TRUE))
A$SD_50<-X$SD_50


A<-spectrum
A$SD<-A$Std
EO_SD<-subset(A, EO1_EC2==1)
EC_SD<-subset(A, EO1_EC2==2)

p <- ggplot(EO_SD, aes(x=PID, y=SD, color=Channel, shape=Session)) +
  geom_point() + 
  theme_classic()+
  ggtitle("EO SD")+
	scale_x_continuous(name="PID", breaks=seq(0,21,1), limits=c(0,21))
p

p2 <- ggplot(EC_SD, aes(x=PID, y=SD, color=Channel, shape=Session)) +
  geom_point() + 
  theme_classic()+
  ggtitle("EC SD")+
	scale_x_continuous(name="PID", breaks=seq(0,21,1), limits=c(0,21))
	p2


EO_SD_lim<-subset(EO_SD, Channel=="Fp1" | Channel=="Fp2" | Channel=="F3" | Channel=="F4" | Channel=="C3" | Channel=="C4" | Channel=="P3" | Channel=="P4" | Channel=="O1" | Channel=="O2")
EC_SD_lim<-subset(EC_SD, Channel=="Fp1" | Channel=="Fp2" | Channel=="F3" | Channel=="F4" | Channel=="C3" | Channel=="C4" | Channel=="P3" | Channel=="P4" | Channel=="O1" | Channel=="O2")


p_lim <- ggplot(EO_SD_lim, aes(x=PID, y=SD, color=Channel, shape=Session)) +
  geom_point() + 
  theme_classic()+
  ggtitle("EO SD")+
	scale_x_continuous(name="PID", breaks=seq(0,21,1), limits=c(0,21))
p_lim

p2_lim <- ggplot(EC_SD_lim, aes(x=PID, y=SD, color=Channel, shape=Session)) +
  geom_point() + 
  theme_classic()+
  ggtitle("EC SD")+
	scale_x_continuous(name="PID", breaks=seq(0,21,1), limits=c(0,21))
	p2_lim
	


df_summary <- A %>% group_by(PID,Group,EO1_EC2,Session) %>%##
  summarise(##
    count = n(),##
    SD = mean(Std, na.rm = TRUE)
  )

#df_P4_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_summary
A<-df_summary


EO_SD<-subset(A, EO1_EC2==1)
EC_SD<-subset(A, EO1_EC2==2)

p <- ggplot(EO_SD, aes(x=PID, y=mean, color= PID, shape=Session)) +
  geom_point() + 
  theme_classic()+
  ggtitle("EO SD")+
	scale_x_continuous(name="PID", breaks=seq(0,21,1), limits=c(0,21))
p



