stance<-fread("step_time_sec.csv")
stance <- within(stancetime, Group[CODE=="DAHO" | CODE=="DEPR" | CODE== "GEAL" | CODE== "GLKI" | CODE=="HENI" | CODE=="IDPA" | CODE=="KEBR" | CODE=="KECR" | CODE=="PEWI" | CODE=="RACR" | CODE=="RIDU" | CODE=="ROPA" | CODE=="SAPA" | CODE=="TITA" | CODE=="WESP"] <- "C")

stancem <- stance %>% group_by(CODE,Group) %>% summarise_all(mean)#
as.data.frame(stancem)#
#
stancesd <- stance %>% group_by(CODE,Group) %>% summarise_all(sd)#
as.data.frame(stancesd)
stancecv<-stancesd[,c(4:7)]/stancem[,c(4:7)]
stancecv<-stancecv*100
stance<-bind_cols(stancesd[,c(1:2)], stancecv)
stance<-melt(stance,id.vars=c("CODE","Group"), measure.vars=c("0_Weeks","4_Weeks","8_Weeks","12_Weeks"))
colnames(stance)[c(3,4)]<-c("Timepoint", "Score")

group_by(stance,Group,Timepoint) %>%#
  summarise(#
    count = n(),#
    mean = mean(Score, na.rm = TRUE),#
    sd = sd(Score, na.rm = TRUE)#
  )
ez_outcome <- ezANOVA(#
  data = stance,#
  dv = Score,#
  wid = CODE,#
  within = Timepoint,#
  between = Group,#
  type = 3)
ez_outcome
