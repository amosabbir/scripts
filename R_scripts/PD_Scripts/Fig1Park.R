p2<-qplot(Difference, data = UU, geom = "density",
color = Group, linetype = Group)+
scale_color_grey(start=0, end=0.6)+
theme_classic(base_size=15)+
scale_x_continuous(limits=c(-8, 20)) +
labs(x="Difference", y = "Density")+
coord_cartesian(xlim=c(-5,15), ylim=c(0,0.1),expand=F)+
theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
 

p4<-ggplot(UUUB, aes(x=Assessment, y=Score, group=CODE, colour=Difference)) +
 geom_line(aes(group=CODE)) +
 geom_point()+
 geom_line(data=UUUBN, aes(), group=UUUBN$CODE, color="black") +
 geom_point(data=UUUBN, aes(), group=UUUBN$CODE, color="black") +
   scale_colour_grey(start=0, end=0.9) +
   ylim(0,45)+
   labs(x="Timepoint", y = "UPDRS Motor Score (Control)")+
   theme_classic(base_size=15)+ 
   scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))
 p3<-ggplot(UUUA, aes(x=Assessment, y=Score, group=CODE, colour=Difference)) +
   geom_line(aes(group=CODE)) +
   geom_point()+
   geom_line(data=UUUAN, aes(), group=UUUAN$CODE, color="black") +
   geom_point(data=UUUAN, aes(), group=UUUAN$CODE, color="black") +
   scale_colour_grey(start=0, end=0.9) +
   ylim(0,45)+
   labs(x="Timepoint", y = "UPDRS Motor Score (Treatment)")+
   theme_classic(base_size=15)+ 
   scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))


 p <- ggplot(df1, aes(x=Assessment, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "UPDRS Motor Score")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
 grid.arrange(p,p2,p3,p4, nrow=2, ncol=2)


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



 Fig1<-grid.arrange(p,p2,p3,p4, nrow=2, ncol=2)

 ggsave("Fig1.png", Fig1, width=10, height=8, units="in")
