setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfF3<-subset(Baseline_EC_afterepoch, Channel==("F3"))

#F3 baseline
df_F3<-subset(dfF3,EO1_EC2=="1",select=c(ID,EO1_EC2,SE1_SE2,Responder,Alpha))
df_F3_summary <- df_F3 %>% group_by(SE1_SE2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Alpha, na.rm = TRUE),##
    sd = sd(Alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_F3_summary$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R")
df_F3_summary


p_F3<- ggplot(df_F3_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Total Power at F3")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(0,7.5),expand=F)#
  ggsave("p_F3.png", width=6, height=6)
  
  
p_F3_line<-ggplot(df_F3, aes(x=SE1_SE2, y=Alpha, group=ID, colour=Responder)) +
  geom_line(aes(x=SE1_SE2, group=ID)) +
  geom_point(aes(x=SE1_SE2, group=ID))+
  scale_colour_grey(start=0.7, end=0) +
  ylim(0,0.1)+
  labs(x="Pre- to Post-Intervention", y = "Alpha power at F3 (uv^2/Hz)")+
  theme_classic(base_size=10)+ 
  scale_x_discrete(labels=c("Pre-Intervention", "Post-Intervention"))+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  ggsave("p_F3_line.png", width=8, height=6,dpi=300)  


df_F3_SE1<-df_F3[!(df_F3$SE1_SE2=="2")]
df_F3_SE2<-df_F3[!(df_F3$SE1_SE2=="1")]
df_F3_SE1$Alpha2<-df_F3_SE2$Alpha
df_F3_SE1$change<-(df_F3_SE1$Alpha2-df_F3_SE1$Alpha)/(df_F3_SE1$Alpha)


#percent change summary
df_F3_change_summary <- df_F3_SE1 %>% group_by(Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(change, na.rm = TRUE),##
    sd = sd(change, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_F3_change_summary$x<-c("NR","R")
df_F3_change_summary

p_F3_change<- ggplot(df_F3_change_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Percent change from SE1 to SE2")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(0,1),expand=F)#
  ggsave("p_F3_change.png", width=6, height=6)

p_F3
p_F3_line
p_F3_change