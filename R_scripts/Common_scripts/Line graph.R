#updated density graph
p2<-qplot(Difference, data = UU, geom = "density",
color = Group, linetype = Group)+
scale_color_grey(start=0, end=0.5)+
theme_classic(base_size=10)+
scale_x_continuous(limits=c(-8, 20)) +
labs(x="Difference", y = "Density")+
coord_cartesian(xlim=c(-5,15), ylim=c(0,0.1),expand=F)+
theme(plot.margin=unit(c(1,1,1,1), "cm"))
ggsave("Fig1B.png", width=8, height=6,dpi=300)




#line graph
p3<-ggplot(UUUA, aes(x=Assessment, y=Score, group=CODE, colour=Difference)) +
  geom_line(aes(group=CODE)) +
  geom_point()+
  scale_colour_grey(start=0.2, end=0.9) +
  ylim(0,45)+
  labs(x="Timepoint", y = "UPDRS Motor Score (Treatment)")+
  theme_classic(base_size=10)+ 
  scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))
  ggsave("Fig1C.png", width=8, height=6,dpi=300)
  

#line graph of the means
p <- ggplot(df1, aes(x=Assessment, y=mean, group = Group, color=Group))+ 
    geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "UPDRS Motor Score")+
    scale_color_grey(start=0, end=0.9)+
    theme_classic(base_size=10)+
    scale_x_discrete("Timepoint", labels=c("Week 0", "Week 12"))+
    theme(plot.margin=unit(c(1,1,1,1), "cm")) 
    ggsave("Fig1A.png", width=8, height=6)


#summarize function for total line graph
library("dplyr")#
df1<-group_by(UT, Group, Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Score, na.rm = TRUE),#
    sd = sd(Score, na.rm = TRUE)#
  )




#scatter plot

p3<-ggplot(UUB, aes(x=Week_0, y=Difference))+
  geom_point(size=2)+
  labs(x="Baseline UPDRS Score (Treatment)", y = "Change in UPDRS Score")+
    scale_color_grey(start=0.4, end=0.6)+
    geom_smooth(method=lm, se=FALSE, color="black")+   
    theme_classic(base_size=10)+
    theme(legend.position="right")+
    scale_x_continuous(name="Baseline UPDRS Score (Control)", limits=c(9, 45))+
  scale_y_continuous(name="Change in UPDRS Score", limits=c(-10,20))+
  geom_vline(data=df_lines[2:3,],aes(xintercept=y,color=Legend, linetype=Legend))+
    geom_hline(data=df_lines[1,],aes(yintercept=y, color=Legend, linetype=Legend))+
  theme(plot.margin=unit(c(1,1,1,1), "cm")) 
ggsave("Fig2D.png", width=8, height=6)  
  
  
df_lines <- data.frame(type = factor(c("yintercept", "xintercept", "xintercept")), y = c(3.4, 17.4, 24.7), Legend = as.character(c("Mean_Difference_Control", "Mean_Baseline_Non_Responders", "Mean_Baseline_Responders")))  

geom_hline(data = df_lines[1, ], aes(yintercept = y, linetype = Legend)) +
  geom_vline(data = df_lines[2:3, ], aes(xintercept = y, linetype = Legend), show.legend = F)
  
  
  
  
  
p<-ggplot(UUB, aes(x=Week_0, y=Difference)) +
  geom_point(size=2)+
  scale_x_continuous(name="Baseline UPDRS motor score (Control)", limits=c(10, 45)) +
  scale_y_continuous(name="Difference", limits=c(-5,20)) +
    scale_color_grey()+
    geom_smooth(method=lm, se=FALSE, color="black")+
    theme_classic(base_size=10)  
  
line_lm = lm(Difference ~ Week_0, data=UUA)
  
  
  
  
#density plot  
p<-qplot(Difference, data = UU, geom = "density", linetype = Group)+
scale_color_grey()+
theme_classic(base_size=10)+
scale_x_continuous(limits=c(-8, 20)) +
labs(x="Difference", y = "Density")+
coord_cartesian(xlim=c(-5,15), ylim=c(0,0.1),expand=F)+
theme(legend.spacing.y=unit(5, "mm"))
ggsave("Fig1B2.png", width=8, height=6)
  
  
#bar graph
p<- ggplot(d2, aes(x=New_Group, y=mean, fill=New_Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x="Baseline Timepoint", y = "UPDRS Motor Score")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=10)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(0.5,3.5), ylim=c(0,45),expand=F)  
  ggsave("Fig2B.png", width=6, height=6)             
  
  

#order bars
a <- within(a,Group <- factor(Group, levels=names(sort(table(Group), decreasing=TRUE))))


#bar graph
p<- ggplot(a, aes(x=reorder(Group, Percentage), y=Percentage, fill=Group))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  labs(x="Side of the body", y = "Number of significant findings (%)")+
  scale_fill_grey()+
  theme_classic(base_size=10)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(xlim=c(0.5,3.5), ylim=c(0,100),expand=F) 
  ggsave("Fig3I.png", width=6, height=6)     
  
  