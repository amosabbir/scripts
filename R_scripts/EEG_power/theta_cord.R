setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Theta_cordance2<-fread("Theta_cordance2.csv")

#for choosing specific subsets
dfFp1<-subset(Theta_cordance2, Channel==("Fp1"))

#Fp1 baseline
df_Fp1<-subset(dfFp1,EO1_EC2=="2",select=c(Number,Index,EO1_EC2,SE1_SE2,Responder,Cordance))
df_Fp1_summary <- df_Fp1 %>% group_by(SE1_SE2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Cordance, na.rm = TRUE),##
    sd = sd(Cordance, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_Fp1_summary$x<-c("SE1_NR","SE1_R","SE2_NR","SE2_R")
df_Fp1_summary




p_Fp1<- ggplot(df_Fp1_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Theta Cordance at Fp1")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(-2,2),expand=F)#
  ggsave("p_Fp1.png", width=6, height=6)
  
  
p_Fp1_line<-ggplot(df_Fp1, aes(x=SE1_SE2, y=Cordance, group=Number, colour=Responder)) +
  geom_line(aes(group=Number)) +
  geom_point()+
  scale_colour_grey(start=0.7, end=0) +
  ylim(-5,5)+
  labs(x="SE1 to SE2", y = "Theta Cordance at Fp1 (uv^2/Hz)")+
  theme_classic(base_size=10)+ 
  scale_x_discrete(labels=c("Open", "Closed"))+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  ggsave("p_Fp1_line.png", width=8, height=6,dpi=300)  


df_Fp1_SE1<-df_Fp1[!(df_Fp1$SE1_SE2=="2")]
df_Fp1_SE2<-df_Fp1[!(df_Fp1$SE1_SE2=="1")]
df_Fp1_SE1$Cordance2<-df_Fp1_SE2$Cordance
df_Fp1_SE1$change<-(df_Fp1_SE1$Cordance2-df_Fp1_SE1$Cordance)/(df_Fp1_SE1$Cordance)


#percent change summary
df_Fp1_change_summary <- df_Fp1_SE1 %>% group_by(Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(change, na.rm = TRUE),##
    sd = sd(change, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_Fp1_change_summary$x<-c("NR","R")
df_Fp1_change_summary

p_Fp1_change<- ggplot(df_Fp1_change_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Percent change from SE1 to SE2")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(-7,7),expand=F)#
  ggsave("p_Fp1_change.png", width=6, height=6)

p_Fp1


df_Fp1$SE1_SE2[which(df_Fp1$SE1_SE2=="1")]<-"SE1"
df_Fp1$SE1_SE2[which(df_Fp1$SE1_SE2=="2")]<-"SE2"

ez_outcome <- ezANOVA(
  data = df_Fp1,
  dv = Cordance,
  wid = Number,
  within = SE1_SE2,
  between = Responder,
  type = 3)


SE1_R<-df_Fp1[df_Fp1$SE1_SE2=="SE1" & df_Fp1$Responder=="R"]
SE2_R<-df_Fp1[df_Fp1$SE1_SE2=="SE2" & df_Fp1$Responder=="R"]
SE1_NR<-df_Fp1[df_Fp1$SE1_SE2=="SE1" & df_Fp1$Responder=="NR"]
SE2_NR<-df_Fp1[df_Fp1$SE1_SE2=="SE2" & df_Fp1$Responder=="NR"]

t.test(SE1_R$Cordance, SE2_R$Cordance, paired=T)
t.test(SE1_NR$Cordance, SE2_NR$Cordance, paired=T)
t.test(SE1_NR$Cordance, SE1_R$Cordance, paired=F)
t.test(SE2_NR$Cordance, SE2_R$Cordance, paired=F)
ez_outcome
