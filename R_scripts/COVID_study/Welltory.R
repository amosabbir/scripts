setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/Raw_data_Statistics/Welltory/Data_Organization")
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


welltory<-fread("welltory_diff.csv")
welltory_1<-subset(welltory,Timepoint=="1")
welltory_2<-subset(welltory,Timepoint=="2")
welltory_diff<-welltory_1[,c(5:10)]-welltory_2[,c(5:10)]
write.csv(welltory_diff,"welltory_diff.csv")

Measurement_HR_summary <- welltory %>% group_by(Cog,Day) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_summary



Measurement_HR_t<-subset(Measurement_HR_summary,Group=="Treatment")
Measurement_HR_c<-subset(Measurement_HR_summary,Group=="Control")



Measurement_HR<-ggplot(Measurement_HR_summary, aes(x=Day, y=mean, group = Cog, color=Cog))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Cog))+
     labs(x="Timepoint", y = "Measurement_HR")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_continuous(limits = c(0,28), breaks = seq (0,28, by=1)) 
Measurement_HR




Measurement_HR<-ggplot(Measurement_HR_summary, aes(x=Day, y=mean, group=Group)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Measurement_HR")+
   ylim(0,100)+
   xlim(0,100)+
   scale_color_grey(start=0.9, end=0.3)+
   theme_classic(base_size=15)+
   scale_x_continuous(n.breaks=27)
   Measurement_HR
                         
ggsave("Measurement_HR.png", Measurement_HR, width=15, height=5, units="in")
   
   
Measurement_HR<-ggplot(Measurement_HR_c, aes(x=Day, y=mean, group=Timepoint)) +
  geom_line(aes(color=Timepoint))+
  geom_point(aes(color=Timepoint))+
   labs(x="Timepoint", y = "Measurement_HR")+
   ylim(0,100)+
   theme_classic(base_size=15)  





Measurement_HR_ <- welltory %>% group_by(Cog) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_

t.test(as.data.frame(subset(Measurement_HR_summary, Cog=="CSCI"))$mean, as.data.frame(subset(Measurement_HR_summary, Cog=="non"))$mean, paired=F)



Measurement_HR__<- ggplot(Measurement_HR_, aes(x=Cog, y=mean, fill=Cog))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Value")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(-10,100),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))+
  ggtitle("Measurement_HR")

ggsave("Measurement_HR2.png", Measurement_HR__, width=5, height=5, units="in")


Focus_ <- welltory %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Focus), na.rm = TRUE),##
    sd = sd(as.numeric(Focus), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Focus_

Energy_ <- welltory %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Energy), na.rm = TRUE),##
    sd = sd(as.numeric(Energy), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Energy_


Measurement_HR_ <- welltory %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_

Measurement_HR_ <- welltory %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_


Measurement_HR_rm<-summary(aov(Measurement_HR ~ Group * AssessmentName + Error(PIN/AssessmentName), data=welltory))



#Correlation plot

library(Hmisc)
library(corrplot)
welltory2<-welltory[,!c(1,2,3,7)]
res2<-rcorr(as.matrix(welltory2))


corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")
         
cc<-corrplot(res2$r, p.mat = res2$P, method = 'color', diag = FALSE, type = 'upper',
         sig.level = c(0.001, 0.01, 0.05), pch.cex = 0.9, 
         insig = 'label_sig', pch.col = 'grey20', order = 'hclust')



#--- organizing data

welltory<-welltory %>%
  group_by(PID,Group,Day) %>%
  filter(Timepoint %in% c(1, 2)) %>%
  summarise(##
    Measurement_HR = diff(Measurement_HR),##
    Energy = diff(Energy),
    Focus = diff(Focus),
    Measurement_HR = diff(Measurement_HR),
    Measurement_HR = diff(Measurement_HR)##
  )
  
  
mean(Measurement_HR[Day >= 1 & Day <= 5])

  
  
#-----longitudinal 1st week vs 4th week

welltory<-fread("welltory_diff.csv")


PID_pre <- welltory2 %>% group_by(Group,PID) %>%##
  summarise(##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    Energy = mean(as.numeric(Energy), na.rm = TRUE),##
    Focus = mean(as.numeric(Focus), na.rm = TRUE),##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
  )
PID_pre



PID_post <- welltory3 %>% group_by(Group,PID) %>%##
  summarise(##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    Energy = mean(as.numeric(Energy), na.rm = TRUE),##
    Focus = mean(as.numeric(Focus), na.rm = TRUE),##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    Measurement_HR = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
  )
PID_post  


write.csv(PID_pre,"PID_pre.csv")
write.csv(PID_post,"PID_post.csv") 


welltory<-fread("PID_pre.csv")

Measurement_HR_summary <- welltory %>% group_by(Group,Timepoint) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_summary



Measurement_HR_graph<-ggplot(Measurement_HR_summary, aes(x=Timepoint, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Measurement_HR")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("First Week", "Last Week"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
Measurement_HR_graph

ggsave("Measurement_HR_Long.png", Measurement_HR_graph, width=5, height=5, units="in")


PID_pre<-fread("PID_pre.csv")
Measurement_HR_ind<-ggplot(PID_pre, aes(x=Timepoint, y=Measurement_HR, group=PID)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Measurement_HR")+
   theme_classic(base_size=15) 
Measurement_HR_ind 

ggsave("Measurement_HR_Long_ind.png", Measurement_HR_ind, width=5, height=5, units="in")


rm_Measurement_HR<-summary(aov(Measurement_HR ~ Group * Timepoint + Error(PID/Timepoint), data=welltory))
rm_Measurement_HR


#------Longitudinal daily
welltory<- subset(welltory, Timepoint == 1)
Measurement_HR_summary <- welltory %>% group_by(Group,Day) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Measurement_HR), na.rm = TRUE),##
    sd = sd(as.numeric(Measurement_HR), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Measurement_HR_summary



Measurement_HR_long_daily<-ggplot(Measurement_HR_summary, aes(x=Day, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Day", y = "Measurement_HR")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_continuous(limits = c(0,28), breaks = seq (0,28, by=1)) 
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
Measurement_HR_long_daily

ggsave("Measurement_HR_Long_daily.png", Measurement_HR_long_daily, width=15, height=5, units="in")
