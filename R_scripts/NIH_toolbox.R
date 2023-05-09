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


nih<-fread("NIH_cog.csv")
nih<-subset(nih,Key=="NationalPercentileAgeAdjusted")
nih<-subset(nih,Session=="Assessment 1" | Session=="Assessment 2")

nih[CI=="CSCI" & Group=="Treatment",]$Group2<-"Treat_CSCI"
nih[CI=="CSCI" & Group=="Control",]$Group2<-"Control_CSCI"
nih[CI=="Non" & Group=="Treatment",]$Group2<-"Treat_Non"
nih[CI=="Non" & Group=="Control",]$Group2<-"Control_Non"


nih_Flank<-subset(nih,TestName=="Flank_2")
nih_Flank<-subset(nih,TestName=="Flank_2")
nih_ListSort<-subset(nih,TestName=="ListSort_2")
nih_DCCS<-subset(nih,TestName=="DCCS_2")
nih_PatCom<-subset(nih,TestName=="PatCom_2")
nih_PicSeq<-subset(nih,TestName=="PicSeq_2")
nih_OralRead<-subset(nih,TestName=="OralRead_2")
nih_FluidComp<-subset(nih,TestName=="FluidComp")
nih_CrysComp<-subset(nih,TestName=="CrysComp")
nih_TotComp<-subset(nih,TestName=="TotComp")
nih_ECComp<-subset(nih,TestName=="ECComp")


#nih_Flank<-nih_Flank[!grepl("COV_18", nih_Flank$PIN),]

Flank_summary <- nih_Flank %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Flank_summary


Flank_graph<-ggplot(Flank_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Flank Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
Flank_graph


Flank_ind<-ggplot(nih_Flank, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Pic Voc Percentile")+
   theme_classic(base_size=15) 
Flank_ind   


rm_Flank<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_Flank))
rm_Flank




#---------------------------------------   


Flank_summary <- nih_Flank %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Flank_summary


Flank_graph<-ggplot(Flank_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Flank Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

Flank_ind<-ggplot(nih_Flank, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Flank Percentile")+
   theme_classic(base_size=15) 



ListSort_summary <- nih_ListSort %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
ListSort_summary

ListSort_graph<-ggplot(ListSort_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "ListSort Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ListSort_ind<-ggplot(nih_ListSort, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "ListSort Percentile")+
   theme_classic(base_size=15) 
   
   


DCCS_summary <- nih_DCCS %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
DCCS_summary

DCCS_graph<-ggplot(DCCS_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "DCCS Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

DCCS_ind<-ggplot(nih_DCCS, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "DCCS Percentile")+
   theme_classic(base_size=15) 
   
   



PatCom_summary <- nih_PatCom %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
PatCom_summary

PatCom_graph<-ggplot(PatCom_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "PatCom Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

PatCom_ind<-ggplot(nih_PatCom, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "Patcom Percentile")+
   theme_classic(base_size=15) 



PicSeq_summary <- nih_PicSeq %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
PicSeq_summary

PicSeq_graph<-ggplot(PicSeq_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "PicSeq Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

PicSeq_ind<-ggplot(nih_PicSeq, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "PicSeq Percentile")+
   theme_classic(base_size=15) 


OralRead_summary <- nih_OralRead %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
OralRead_summary

OralRead_graph<-ggplot(OralRead_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "OralRead Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

OralRead_ind<-ggplot(nih_OralRead, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "OralRead Percentile")+
   theme_classic(base_size=15) 



FluidComp_summary <- nih_FluidComp %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
FluidComp_summary

FluidComp_graph<-ggplot(FluidComp_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "FluidComp Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

FluidComp_ind<-ggplot(nih_FluidComp, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "FluidComp Percentile")+
   theme_classic(base_size=15) 
   
   

CrysComp_summary <- nih_CrysComp %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
CrysComp_summary

CrysComp_graph<-ggplot(CrysComp_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "CrysComp Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

CrysComp_ind<-ggplot(nih_CrysComp, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "CrysComp Percentile")+
   theme_classic(base_size=15) 


TotComp_summary <- nih_TotComp %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
TotComp_summary

TotComp_graph<-ggplot(TotComp_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "TotComp Percentile")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

TotComp_ind<-ggplot(nih_TotComp, aes(x=Session, y=Value, group=PIN)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "TotComp Percentile")+
   theme_classic(base_size=15) 
   
   

ECComp_summary <- nih_ECComp %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
ECComp_summary


#----------stats


rm_Flank<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_Flank))

rm_Flank<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_Flank))

rm_ListSort<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_ListSort))

rm_DCCS<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_DCCS))

rm_PatCom<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_PatCom))

rm_PicSeq<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_PicSeq))

rm_OralRead<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_OralRead))

rm_FluidComp<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_FluidComp))

rm_CrysComp<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_CrysComp))

rm_TotComp<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_TotComp))

rm_ECComp<-summary(aov(Value ~ Group * Session + Error(PIN/Session), data=nih_ECComp))

#--------------

