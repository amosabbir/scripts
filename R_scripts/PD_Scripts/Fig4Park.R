#Arise from chair
U_Arise_from_Chair<-U[,c(1:3,26)]
df<-group_by(U_Arise_from_Chair,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Arise_from_Chair, na.rm = TRUE),#
    sd = sd(Arise_from_Chair, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Arise from Chair")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=15)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    

#Postural Stability
U_Postural_stability<-U[,c(1:3,29)]
df<-group_by(U_Postural_stability,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Postural_stability, na.rm = TRUE),#
    sd = sd(Postural_stability, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p2<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Postural Stability")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=15)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
    
#Body Bradykinesia
U_Body_bradykinesia<-U[,c(1:3,30)]
df<-group_by(U_Body_bradykinesia,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Body_bradykinesia, na.rm = TRUE),#
    sd = sd(Body_bradykinesia, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p3<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Body Bradykinesia")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=15)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
    
#Gait
#Gait
U_Gait<-U[,c(1:3,28)]
df<-group_by(U_Gait,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Gait, na.rm = TRUE),#
    sd = sd(Gait, na.rm = TRUE)#
  )
df 
df$se<-df$sd/sqrt(df$count)
df$Group[df$Group=="A"]<- "Treatment"
df$Group[df$Group=="B"]<- "Control"


p4<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Body Bradykinesia")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=15)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
    
#corner labels

p <- arrangeGrob(p, top = grid.text("A", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
p2 <- arrangeGrob(p2, top = grid.text("B", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
p3 <- arrangeGrob(p3, top = grid.text("C", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
p4 <- arrangeGrob(p4, top = grid.text("D", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
 Fig4<-grid.arrange(p,p2,p3,p4, nrow=2, ncol=2)

 ggsave("Fig4.png", Fig4, width=10, height=8, units="in")
 