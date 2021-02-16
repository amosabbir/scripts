
#-----Number of vacants

df<-data[!(data$I1_NI2=="?"),]
df<-select(df,Block,SE1_SE2,I1_NI2,Part_Num,Responder,Box_RT,Early,Late)

df_special<-group_by(df,SE1_SE2,I1_NI2,Part_Num,Responder) %>%
  summarise(
    count = n(),
    Vacants = sum(Box_RT==0),
    Early = sum(Early),
    Late = sum(Late)
  )
df_special$Vacants_perc<-(df_special$Vacants/df_special$count)*100
df_special$Early_perc<-(df_special$Early/df_special$Vacants)*100
df_special$Late_perc<-(df_special$Late/df_special$Vacants)*100
  
df_vacant<-group_by(df_special,SE1_SE2,I1_NI2,Responder) %>%
  summarise(
    count = n(),
    mean = mean(Vacants, na.rm = TRUE),
    sd = sd(Vacants, na.rm = TRUE)
  )
df_vacant$se<-df_vacant$sd/(sqrt(df_vacant$count))  

df_Incentive<-subset(df_special, df_special$I1_NI2==1)
df_NonIncentive<-subset(df_special, df_special$I1_NI2==2)

df_Incentive$SE1_SE2[df_Incentive$SE1_SE2==1]<-"Before"
df_Incentive$SE1_SE2[df_Incentive$SE1_SE2==2]<-"After"

df_NonIncentive$SE1_SE2[df_NonIncentive$SE1_SE2==1]<-"Before"
df_NonIncentive$SE1_SE2[df_NonIncentive$SE1_SE2==2]<-"After"




