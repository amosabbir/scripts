library(stringr)
name<-list.files("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/Welltory/Raw_data")

matrix<-welltory[0,]

for(i in 1:20) {
setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/Welltory/Raw_data")
print(name[i])
welltory<-fread(name[i])
PID<-sub(".csv","",name[i])
welltory$PID<-PID
names(welltory)<-str_replace_all(names(welltory), c(" " = "_" ))


lookup <- c(Stress="Stress_(HRV)", Energy="Energy_(HRV)")
welltory<-welltory %>% rename(any_of(lookup))

treatment<-c(1,5,6,9,10,7,13,14,16,15)
control<-c(2,3,11,12,17,18,19,20,21,22)

if (read.table(text = name[i], sep = "_")[[2]] %in% treatment){
welltory$Group<-"Treatment"	
}

if (read.table(text = name[i], sep = "_")[[2]] %in% control){
welltory$Group<-"Control"		
}

#If taking difference
#welltory<-welltory %>%
#  group_by(PID,Group,Day) %>%
#  filter(Timepoint %in% c(1, 2)) %>%
#  summarise(##
#    Stress = diff(Stress),##
#    Energy = diff(Energy),
#    Focus = diff(Focus),
#    Measurement_HR = diff(Measurement_HR),
#    SDNN = diff(SDNN)##
#  )
#matrix<-rbind(matrix, welltory)


#If doing long term
welltory<-welltory[, c("PID", "Group", "Day","Timepoint", "Stress", "Energy", "Focus", "Measurement_HR", "SDNN")]
  

welltory2<-welltory %>%
  group_by(PID,Group) %>%
  filter(Timepoint == 1 & Day >= 1 & Day <= 28) %>%
  summarise(##
    Stress = mean(Stress),##
    Energy = mean(Energy),
    Focus = mean(Focus),
    Measurement_HR = mean(Measurement_HR),
    SDNN = mean(SDNN)##
  )
welltory2$Session<-"A"  


welltory3<-welltory %>%
  group_by(PID,Group) %>%
  filter(Timepoint == 1 & Day >= 22 & Day <=28) %>%
  summarise(##
    Stress = mean(Stress),##
    Energy = mean(Energy),
    Focus = mean(Focus),
    Measurement_HR = mean(Measurement_HR),
    SDNN = mean(SDNN)##
  )
welltory3$Session<-"B"
  

matrix<-rbind(matrix, welltory2, welltory3)

}


Stress_summary <- matrix %>% group_by(Group,Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Stress), na.rm = TRUE),##
    sd = sd(as.numeric(Stress), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Stress_summary

Stress_graph<-ggplot(Stress_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Stress")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("First Week", "Last Week"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
Stress_graph

#ggsave("Stress_Long.png", Stress_graph, width=5, height=5, units="in")

rm_Stress<-summary(aov(Stress ~ Group * Session + Error(PID/Session), data=matrix))
rm_Stress



  