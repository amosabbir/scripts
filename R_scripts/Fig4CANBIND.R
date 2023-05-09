library(png)
setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(grid)
library(gridExtra)

madrs<-fread("MADRS.csv")
Power<-fread("Power_CANBIND2.csv")

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"

Power2<-Power[!(Power$EO_EC=="EC"),]

PowerF3<-subset(Power2, chan==("F3"),select=c(PID,Session,Responder,TCD))

#F3 
PowerF3_summary <- PowerF3 %>% group_by(Session,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(TCD, na.rm = TRUE),##
    sd = sd(TCD, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

PowerF3_summary$x<-c("Baseline_NR","Baseline_R","Post-Treatment_NR","Post-Treatment_R")

PowerF3_summary$x <- factor(PowerF3_summary$x, levels = c("Baseline_R" , "Post-Treatment_R" , "Baseline_NR" , "Post-Treatment_NR"))

PowerF3_summary



#-------------------------------------------


p1<- ggplot(PowerF3_summary, aes(x=x, y=mean, fill=Session))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Frontal TCD Power (μv^2)")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,2),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  

p2<- ggplot(madrs,aes(TCD_D_F3, Percent_imp)) +
  stat_summary(fun.data=mean_cl_normal) + 
  geom_smooth(method='lm', formula= y~x, color="black") +
  labs(x= "Frontal TCD Power (μv^2)",y = "Percent Improvement in MADRS")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  coord_cartesian(xlim=c(-1,0.5), ylim=c(-50,100),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))

         

q<-grid.arrange(p1,p2, nrow=1, ncol=2)

 ggsave("Fig44.png", q, width=10, height=5, units="in")
  