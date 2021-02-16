setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Data")
library(ggplot2)
library(dplyr)
library(data.table)

#for choosing specific subsets
df1<-subset(Baseline_EC, Channel==c("F3","F4"),select=ID:Total)

#choose either Baseline_EC or df1
df2 <- Baseline_EC %>% group_by(ID,EO1_EC2,SE1_SE2,Left_Right,Responder) %>% summarise_all(mean)#
as.data.frame(df2)
df2<-df2[,-6]
as.data.frame(df2)
df3<-df2[!(df2$SE1_SE2==2),]
as.data.frame(df3)
df_Total<-df3[,-c(3,6,7,8,9,10)]
df_Total
as.data.frame(df_Total)



df_Total_summary <- group_by(df_Total, EO1_EC2, Left_Right, Responder) %>%##
  summarise(##
    count = n(),##
    mean = mean(Total, na.rm = TRUE),##
    sd = sd(Total, na.rm = TRUE)##
  )
    

df_Total_summary$x<-c("EO_Left_NR","EO_Left_R","EO_Right_NR", "EO_Right_R", "EC_Left_NR", "EC_Left_R", "EC_Right_NR", "EC_Right_R")
df_Total_summary


p5<- ggplot(df_Total_summary, aes(x=x, y=mean, fill=Responder))+ #
  geom_bar(stat="identity", color="black", position=position_dodge()) +#
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,#
  position=position_dodge(.9))+#
  labs(x="Responder vs. Non-Responder", y = "Total Power")+#
  scale_fill_grey(start=0.3, end=0.9)+#
  theme_classic(base_size=10)+#
  theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+#
  coord_cartesian(ylim=c(0,100),expand=F)#
  ggsave("Fig_Total.png", width=6, height=6)

