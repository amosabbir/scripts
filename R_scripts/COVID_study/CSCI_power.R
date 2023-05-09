setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/EEG_analysis/Relative")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

All_stats<-fread("All_stats_relative.csv")

#for choosing specific subsets
dfF4<-subset(All_stats, Channel==("F4"))

#F4 baseline
df_F4<-subset(dfF4,EO1_EC2==1)
df_F4<-subset(dfF4,Session==1)

df_F4_summary <- df_F4 %>% group_by(Cog) %>%##
  summarise(##
    count = n(),##
    mean = mean(alpha, na.rm = TRUE),##
    sd = sd(alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

#df_F4_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_F4_summary


p<- ggplot(df_F4_summary, aes(x=Cog, y=mean, fill=Cog))+ 
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
  position=position_dodge(.9))+
  labs(x= "",y = "Value")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
  coord_cartesian(ylim=c(0,0.1),expand=F)+
  theme(plot.margin=unit(c(1,1,1,1), "cm"))+
  ggtitle("F4_EO_alpha")

p


ggsave("CSCI_EO_F4_alpha.png", p, width=5, height=5, units="in")