setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/Raw_data_Statistics/EEG")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

stats<-fread("Power_total.csv")
stats<-subset(stats, Session==1 | Session==2)

chan<-c("Fp1","Fp2","F3","F4","C3","C4","P3","P4","O1","O2")
EOC<-c(1,2)
wave<-c("alpha","beta","theta","delta","gamma","slow","gamma2","gamma3","gamma4","total")

setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/Raw_data_Statistics/EEG/All_graphs")

for (x in 1:10) {
	print(x)
	dfP4<-subset(stats, Channel==(chan[x]))
	
	for (y in 1:2){
		print(y)
		df_P4<-subset(dfP4,EO1_EC2==EOC[y])
		
		for (z in 1:10){
		print(z)
		df_P4_summary <- df_P4 %>% group_by(Group,Session) %>%##
		  summarise(##
    		count = n(),##
    		mean = mean(get(wave[z]), na.rm = TRUE),##
    		sd = sd(get(wave[z]), na.rm = TRUE),
    		se = sd/(sqrt(count))##
  					)
  		
  		p<-ggplot(df_P4_summary, aes(x=Session, y=mean, group = Group, 			color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), 						width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "Power")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
     
     rm_P4<-summary(aov(get(wave[z]) ~ Group * Session + Error(PID/Session), 			data=df_P4))
		print(rm_P4)
  	
  	name<-paste(EOC[y],chan[x],wave[z],".png",sep="_")
  	print(name)
  	ggsave(name, p, width=5, height=5, units="in")		
		}
	}
}