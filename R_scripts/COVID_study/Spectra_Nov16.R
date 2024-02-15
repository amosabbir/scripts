setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative")
#setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Spectra")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


spectrum<-fread("Spectra_relative.csv")
#spectrum<-fread("All_spectra.csv")

df_summary <- spectrum %>% group_by(Group,Session,EO1_EC2,Channel) %>%##
  summarise(across(everything(),mean),
  .groups = 'drop') %>%
  as.data.frame()
df_summary[1:10,1:8]  
  
write.csv(df_summary, "mean_relative_spectra.csv")
df_summary<-fread("mean_relative_spectra.csv")  


df1<-subset(df_summary, Group=="Treatment" & EO1_EC2=="2" & Channel=="F3" & Session =="1")
df2<-subset(df_summary, Group=="Control" & EO1_EC2=="2" & Channel=="F3" & Session =="1")

df3<-subset(df_summary, Group=="Treatment" & EO1_EC2=="2" & Channel=="F3" & Session =="2")
df4<-subset(df_summary, Group=="Control" & EO1_EC2=="2" & Channel=="F3" & Session =="2")


df1 <- df1 %>% gather(Freq, Power, f_0:f_256)
df2 <- df2 %>% gather(Freq, Power, f_0:f_256)
df3 <- df3 %>% gather(Freq, Power, f_0:f_256)
df4 <- df4 %>% gather(Freq, Power, f_0:f_256)
Freqs<-0:256
Power1<-df1[df1$Session=="1",]$Power
Power3<-df2[df2$Session=="1",]$Power
Power5<-df3[df3$Session=="2",]$Power
Power7<-df4[df4$Session=="2",]$Power
df3<-data.frame(Freqs, Power1, Power3, Power5, Power7)


setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative/Data_Spectra")


colors <- c("Treatment1" = "red", "Control1" = "blue", "Treatment2" = "green", "Control2" = "yellow")

p<-ggplot(df3, aes(x=Freqs)) + 
  geom_line(aes(y = Power1, color = "Treatment1")) +
  geom_line(aes(y = Power3, color="Control1")) +
  geom_line(aes(y = Power5, color="Treatment2")) +
  geom_line(aes(y = Power7, color="Control2")) +
  #xlim(0,60)+
   scale_x_continuous(name="Frequency (Hz)", breaks=seq(0,60,10), limits=c(0,60))+
  scale_y_continuous(name="Power at F3 (uv^2/Hz)")+
  ggtitle("F3 Eyes Open Relative")+
  labs(color = "Legend") +
    scale_color_manual(values = colors)+
  theme_classic(base_size=15)
p

ggsave("CSCI_EO_F3_spectra.png", p, width=8, height=5, units="in")



p<-ggplot(df3, aes(x=Freqs)) + 
  geom_line(aes(y = Power1, color = "Treatment1")) +
  geom_line(aes(y = Power3, color="Control1")) +
  geom_line(aes(y = Power5, color="Treatment2")) +
  geom_line(aes(y = Power7, color="Control2")) +
  #xlim(0,60)+
   scale_x_continuous(name="Frequency (Hz)", breaks=seq(0,260,10), limits=c(35,55))+
  scale_y_continuous(name="Power at F3 (uv^2/Hz)", limits=c(0,0.005))+
  ggtitle("F3 Eyes Open Relative")+
  labs(color = "Legend") +
    scale_color_manual(values = colors)+
  theme_classic(base_size=15)
p

ggsave("EO_F3_spectra_relative_60.png", p2, width=8, height=5, units="in")


