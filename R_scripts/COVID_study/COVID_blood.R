setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/Bloodwork")
library(ggplot2)
library(dplyr)
library(data.table)
library(tidyr)
library(PairedData)

library(emmeans)
library(lme4)
library(lmerTest)
library(ez)
library(doBy)


blood<-fread("Bloodwork.csv")
blood<-blood[,1:10]
blood<-blood[!(blood$Session==3 | blood$IL6=="NA"),]
blood <- gather(blood, Cytokine, Value, IL6:BDNF, factor_key=TRUE)


blood_IL6<-subset(blood,Cytokine=="IL6")
blood_IL2<-subset(blood,Cytokine=="IL2")
blood_IL10<-subset(blood,Cytokine=="IL10")
blood_IL4<-subset(blood,Cytokine=="IL4")
blood_CRP<-subset(blood,Cytokine=="CRP")
blood_IFNy<-subset(blood,Cytokine=="IFNy")
blood_TNFa<-subset(blood,Cytokine=="TNFa")
blood_Gpx<-subset(blood,Cytokine=="Gpx")
blood_ROS<-subset(blood,Cytokine=="ROS")
blood_SOD<-subset(blood,Cytokine=="SOD")
blood_ACS<-subset(blood,Cytokine=="ACS")
blood_TRPC3<-subset(blood,Cytokine=="TRPC3")
blood_TRPC1<-subset(blood,Cytokine=="TRPC1")
blood_TRPV<-subset(blood,Cytokine=="TRPV")
blood_TRPC6<-subset(blood,Cytokine=="TRPC6")
blood_GDNF<-subset(blood,Cytokine=="GDNF")
blood_BDNF<-subset(blood,Cytokine=="BDNF")

#nih_Flank<-nih_Flank[!grepl("COV_18", nih_Flank$PIN),]

IL6_summary <- blood_IL6 %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
IL6_summary


IL6_graph<-ggplot(IL6_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Cytokine value")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
IL6_graph


rm_IL6<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=blood_IL6))
rm_IL6



blood2<-fread("Flank_T.csv")
blood2<-subset(blood2, Group=="Treatment")
plot(blood2$flank_diff,blood2$blood_diff)
abline(lm(blood2$blood_diff~blood2$flank_diff))

corr <- lm(flank_diff ~ blood_diff, data = blood2)
summary(corr)








#baseline statistics
blood3<-subset(blood, Session=="1")
p<-ggplot(blood3, aes(x=BDNF)) + 
 geom_histogram(aes(y=..density..), colour="black", fill="white", binwidth=0.1)+
 geom_density(alpha=.2, fill="#FF6666") + 
 labs(x= "Western Blot Value",y = "Population Density")+
 scale_color_grey() + 
 theme_classic(base_size=10)+
 ggtitle("BDNF") +
 theme(plot.title = element_text(hjust = 0.5))+
 coord_cartesian(xlim=c(0,1.5),ylim=c(0,3),expand=F) +
 theme(plot.margin=unit(c(1,1,1,1), "cm"))
p 


#CSCI
CSCI<-subset(blood3, CI=="CSCI")
non_CSCI<-subset(blood3, CI=="Non")

BDNF_summary <- blood3 %>% group_by(CI) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(BDNF), na.rm = TRUE),##
    sd = sd(as.numeric(BDNF), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
BDNF_summary

t.test(CSCI$BDNF, non_CSCI$BDNF, paired=F)


BDNF_<- ggplot(BDNF_summary, aes(x=CI, y=mean, fill=CI))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Value")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  #coord_cartesian(ylim=c(0,10),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))+
  ggtitle("BDNF CSCI vs. Control")
BDNF_  


