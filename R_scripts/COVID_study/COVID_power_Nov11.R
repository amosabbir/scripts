setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/Raw_data_Statistics/EEG")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

stats<-fread("Relative_power_total.csv")
stats<-subset(stats, Session==1 | Session==2)

#for choosing specific subsets
dfO1<-subset(stats, Channel==("O1"))

#O1 baseline
df_O1<-subset(dfO1,EO1_EC2==1)
#df_O1<-subset(dfO1,Session==1)

df_O1_summary <- df_O1 %>% group_by(Group,Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(gamma3, na.rm = TRUE),##
    sd = sd(gamma3, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

#df_O1_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_O1_summary



p<-ggplot(df_O1_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Power")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
p


rm_O1<-summary(aov(gamma3 ~ Group * Session + Error(PID/Session), data=df_O1))
rm_O1


