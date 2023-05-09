library(png)
setwd("/Users/abdullahmosabbir/Desktop/CANBIND")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(grid)


Power<-fread("Power_CANBIND2.csv")
Power<-Power[,c(1,2,3,4,5,135,136,137,138,139,140,141,143,144,145,146,147,148)]

Power$Session[which(Power$Session=="1")]<-"SE1"
Power$Session[which(Power$Session=="2")]<-"SE2"

Power2<-Power[!(Power$EO_EC=="EC"),]

PowerO1<-subset(Power2, chan==("O1"),select=c(PID,Session,Responder,alpha))

#O1 
PowerO1_summary <- PowerO1 %>% group_by(Session,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(alpha, na.rm = TRUE),##
    sd = sd(alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

PowerO1_summary$x<-c("Baseline_NR","Baseline_R","Post-Treatment_NR","Post-Treatment_R")

PowerO1_summary$x <- factor(PowerO1_summary$x, levels = c("Baseline_R" , "Post-Treatment_R" , "Baseline_NR" , "Post-Treatment_NR"))

PowerO1_summary



#-------------------------------------------


p1<- ggplot(PowerO1_summary, aes(x=x, y=mean, fill=Session))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Occipital Alpha Power (μv^2)")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,45),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  
p2<- ggplot(PowerFp2_summary, aes(x=x, y=mean, fill=Session))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Prefrontal Alpha Power (μv^2)")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,45),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))  
  
 
    
img <- readPNG("/Users/abdullahmosabbir/Desktop/CANBIND/topoplots/alpha_R_D.png")
g1 <- rasterGrob(img, interpolate=TRUE)
p2<-qplot() +
  annotation_custom(g1, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)


  
#set corner labels
p1 <- arrangeGrob(p, top = grid.text("A", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         
p2 <- arrangeGrob(p2, top = grid.text("B", x = unit(0, "npc")
         , y   = unit(1, "npc"), just=c("left","top"),
         gp=gpar(col="black", fontsize=20)))
         



q<-grid.arrange(p1,p2, nrow=2, ncol=1)

 ggsave("Fig2.png", q, width=5, height=10, units="in")
  