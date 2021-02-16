steplength<-fread("stride_length.csv")
steplength
steplength <- steplength %>% group_by(CODE,Group) %>% summarise_all(mean)#
as.data.frame(steplength)
steplength<-steplength[,-3]
steplength
as.data.frame(steplength)
steplength<-melt(steplength, id.vars=c("CODE","Group"), measure.vars=c("0_Weeks","4_Weeks","8_Weeks","12_Weeks"))
steplength
colnames(steplength)[c(3,4)]<-c("Timepoint", "Score")
steplength
library("dplyr")#
group_by(U_group, Group, Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Score, na.rm = TRUE),#
    sd = sd(Score, na.rm = TRUE)#
  )
ez_outcome <- ezANOVA(#
  data = steplength,#
  dv = Score,#
  wid = CODE,#
  within = Timepoint,#
  between = Group,#
  type = 3)
ez_outcome