setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


spectrum<-fread("spectrum.csv")

#for choosing specific subsets
dfF4<-subset(spectrum, Channel==("C3"))

dfF4<-gather(dfF4, time, power, "0":"64", factor_key=T)
dfF4<-dfF4[order(dfF4$Number,dfF4$Index,dfF4$EO1_EC2,dfF4$SE1_SE2),]


#F4 baseline
df_F4<-subset(dfF4,EO1_EC2=="1")
df_F4_summary <- df_F4 %>% group_by(SE1_SE2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(power, na.rm = TRUE),##
    sd = sd(power, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_F4_summary$x<-c("Before RSS_NR","Before RSS_R","After RSS_NR","After RSS_R")
df_F4_summary

df_F4<-summaryBy (power ~ EO1_EC2 + SE1_SE2 + Responder + time, data=df_F4, FUN=c(length,mean,sd))
df_F4$SE1_SE2[which(df_F4$SE1_SE2=="1")]<-"Before RSS"
df_F4$SE1_SE2[which(df_F4$SE1_SE2=="2")]<-"After RSS"
colnames(df_F4)[2]<-"Session"


#df_F4$timepoint<-as.numeric(df_F4$time)
#df_F4$timepoint<-df_F4$timepoint/2
#df_F4$timepoint<-df_F4$timepoint*2
#df_F4$timepoint<-df_F4$timepoint-0.5
write.csv(df_F4,"Data.csv")
df_F4<-fread("Data.csv")

NR_R_before<-subset(df_F4,Session=="Before RSS")
NR_R_after<-subset(df_F4,Session=="After RSS")
NR_ba<-subset(df_F4,Responder=="NR")
R_ba<-subset(df_F4,Responder=="R")


  
p_NR_R_before<-ggplot(NR_R_before, aes(x=time, y=power.mean, group=Responder, colour=Responder)) +
  geom_line(aes(x=time, group=Responder), size=0.5) +
  #geom_point(aes(x=time, group=Responder))+
  scale_colour_grey(start=0.7, end=0) +
  labs(x="Frequency (Hz)", y = "Power (uv^2/Hz)")+
  ggtitle("Non-Responders vs. Responders at Baseline")+
  guides(fill=guide_legend(title="Session"))+
  scale_x_continuous(name="Frequency (Hz)", n.breaks=13)+
  scale_y_continuous(name="Power (uv^2/Hz)")+
  ylim(0,7)+
  theme_classic(base_size=20)+ 
  theme(axis.text=element_text(size=12),plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
  ggsave("NR_R_before.png", width=8, height=6,dpi=300)  

p_NR_R_after<-ggplot(NR_R_after, aes(x=time, y=power.mean, group=Responder, colour=Responder)) +
  geom_line(aes(x=time, group=Responder)) +
  #geom_point(aes(x=time, group=Responder))+
  scale_colour_grey(start=0.7, end=0) +
  labs(x="Frequency (Hz)", y = "Power (uv^2/Hz)")+
  ggtitle("Non-Responders vs. Responders after Intervention")+
  guides(fill=guide_legend(title="Session"))+
  scale_x_continuous(name="Frequency (Hz)", n.breaks=13)+
  scale_y_continuous(name="Power (uv^2/Hz)")+
  ylim(0,7)+
  theme_classic(base_size=20)+ 
  theme(axis.text=element_text(size=12),plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
  ggsave("NR_R_after.png", width=8, height=6,dpi=300)  
  
  
p_NR_ba<-ggplot(NR_ba, aes(x=time, y=power.mean, group=Session, colour=Session)) +
  geom_line(aes(x=time, group=Session)) +
  #geom_point(aes(x=time, group=Session))+
  scale_colour_grey(start=0.7, end=0) +
  labs(x="Frequency (Hz)", y = "Power (uv^2/Hz)")+
  ggtitle("Non-Responders before and after Intervention")+
  guides(fill=guide_legend(title="Session"))+
  scale_x_continuous(name="Frequency (Hz)", n.breaks=13)+
  scale_y_continuous(name="Power (uv^2/Hz)")+
  ylim(0,7)+
  theme_classic(base_size=20)+ 
  theme(axis.text=element_text(size=12),plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
  ggsave("NR_ba.png", width=8, height=6,dpi=300)   
  
  
  
p_R_ba<-ggplot(R_ba, aes(x=time, y=power.mean, group=Session, colour=Session)) +
  geom_line(aes(x=time, group=Session)) +
  #geom_point(aes(x=time, group=Session))+
  scale_colour_grey(start=0.7, end=0) +
  labs(x="Frequency (Hz)", y = "Power (uv^2/Hz)")+
  ggtitle("Responders before and after Intervention")+
  guides(fill=guide_legend(title="Session"))+
  scale_x_continuous(name="Frequency (Hz)", n.breaks = 13)+
  scale_y_continuous(name="Power (uv^2/Hz)")+
  ylim(0,7)+
  theme_classic(base_size=20)+ 
  theme(axis.text=element_text(size=12),plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
  ggsave("R_ba.png", width=8, height=6,dpi=300)     
