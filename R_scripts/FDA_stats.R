setwd("/Users/abdullahmosabbir/Desktop/KKT_working_directory/FDA_Study")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


kkt<-fread("FDA_Sonar_results.csv")

kkt2<-kkt[,c(1,3,8,84,85)]
kkt2<-kkt2[!(RM1=="na"),]
kkt3<-gather(kkt2, "Timepoint", "Score", 4:5)
kkt3$Score1<-as.numeric(kkt3$Score)

ez_outcome <- ezANOVA(
  data = kkt3,
  dv = .(Score1),
  wid = .(PID),
  within = .(Timepoint),
  between = .(Group),
  type = 3)
  
VAS00<-subset(kkt3,Timepoint=="RM1" & Group=="Abdomen")
VAS06<-subset(kkt3,Timepoint=="RM2" & Group=="Abdomen")
VAS12<-subset(kkt3,Timepoint=="T12_VAS" & Group=="Abdomen")

t.test(VAS00$Score1, VAS06$Score1, paired=T)
t.test(VAS00$Score, VAS12$Score, paired=T)
t.test(VAS06$Score, VAS12$Score, paired=T)


VAS_summary <- kkt3 %>% group_by(Timepoint) %>%##
  summarise(##
    count = n(),##
    mean = mean(Score, na.rm = TRUE),##
    sd = sd(Score, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

VAS_summary$x<-c("VAS_00","VAS_12","VAS_06")
VAS_summary


VAS_summary <- kkt3 %>% group_by(Group,Timepoint) %>%##
  summarise(##
    count = n(),##
    mean = mean(Score, na.rm = TRUE),##
    sd = sd(Score, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

VAS_summary<-subset(VAS_summary, Group=="Skull")
VAS_summary$x<-c("VAS_00","VAS_12","VAS_06")
VAS_summary


p<-ggplot(VAS_summary, aes(x=Timepoint, y=mean, group=Group)) +
 geom_point(size=2)+
 geom_line(size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,10)+
   labs(x="", y = " VAS Score \n Skull Stimulation")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Pre-treatment", "Post-treatment 6", "Post-treatment 12"))+
    theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("VAS_Skull.png", p, width=4, height=5, units="in")  


#VAS change

kkt<-fread("a.csv")
kkt2<-kkt[,c(1,3,7,8,9,10,11,12,13)]
kkt2<-kkt2[!(RM_perc_change=="NaN"),]
kkt2<-as.data.frame(kkt2)

VAS_summary <- kkt2 %>% group_by(Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(RM1), na.rm = TRUE),##
    sd = sd(as.numeric(RM2), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

VAS_summary

p1<- ggplot(VAS_summary, aes(x=Group, y=mean, fill=Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Percent improvement of Pain Intensity")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,100),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  
ggsave("VAS_improvement.png", p1, width=4, height=5, units="in") 



#RM one group

kkt2<-kkt[,c(1,3,8,84,85)]
kkt3<-gather(kkt2, "Timepoint", "Score", 4:5)

kkt3<-kkt3[!(kkt3$Score=="na"),]

R_1<-kkt3[kkt3$Timepoint=="RM1",]
R_2<-kkt3[kkt3$Timepoint=="RM2",]
t.test(as.numeric(R_1$Score), as.numeric(R_2$Score), paired=T)

as.numeric(kkt3$score)
RM_summary <- kkt3 %>% group_by(Timepoint,Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Score), na.rm = TRUE),##
    sd = sd(as.numeric(Score), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

RM_summary<-subset(RM_summary, Group=="Abdomen")
RM_summary$x<-c("RM1","RM2")
RM_summary


p<-ggplot(RM_summary, aes(x=x, y=mean, group=1)) +
 geom_point(size=2)+
 geom_line(size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,20)+
   labs(x="", y = " RM Score \n Abdomen Stimulation ")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Pre-treatment", "Post-treatment"))+
    theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("RM_Abdomen.png", p, width=4, height=5, units="in") 

#Pelvic and pelvic tilt
grep("pelvic",colnames(kkt))
kkt2<-kkt[,c(1,3,8,13,25,37,49,61,73)]
kkt3<-gather(kkt2, "Timepoint", "Tilt",4:9)

kkt3$abs_tilt<-abs(kkt3$Tilt)

ez_outcome <- ezANOVA(
  data = kkt3,
  dv = .(abs_tilt),
  wid = .(PID),
  within = .(Timepoint),
  between = .(Group),
  type = 3)
  

Pelvic_summary <- kkt3 %>% group_by(Timepoint,Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(abs_tilt, na.rm = TRUE),##
    sd = sd(abs_tilt, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

Pelvic_summary<-subset(Pelvic_summary, Group=="Joint")
Pelvic_summary$x<-c("T1","T3","T2","T1","T3","T2")
Pelvic_summary$Stim<-c("Before","Before","Before","After","After","After")
Pelvic_summary


p<-ggplot(Pelvic_summary, aes(x=x, y=mean, group=Stim)) +
 geom_point(aes(shape=Stim), size=2)+
 geom_line(aes(linetype=Stim), size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,2.0)+
   labs(x="", y = " Absolute Pelvic tilt (degrees) ")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Treatment 1", "Treatment 6", "Treatment 12"))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))+
    ggtitle("Pelvic Tilt: Joint Stimulation")+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("Pelvic_Joint.png", p, width=5, height=5, units="in")


#LLS stats

grep("LLS",colnames(kkt))
kkt2<-kkt[,c(1,3,8,20,34,48,62,76,90)]
colnames(kkt2)[4]<-"a1"
kkt2<-kkt2[kkt2$a1<4.5,]
colnames(kkt2)[4]<-"1T0_LLS"

kkt3<-gather(kkt2, "Timepoint", "LLS",4:9)

kkt3$abs_LLS<-abs(kkt3$LLS)

ez_outcome <- ezANOVA(
  data = kkt3,
  dv = .(abs_LLS),
  wid = .(PID),
  within = .(Timepoint),
  between = .(Group),
  type = 3)
  

Pelvic_summary <- kkt3 %>% group_by(Timepoint,Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(abs_LLS, na.rm = TRUE),##
    sd = sd(abs_LLS, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

Pelvic_summary<-subset(Pelvic_summary, Group=="Back")
Pelvic_summary$x<-c("T1","T3","T2","T1","T3","T2")
Pelvic_summary$Stim<-c("Before","Before","Before","After","After","After")
Pelvic_summary


p<-ggplot(Pelvic_summary, aes(x=x, y=mean, group=Stim)) +
 geom_point(aes(shape=Stim), size=2)+
 geom_line(aes(linetype=Stim), size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,5.0)+
   labs(x="", y = " Strength Value ")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Treatment 1", "Treatment 6", "Treatment 12"))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))+
    ggtitle(" Lower limb strength:\n Spine Stimulation")+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("LLS_Back.png", p, width=5, height=5, units="in")



grep("CROMR",colnames(kkt))
kkt2<-kkt[,c(1,3,8,22,36,50,64,78,92)]
colnames(kkt2)[4]<-"a1"
colnames(kkt2)[8]<-"a2"

kkt2<-subset(kkt2, Group=="Abdomen")
kkt3<-gather(kkt2, "Timepoint", "LLS",4:9)


p<-ggplot(data.frame(kkt2$a2), aes(x=kkt2$a2)) +
geom_bar(color="black") +
  labs(x= "",y = "Count")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  coord_cartesian(ylim=c(0,10),expand=F)+
  scale_x_discrete(limits=c("Normal", "Mild", "Mod","Severe"))+
   ggtitle(" Post Treatment ROM Right \n Abdomen Stimulation")+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))

ggsave("CROMR_abdomen2.png", p, width=5, height=5, units="in")

  
  
  
  
#Tender Spots

grep("1T12_Tender",colnames(kkt))
kkt2<-kkt[,c(1,3,8,23,24,25,79,80,81)]

kkt3<-gather(kkt2, "Timepoint", "LLS",5:10)

kkt3$abs_LLS<-abs(kkt3$LLS)

ez_outcome <- ezANOVA(
  data = kkt3,
  dv = .(abs_LLS),
  wid = .(PID),
  within = .(Timepoint),
  #between = .(Group),
  type = 3)
  

Pelvic_summary <- kkt3 %>% group_by(Timepoint,Group) %>%##
  summarise(##
    count = n(),##
    mean = mean(abs_LLS, na.rm = TRUE),##
    sd = sd(abs_LLS, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

Pelvic_summary<-subset(Pelvic_summary, Group=="Abdomen")
Pelvic_summary$x<-c("T3","T3","T1","T1","T2","T2")
Pelvic_summary$Stim<-c("Before (pre T1)","After (pre T12)","Before (pre T1)","After (pre T12)","Before (pre T1)","After (pre T12)")
Pelvic_summary


p<-ggplot(Pelvic_summary, aes(x=x, y=mean, group=Stim)) +
 geom_point(aes(shape=Stim), size=2)+
 geom_line(aes(linetype=Stim), size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,30.0)+
   labs(x="", y = " Tender Spot (count) ")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Red", "Yellow", "Green"))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))+
    ggtitle(" Tender Spot Change: Abdomen Stimulation")+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("Tender_abdomen.png", p, width=5, height=5, units="in")

  
