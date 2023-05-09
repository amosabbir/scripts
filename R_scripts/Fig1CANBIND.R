library(png)
setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(grid)

library(ggplot2)
library(gridExtra)

madrs1<-fread("MADRS.csv")

madrs2<-fread("madrs2.csv")
p<-ggplot(madrs2, aes(x=Session, y=mean, group=1)) +
 geom_point(size=2)+
 geom_line(size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,45)+
   labs(x="Timepoint", y = "MADRS Score")+
   theme_classic(base_size=15)+ 
   scale_x_discrete("Timepoint", labels=c("Before", "After"))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
   
	
library(tidyr)
madrs3<-madrs1[,c(1:4,7)]
colnames(madrs3)<-c("PID","Patient_ID","A","B","Responder")
madrs3<-gather(madrs3,Timepoint,Score,A:B)

p2<-ggplot(madrs3, aes(x=Timepoint, y=Score, group=PID, colour=Responder)) +
 #geom_line(aes(group=PID)) +
 geom_point(size=2)+
 geom_line(size=0.8) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,45)+
   labs(x="Timepoint", y = "MADRS Score")+
   theme_classic(base_size=15)+ 
   scale_x_discrete("Timepoint", labels=c("Before", "After"))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
   
p3<-ggplot(madrs1, aes(x=Percent_imp)) +
	geom_density(size=1) +
	scale_color_grey(start=0, end=0.6)+
	theme_classic(base_size=15)+
	scale_x_continuous(limits=c(-20, 100)) +
	ylim(0,0.0125)+
	labs(x="Percentage improvement in MADRS", y = "Population Density")+
	geom_vline(aes(xintercept=50), linetype="dashed", size=0.5) +
	theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))   
	
	
p4<- hist(madrs1$Percent_imp,
breaks=11,
main="Change in Depression severity",
xlab="Percent improvement in MADRS",
xlim=c(-20,100),
col="grey",
freq=T
)
 
   
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



 Fig1<-grid.arrange(p,p2,p3, nrow=1, ncol=3)

 ggsave("Fig1.png", Fig1, width=15, height=5, units="in")
