setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative")
#setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Spectra")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)


spectrum<-fread("All_spectra_relative.csv")

df1<-subset(spectrum, EO1_EC2=="1" & Channel=="F4")

df1 <- df1 %>% gather(Freq, Power, a0:a256)
Freqs<-0:256
Power1<-df1[df1$Session=="B" & df1$PID==1,]$Power
df3<-data.frame(Freqs, Power1)

setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/Covid/EEG_analysis/Relative/Data_Spectra")


p<-ggplot(df3, aes(x=Freqs)) + 
  geom_line(aes(y = Power1, color = "red")) + 
    #xlim(0,60)+
   scale_x_continuous(name="Frequency (Hz)", breaks=seq(0,60,10), limits=c(15,60))+
  scale_y_continuous(name="Power at F4 (uv^2/Hz)", limits=c(0,0.005))+
  ggtitle("PID==1 F4 Eyes Open Relative")+
  theme_classic(base_size=15)
p

ggsave("PID==1_relative_EO_F4.png", p, width=5, height=5, units="in")


