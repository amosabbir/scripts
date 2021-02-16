p<- ggplot(a, aes(x=reorder(Group, Percentage), y=Percentage, fill=Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  labs(x="Side of the body", y = "Number of significant findings (%)")+
  scale_fill_grey()+
  theme_classic(base_size=12)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(0.5,3.5), ylim=c(0,100),expand=F)+
  theme(plot.margin=unit(c(0.5,2,0.5,2), "cm"))  

p2<- ggplot(B3, aes(x=measure, y=mean, fill=side))+ 
  geom_bar(stat="identity", color="black", position=position_dodge(), width=0.8) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=0.2,
  position=position_dodge(.9))+
  labs(x="Baseline Score LvsR", y = "Score")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(), ylim=c(0,2),expand=F) 
  
p <- arrangeGrob(p, top = grid.text("A", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
p2 <- arrangeGrob(p2, top = grid.text("B", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
Fig5<-grid.arrange(p,p2, ncol=2, nrow=1, widths=1:2)

ggsave("Fig5.png", Fig5, width=12, height=8, units="in")