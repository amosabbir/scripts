setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid")
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

eq<-fread("eq_brain_performance.csv")
eq<-subset(eq,Session_num=="A_before" | Session_num=="B_after")

Reaction_Time_summary <- eq %>% group_by(Group, Session_num) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Reaction_Time), na.rm = TRUE),##
    sd = sd(as.numeric(Reaction_Time), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Reaction_Time_summary

rm_Reaction_Time<-summary(aov(Reaction_Time ~ Group * Session_num + Error(Name/Session_num), data=eq))  
rm_Reaction_Time



Reaction_Time_graph_ind<-ggplot(eq, aes(x=Session_num, y=Reaction_Time, group=Name)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Reaction_Time Percentile")+
   theme_classic(base_size=15) 
Reaction_Time_graph_ind


Reaction_Time_graph<-ggplot(Reaction_Time_summary, aes(x=Session_num, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Reaction_Time")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     #scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
     
     
     
rm_Reaction_Time<-summary(aov(Reaction_Time ~ Group * Session_num + Error(Name/Session_num), data=eq))    

 
     