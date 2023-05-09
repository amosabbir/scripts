setwd("/Users/abdullahmosabbir/Desktop/KKT_working_directory/Case_series")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(tidyr)
library(PairedData)


kkt<-fread("Spondy_dataR.csv")

#--------------
kkt2<-reshape(kkt, direction='long', 
        varying=c('ST.1','ST.2','PT.1','PT.2', 'LLD.1','LLD.2','ULL.1','ULL.2','ULR.1','ULR.2','LLL.1','LLL.2','LLR.1','LLR.2','ROML.1','ROML.2','ROMR.1','ROMR.2','Pain.1','Pain.2','RM.1','RM.2'), 
        timevar='var',
        times=c(1,2),
        v.names=c('ST', 'PT', 'LLD', 'ULL','ULR','LLL','LLR','ROML','ROMR','Pain','RM'),
        idvar='sbj')

reshape(kkt, varying = c(14:35), 
     v.names = c('ST', 'PT', 'LLD', 'ULL','ULR','LLL','LLR','ROML','ROMR','Pain','RM'),
     times = c('.1','.2'),
     timevar = "time",
     idvar = "id",
     direction = "long")
#--------------        

       
ST_summary <- kkt2 %>% group_by(timepoint) %>%##
  summarise(##
    count = n(),##
    mean = mean(ST, na.rm = TRUE),##
    sd = sd(ST, na.rm = TRUE),
    se = sd/(sqrt(count))##
  )

ST_summary$x<-c("T1","T2")
ST_summary


t.test(kkt$Pain.1, kkt$Pain.2, paired=T)
t.test(kkt$ST.1, kkt$ST.2, paired=T)
t.test(kkt$PT.1, kkt$PT.2, paired=T)
t.test(kkt$LLD.1, kkt$LLD.2, paired=T)
t.test(kkt$ULL.1, kkt$ULL.2, paired=T)
t.test(kkt$ULR.1, kkt$ULR.2, paired=T)
t.test(kkt$LLL.1, kkt$LLL.2, paired=T)
t.test(kkt$LLR.1, kkt$LLR.2, paired=T)
t.test(kkt$ROML.1, kkt$ROML.2, paired=T)
t.test(kkt$ROMR.1, kkt$ROMR.2, paired=T)
t.test(kkt$RM.1, kkt$RM.2, paired=T)


# Paired samples effect size
df <- data.frame(
id = 1:7,
pre = kkt$LLR.1,
post = kkt$LLR.2
)
df <- df %>% gather(key = "treatment", value = "value", -id)
head(df)
df %>% cohens_d(value ~ treatment, paired = TRUE)

#-----------------------

p<-ggplot(Pain_summary, aes(x=x, y=mean, group=1)) +
 geom_point(size=2)+
 geom_line(size=1) +
 geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.1) +
   scale_colour_grey(start=0, end=0.8) +
   ylim(0,10)+
   labs(x="", y = " Pain score ")+
   theme_classic(base_size=15)+ 
   scale_x_discrete(labels=c("Pre-treatment", "Post-treatment"))+
    theme(legend.position="none",axis.text.x = element_text(angle = 45, hjust = 1))+
   theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm")) 

ggsave("Pain.png", p, width=4, height=5, units="in")   


aa<-(kkt[Timepoint==2,Reflex])

p<-ggplot(data.frame(aa), aes(x=aa)) +
geom_bar(color="black") +
  labs(x= "",y = "Count")+
  scale_fill_grey(start=0.3, end=0.9)+
  theme_classic(base_size=15)+
  coord_cartesian(ylim=c(0,10),expand=F)+
  #scale_x_discrete(limits=c("Decreased", "Normal", "Exaggerated"))+
   ggtitle(" Post-Treatment Reflexes")+
  theme(plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"))

ggsave("Ref2.png", p, width=5, height=5, units="in")


library(Hmisc)
library(corrplot)
kkt2<-fread("Spondy_data2.csv")
kkt2<-kkt2[,!c(2,4,5,17)]
res2<-rcorr(as.matrix(kkt2))

flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
    )
}

flattenCorrMatrix(res2$r, res2$P)

corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")
         
cc<-corrplot(res2$r, p.mat = res2$P, method = 'color', diag = FALSE, type = 'upper',
         sig.level = c(0.001, 0.01, 0.05), pch.cex = 0.9, 
         insig = 'label_sig', pch.col = 'grey20', order = 'hclust')







kkt3<-fread("Data3.csv")
kkt3<-kkt3[,!c(1,2,3,5,7,17)]
res2<-rcorr(as.matrix(kkt3))


corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")
         
cc<-corrplot(res2$r, p.mat = res2$P, method = 'color', diag = FALSE, type = 'upper',
         sig.level = c(0.001, 0.01, 0.05), pch.cex = 0.9, 
         insig = 'label_sig', pch.col = 'grey20', order = 'hclust')




