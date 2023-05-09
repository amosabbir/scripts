nih_PicSeq$Value<-as.numeric(nih_PicSeq$Value)
# Change colors
p<-ggplot(nih_PicSeq, aes(x=Value)) + 
  geom_histogram(color="black", fill="grey", binwidth=10)+
  geom_vline(aes(xintercept=mean(Value)), color="blue", linetype="dashed", size=1)+
  theme_classic()
p


nih_PicSeq$Value<-as.numeric(nih_PicSeq$Value)
p<-ggplot(nih_PicSeq, aes(x=Value)) + 
 geom_histogram(aes(y=..density..), colour="black", fill="white", binwidth=10)+
 geom_density(alpha=.2, fill="#FF6666") + 
 labs(x= "Normalized, age-adjusted,\n percentile score",y = "Population Density")+
 scale_color_grey() + 
 theme_classic(base_size=10)+
 ggtitle("Early Childhood Composition") +
 theme(plot.title = element_text(hjust = 0.5))+
 coord_cartesian(xlim=c(-10,110),ylim=c(0,0.03),expand=F) +
 theme(plot.margin=unit(c(1,1,1,1), "cm"))
p 

ggsave("PicSeq.png", p, width=3, height=3, units="in")


t.test(nih_PicSeq$Value, mu = 50)

#-- correlation of days vs. cognitive


nih_PicSeq$Value<-as.numeric(nih_PicSeq$Value)
nih_PicSeq$Days<-test$Days

p<-ggplot(nih_PicSeq, aes(x=Days, y=Value)) +
geom_point()+
geom_smooth(method=lm)+
labs(x="Number of Days since positive", y = "Normalized, Age Adjusted\n Percentile Score")+
scale_color_grey(start=0, end=0.9)+
theme_classic(base_size=8) +
ggtitle("PicSeq Test")+
theme(plot.title = element_text(hjust = 0.5))+
coord_cartesian(xlim=c(0,1000),ylim=c(-10,110),expand=F) +
theme(plot.margin=unit(c(1,1,1,1), "cm"))
p

ggsave("PicSeq_corr.png", p, width=3, height=3, units="in")




plot(nih_PicSeq$Day,nih_PicSeq$Value)
abline(lm(nih_PicSeq$Value ~ nih_PicSeq$Day))


corr <- lm(Value ~ Day, data = nih_PicSeq)
summary(corr)


#CSCI

nih[CI=="CSCI" & Group=="Treatment",]$Group2<-"Treat_CSCI"
nih[CI=="CSCI" & Group=="Control",]$Group2<-"Control_CSCI"
nih[CI=="Non" & Group=="Treatment",]$Group2<-"Treat_Non"
nih[CI=="Non" & Group=="Control",]$Group2<-"Control_Non"

nih_PicVoc<-subset(nih,TestName=="PicVoc_2")
nih_Flank<-subset(nih,TestName=="Flank_2")
nih_ListSort<-subset(nih,TestName=="ListSort_2")
nih_DCCS<-subset(nih,TestName=="DCCS_2")
nih_PatCom<-subset(nih,TestName=="PatCom_2")
nih_PicSeq<-subset(nih,TestName=="PicSeq_2")
nih_OralRead<-subset(nih,TestName=="OralRead_2")
nih_FluidComp<-subset(nih,TestName=="FluidComp")
nih_CrysComp<-subset(nih,TestName=="CrysComp")
nih_TotComp<-subset(nih,TestName=="TotComp")
nih_ECComp<-subset(nih,TestName=="ECComp")


Flank_summary <- nih_Flank %>% group_by(CI) %>%##
  summarise(##
    count = n(),##
    mean = mean(as.numeric(Value), na.rm = TRUE),##
    sd = sd(as.numeric(Value), na.rm = TRUE),
    se = sd/(sqrt(count))##
  )
Flank_summary


Flank_<- ggplot(Flank_summary, aes(x=CI, y=mean, fill=CI))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Value")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  #coord_cartesian(ylim=c(0,10),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))+
  ggtitle("Flank test at baseline")
Flank_  

ggsave("Flank_CSCI_baseline.png", Flank_, width=5, height=5, units="in")

t.test(as.numeric(nih_Flank[CI=="CSCI",]$Value), as.numeric(nih_Flank[CI=="Non",]$Value), paired=F)

 