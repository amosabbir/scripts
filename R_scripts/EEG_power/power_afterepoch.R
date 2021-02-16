setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)

Baseline_EC_afterepoch<-fread("Baseline_EC_afterepoch.csv")

#for choosing specific subsets
dfF3<-subset(Baseline_EC_afterepoch, Channel==("F3"))
dfF4<-subset(Baseline_EC_afterepoch, Channel==("F4"))
#df1<-rbind(dfF3,dfF4)

#F3 baseline
df_F3<-subset(dfF3,SE1_SE2=="1",select=c(EO1_EC2,SE1_SE2,Responder,Alpha))
df_F3_summary <- df_F3 %>% group_by(EO1_EC2,Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Alpha, na.rm = TRUE),##
    sd = sd(Alpha, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

df_F3_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_F3_summary


p_F3<- ggplot(df_F3_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Total Power")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(0,5),expand=F)#
  ggsave("p_F3.png", width=6, height=6)

