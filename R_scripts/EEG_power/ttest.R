ez_outcome <- ezANOVA(
  data = df5,
  dv = Diff,
  wid = ID,
  within = EO1_EC2,
  between = Responder,
  type = 3)



df5 <- within(df5, EO1_EC2[EO1_EC2 == '2'] <- 'EC')

R_EO<-df5[df5$EO1_EC2=="EO" & df5$Responder=="R",]
R_EC<-df5[df5$EO1_EC2=="EC" & df5$Responder=="R",]
NR_EO<-df5[df5$EO1_EC2=="EO" & df5$Responder=="NR",]
NR_EC<-df5[df5$EO1_EC2=="EC" & df5$Responder=="NR",]

t.test(R_EO$Diff, R_EC$Diff, paired=T)
t.test(NR_EO$Diff, NR_EC$Diff, paired=T)
t.test(R_EO$Diff, NR_EO$Diff, paired=F)
t.test(R_EC$Diff, NR_EC$Diff, paired=F)