setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

Power<-fread("Power_CANBIND2.csv")
Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"
Power<-Power[!(Power$EO_EC=="EC"),]

#for choosing specific subsets
PowerO1<-subset(Power2, chan==("O1"),select=c(PID,Session,Responder,alpha))

#O1 
PowerO1_summary <- PowerO1 %>% group_by(Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(alpha, na.rm = TRUE),##
    sd = sd(alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

PowerO1_summary$x<-c("Baseline","Post-Treatment")
PowerO1_summary


SE1_R<-PowerO1[PowerO1$Session=="SE1"]
SE2_R<-PowerO1[PowerO1$Session=="SE2"]
t.test(SE1_R$alpha, SE2_R$alpha, paired=T)

madrs<-fread("MADRS.csv")
se1<-fread("SE1.csv")

p1<- ggplot(PowerO1_summary, aes(x=x, y=mean))+ 
  geom_bar(stat="identity", color="black", fill="grey50", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "Timepoint",y = "Occipital Alpha Power (μv^2)")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,35),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))

p2<- ggplot(madrs,aes(alpha_diffF6, Percent_imp)) +
  stat_summary(fun.data=mean_cl_normal) + 
  geom_smooth(method='lm', formula= y~x, color="black") +
  labs(x= "Alpha Power (μv^2) at F6",y = "Percent Improvement in MADRS")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  coord_cartesian(xlim=c(-5,25), ylim=c(-50,100),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))


p3<- ggplot(madrs,aes(alpha_diff, Percent_imp)) +
  stat_summary(fun.data=mean_cl_normal) + 
  geom_smooth(method='lm', formula= y~x, color="black") +
  labs(x= "Alpha Power (μv^2) at O1",y = "Percent Improvement in MADRS")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  coord_cartesian(xlim=c(-5,25), ylim=c(-50,100),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))

ggsave("Fig2A.png", p1, width=5, height=5, units="in")