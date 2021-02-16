#bar graph
p<- ggplot(a, aes(x=reorder(Group, Percentage), y=Percentage, fill=Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  labs(x="Side of the body", y = "Number of significant findings (%)")+
  scale_fill_grey()+
  theme_classic(base_size=12)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(0.5,3.5), ylim=c(0,100),expand=F)+
  theme(plot.margin=unit(c(0.5,2,0.5,2), "cm"))  
  
#action tremor
U_Action_Tremor__left<-U[,c(1:3,12)]
df<-group_by(U_Action_Tremor__left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Action_Tremor__left, na.rm = TRUE),#
    sd = sd(Action_Tremor__left, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p2<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Action Tremor (Left)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    

#resting tremor feet
U_Feet__right<-U[,c(1:3,9)]
df<-group_by(U_Feet__right,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Feet__right, na.rm = TRUE),#
    sd = sd(Feet__right, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p3<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Resting Tremor Feet (Right)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
#lower extremity right
U_Lower_Extremity__right<-U[,c(1:3,16)]
df<-group_by(U_Lower_Extremity__right,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Lower_Extremity__right, na.rm = TRUE),#
    sd = sd(Lower_Extremity__right, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p4<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Lower Extremity (Right)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
#Lower extremity left
U_Lower_Extremity__left<-U[,c(1:3,17)]
df<-group_by(U_Lower_Extremity__left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Lower_Extremity__left, na.rm = TRUE),#
    sd = sd(Lower_Extremity__left, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p5<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Lower Extremity (Left)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

#Finger taps right
U_Finger_taps__right<-U[,c(1:3,18)]
df<-group_by(U_Finger_taps__right,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Finger_taps__right, na.rm = TRUE),#
    sd = sd(Finger_taps__right, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p6<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Finger Taps (Right)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
#Finger taps left
U_Finger_taps__left<-U[,c(1:3,19)]
df<-group_by(U_Finger_taps__left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Finger_taps__left, na.rm = TRUE),#
    sd = sd(Finger_taps__left, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p7<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Finger Taps (Left)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    

#Hand grips left
U_Hand_grips__left<-U[,c(1:3,21)]
df<-group_by(U_Hand_grips__left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Hand_grips__left, na.rm = TRUE),#
    sd = sd(Hand_grips__left, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p8<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Hand Grips (Left)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
#Hand prosupp left
U_Hand_prosup_left<-U[,c(1:3,23)]
df<-group_by(U_Hand_prosup_left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Hand_prosup_left, na.rm = TRUE),#
    sd = sd(Hand_prosup_left, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p9<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Hand Grips (Left)")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=12)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    


#corner labels

p <- arrangeGrob(p, top = grid.text("A", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p2 <- arrangeGrob(p2, top = grid.text("B", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p3 <- arrangeGrob(p3, top = grid.text("C", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p4 <- arrangeGrob(p4, top = grid.text("D", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p5 <- arrangeGrob(p5, top = grid.text("E", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p6 <- arrangeGrob(p6, top = grid.text("F", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p7 <- arrangeGrob(p7, top = grid.text("G", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
p8 <- arrangeGrob(p8, top = grid.text("H", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))

p9 <- arrangeGrob(p9, top = grid.text("I", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=15)))
         
 Fig3<-grid.arrange(p,p2,p3,p4,p5,p6,p7,p8,p9, nrow=3, ncol=3)

 ggsave("Fig3.png", Fig3, width=12, height=10, units="in")



