setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/ccfmtDNA")
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


mtdna<-fread("mtDNA_data.csv")
mtdna<-subset(mtdna,Session=="A" | Session=="B")

#Baseline Assessments
n_ND1_summary <- mtdna %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(n_ND1), na.rm = TRUE),##
    sd = sd(as.numeric(n_ND1), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
n_ND1_summary


t.test(mtdna[CI=="CSCI",]$n_ND1, mtdna[CI=="Non",]$n_ND1, paired=F)

#Pre vs. Post
mtdna

n_ND1_summary <- mtdna %>% group_by(Group2, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(n_ND1), na.rm = TRUE),##
    sd = sd(as.numeric(n_ND1), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
n_ND1_summary

rm_n_ND1<-summary(aov(n_ND1 ~ Group * Session *CI + Error(PID/Session), data=mtdna))
rm_n_ND1


n_ND4_summary <- mtdna %>% group_by(Group, Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(n_ND4), na.rm = TRUE),##
    sd = sd(as.numeric(n_ND4), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
n_ND4_summary

rm_n_ND4<-summary(aov(n_ND4 ~ Group * Session + Error(PID/Session), data=mtdna))
rm_n_ND4


n_ND1_graph<-ggplot(n_ND1_summary, aes(x=Session, y=mean, group = Group2, color=Group2))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group2))+
     labs(x="Timepoint", y = "ND1 Copy per microlitre")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
n_ND1_graph


n_ND1_ind<-ggplot(mtdna, aes(x=Session, y=ND1, group=PID)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
   labs(x="Timepoint", y = "ND1 copy per microlitre")+
   theme_classic(base_size=15) 
n_ND1_ind  

