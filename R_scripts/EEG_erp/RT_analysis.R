setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Anhedonia/")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

data<-fread("RT_data2.csv")


df<-data[!(data$Box_RT=="NA"),]
df<-df[!(df$Box_RT==0),]


df2<-group_by(df,SE1_SE2,I1_NI2,Part_Num,Responder) %>%
  summarise(
    count = n(),
    mean = mean(Box_RT, na.rm = TRUE),
    sd = sd(Box_RT, na.rm = TRUE)
  )

df2$RT<-df2$mean
df2$Var<-df2$sd*df2$sd

df3<-group_by(df2,SE1_SE2,I1_NI2,Responder) %>%
  summarise(
    count = n(),
    mean = mean(RT, na.rm = TRUE),
    sd = sd(RT, na.rm = TRUE)
  )
df3$se<-df3$sd/(sqrt(df3$count))
  
df4<-group_by(df2,SE1_SE2,I1_NI2,Responder) %>%
  summarise(
    count = n(),
    mean = mean(Var, na.rm = TRUE),
    sd = sd(Var, na.rm = TRUE)
  )
df4$se<-df4$sd/(sqrt(df4$count))

df_Incentive<-subset(df2, df2$I1_NI2==1)
df_NonIncentive<-subset(df2, df2$I1_NI2==2)

df_Incentive$SE1_SE2[df_Incentive$SE1_SE2==1]<-"Before"
df_Incentive$SE1_SE2[df_Incentive$SE1_SE2==2]<-"After"

df_NonIncentive$SE1_SE2[df_NonIncentive$SE1_SE2==1]<-"Before"
df_NonIncentive$SE1_SE2[df_NonIncentive$SE1_SE2==2]<-"After"


df_spec<-group_by(df,SE1_SE2,I1_NI2,Responder) %>%
  summarise(
    count = n(),
    mean = mean(Box_RT, na.rm = TRUE),
    sd = sd(Box_RT, na.rm = TRUE)
  )




#---------bar graph--------------------------

df_Inc<-subset(df3, df3$I1_NI2==1)
df_NonInc<-subset(df3, df3$I1_NI2==2)
  
df_Inc$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R")    
df_NonInc$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R") 

#reorder bars
df_Inc$x<-factor(df_Inc$x, levels=c("SE1_R","SE2_R","SE1_NR","SE2_NR"))
df_NonInc$x<-factor(df_NonInc$x, levels=c("SE1_R","SE2_R","SE1_NR","SE2_NR"))

p_Inc<- ggplot(df_Inc, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Reaction Time (ms)")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=15)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(180,230),expand=F)+#
  ggtitle("          Incentive Cue Reaction Time")
  ggsave("df_Inc.png", width=6, height=6)
  
  
  
p_NonInc<- ggplot(df_NonInc, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Reaction Time (ms)")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=15)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(180,230),expand=F)+#
  ggtitle("         Non-Incentive Cue Reaction Time")
  ggsave("df_NonInc.png", width=6, height=6) 