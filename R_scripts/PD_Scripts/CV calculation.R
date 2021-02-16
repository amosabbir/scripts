stept<-fread("step_time_sec.csv")
stept
steptm <- stept %>% group_by(CODE,Group) %>% summarise_all(mean)#
as.data.frame(steptm)#
#
steptsd <- stept %>% group_by(CODE,Group) %>% summarise_all(sd)#
as.data.frame(steptsd)
steptcv<-steptsd[,c(4:7)]/steptm[,c(4:7)]
steptcv
steptcv<-steptcv*100
steptcv
stept<-bind_cols(steptsd[,c(1:2)], steptcv)
stept
stept<-melt(stept,id.vars=c("CODE","Group"), measure.vars=c("0_Weeks","4_Weeks","8_Weeks","12_Weeks"))
stept
colnames(stept)[c(3,4)]<-c("Timepoint", "Score")
head(stept)
group_by(stept,Group,Timepoint) %>%#
  summarise(#
    count = n(),#
    mean = mean(Score, na.rm = TRUE),#
    sd = sd(Score, na.rm = TRUE)#
  )
ez_outcome <- ezANOVA(#
  data = stept,#
  dv = Score,#
  wid = CODE,#
  within = Timepoint,#
  between = Group,#
  type = 3)
ez_outcome
