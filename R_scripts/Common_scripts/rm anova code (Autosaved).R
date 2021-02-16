ez_outcome <- ezANOVA(
  data = total,
  dv = RT,
  wid = Part_Num,
  within = Session,
  between = Responder,
  type = 3)



df5 <- within(df5, SE1_SE2[SE1_SE2 == '2'] <- 'SE2')

R_SE1<-df_Incentive[df_Incentive$SE1_SE2=="Before" & df_Incentive$Responder=="R",]
R_SE2<-df_Incentive[df_Incentive$SE1_SE2=="After" & df_Incentive$Responder=="R",]
NR_SE1<-df_Incentive[df_Incentive$SE1_SE2=="Before" & df_Incentive$Responder=="NR",]
NR_SE2<-df_Incentive[df_Incentive$SE1_SE2=="After" & df_Incentive$Responder=="NR",]

t.test(R_SE1$Var, R_SE2$Var, paired=T)
t.test(NR_SE1$Var, NR_SE2$Var, paired=T)
t.test(R_SE1$Var, NR_SE1$Var, paired=F)
t.test(R_SE2$Var, NR_SE2$Var, paired=F)