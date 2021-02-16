setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfO1<-subset(Baseline_EC_afterepoch, Channel==("O1"))

#O1 baseline
df_O1<-subset(dfO1,SE1_SE2=="1",select=c(ID,EO1_EC2,SE1_SE2,Responder,Alpha))
df_O1_summary <- df_O1 %>% group_by(EO1_EC2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Alpha, na.rm = TRUE),##
    sd = sd(Alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_O1_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_O1_summary


p_O1<- ggplot(df_O1_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Alpha Power at O1")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(0,10),expand=F)#
  ggsave("p_O1.png", width=6, height=6)
  
  
p_O1_line<-ggplot(df_O1, aes(x=EO1_EC2, y=Alpha, group=ID, colour=Responder)) +
  geom_line(aes(group=ID)) +
  geom_point()+
  scale_colour_grey(start=0.7, end=0) +
  ylim(0,20)+
  labs(x="Eyes open to Eyes closed", y = "Alpha power at O1 (uv^2/Hz)")+
  theme_classic(base_size=10)+ 
  scale_x_discrete(labels=c("Open", "Closed"))+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  ggsave("p_O1_line.png", width=8, height=6,dpi=300)  


df_O1_EO<-df_O1[!(df_O1$EO1_EC2=="2")]
df_O1_EC<-df_O1[!(df_O1$EO1_EC2=="1")]
df_O1_EO$Alpha2<-df_O1_EC$Alpha
df_O1_EO$change<-(df_O1_EO$Alpha2-df_O1_EO$Alpha)/(df_O1_EO$Alpha)


#percent change summary
df_O1_change_summary <- df_O1_EO %>% group_by(Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(change, na.rm = TRUE),##
    sd = sd(change, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_O1_change_summary$x<-c("NR","R")
df_O1_change_summary

p_O1_change<- ggplot(df_O1_change_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Percent change from EO to EC")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(-7,7),expand=F)#
  ggsave("p_O1_change.png", width=6, height=6)

p_O1
p_O1_line
p_O1_change