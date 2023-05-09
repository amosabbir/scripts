setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative")
#setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Spectra")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


spectrum<-fread("All_spectra_relative2.csv")
#spectrum<-fread("All_spectra.csv")

df_summary <- spectrum %>% group_by(Group,Session,EO1_EC2,Channel) %>%##
  summarise(across(everything(),mean),
  .groups = 'drop') %>%
  as.data.frame()
df_summary[1:10,1:8]  
  
write.csv(df_summary, "mean_spectra.csv")
df_summary<-fread("mean_spectra.csv")  

df1<-subset(df_summary, Group=="Control" & EO1_EC2=="1" & Channel=="Fp2")
df2<-subset(df_summary, Group=="Treatment" & EO1_EC2=="1" & Channel=="Fp2")


df1 <- df1 %>% gather(Freq, Power, a0:a256)
df2 <- df2 %>% gather(Freq, Power, a0:a256)
Freqs<-0:256
Power1<-df1[df1$Session=="A",]$Power
Power2<-df1[df1$Session=="B",]$Power
Power3<-df2[df2$Session=="A",]$Power
Power4<-df2[df2$Session=="B",]$Power
df3<-data.frame(Freqs, Power1, Power2, Power3, Power4)


setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative/Data_Spectra")


colors <- c("Control Before" = "red", "Control After" = "blue", "Treatment Before" = "green", "Treatment After" = "yellow")

p<-ggplot(df3, aes(x=Freqs)) + 
  geom_line(aes(y = Power1, color = "Control Before")) + 
  geom_line(aes(y = Power2, color="Control After")) +
  geom_line(aes(y = Power3, color="Treatment Before")) +
  geom_line(aes(y = Power4, color="Treatment After")) +
  #xlim(0,60)+
   scale_x_continuous(name="Frequency (Hz)", breaks=seq(0,60,10), limits=c(0,60))+
  scale_y_continuous(name="Power at Fp2 (uv^2/Hz)")+
  ggtitle("Fp2 Eyes Open Relative")+
  labs(color = "Legend") +
    scale_color_manual(values = colors)+
  theme_classic(base_size=15)
p

ggsave("EO_Fp2_spectra_relative.png", p, width=8, height=5, units="in")



p2<-ggplot(df3, aes(x=Freqs)) + 
  geom_line(aes(y = Power1, color = "Control Before")) + 
  geom_line(aes(y = Power2, color="Control After")) +
  geom_line(aes(y = Power3, color="Treatment Before")) +
  geom_line(aes(y = Power4, color="Treatment After")) +
  #xlim(10,60)+
   scale_x_continuous(name="Frequency (Hz)", breaks=seq(0,60,10), limits=c(15,60))+
  scale_y_continuous(name="Power at Fp2 (uv^2/Hz)", limits=c(0,0.01))+
  ggtitle("Fp2 Eyes Open Relative")+
  labs(color = "Legend") +
    scale_color_manual(values = colors)+
  theme_classic(base_size=15)
p2

ggsave("EO_Fp2_spectra_relative_60.png", p2, width=8, height=5, units="in")


