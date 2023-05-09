setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/EEG_analysis/Relative")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

All_stats<-fread("All_stats_relative.csv")

#for choosing specific subsets
dfP4<-subset(All_stats, Channel==("P4"))

#P4 baseline
df_P4<-subset(dfP4,EO1_EC2==1)

df_P4_summary <- df_P4 %>% group_by(Group,Session) %>%##
  summarise(##
    count = n(),##
    mean = mean(delta, na.rm = TRUE),##
    sd = sd(delta, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

#df_P4_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
df_P4_summary


df_P4_graph<-ggplot(df_P4_summary, aes(x=Session, y=mean, group = Group, color=Group))+ 
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
     geom_line(aes(), size=1) + 
     geom_point(aes(shape=Group))+
     labs(x="Timepoint", y = "delta power at P4 (uv^2/Hz)")+
     scale_color_grey(start=0, end=0.9)+
     theme_classic(base_size=15)+
      ggtitle("delta Power Before vs. After (EO)") +
     scale_x_discrete("Timepoint", labels=c("Week 0", "Week 4"))+
     theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 
df_P4_graph

ggsave("delta_EO_P4_SE12.png", df_P4_graph, width=5, height=5, units="in") 


rm_df_P4<-summary(aov(delta ~ Group * Session + Error(PID/Session), data=df_P4))
rm_df_P4