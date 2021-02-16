p <- ggplot(d, aes(x=Assessment, y=mean, group = Group, color=Group))+ 
    geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "UPDRS Motor Score")+
    scale_color_grey(start=0, end=0.9)+
    theme_classic(base_size=15)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(1,1,1,1), "cm")) 
    

p2<- ggplot(d2, aes(x=New_Group, y=mean, fill=New_Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x="Baseline Timepoint", y = "UPDRS Motor Score")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(0.5,3.5), ylim=c(0,45),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  
  
p3<-ggplot(UUA, aes(x=base, y=diff))+
  geom_point(size=2)+
  labs(x="Baseline UPDRS Score (Treatment)", y = "Change in UPDRS Score")+
    scale_color_grey(start=0.4, end=0.6)+
    geom_smooth(method=lm, se=FALSE, color="black")+   
    theme_classic(base_size=15)+
    theme(legend.position="right")+
    scale_x_continuous(name="Baseline UPDRS Score (Treatment)", limits=c(9, 45))+
  scale_y_continuous(name="Change in UPDRS Score", limits=c(-10,20))+
  geom_vline(data=df_lines[2:3,],aes(xintercept=y,color=Legend, linetype=Legend))+
    geom_hline(data=df_lines[1,],aes(yintercept=y, color=Legend, linetype=Legend))+
  theme(plot.margin=unit(c(1,1,1,1), "cm")) 
  
p4<-ggplot(UUB, aes(x=Week_0, y=Difference))+
  geom_point(size=2)+
  labs(x="Baseline UPDRS Score (Control)", y = "Change in UPDRS Score")+
    scale_color_grey(start=0.4, end=0.6)+
    geom_smooth(method=lm, se=FALSE, color="black")+   
    theme_classic(base_size=15)+
    theme(legend.position="right")+
    scale_x_continuous(name="Baseline UPDRS Score (Control)", limits=c(9, 45))+
  scale_y_continuous(name="Change in UPDRS Score", limits=c(-10,20))+
  geom_vline(data=df_lines[2:3,],aes(xintercept=y,color=Legend, linetype=Legend))+
    geom_hline(data=df_lines[1,],aes(yintercept=y, color=Legend, linetype=Legend))+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))    
  
  
#set corner labels
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



 q<-grid.arrange(p,p2,p3,p4, nrow=2, ncol=2)

 ggsave("Fig2.png", q, width=12, height=10, units="in")
  