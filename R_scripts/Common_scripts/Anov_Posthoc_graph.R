U_Action_Tremor__left<-U[,c(1:3,12)]
df<-group_by(U_Action_Tremor__left,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Action_Tremor__left, na.rm = TRUE),#
    sd = sd(Action_Tremor__left, na.rm = TRUE)#
  )
df  
ez_outcome <- ezANOVA(#
  data = U_Action_Tremor__left,#
  dv = Action_Tremor__left,#
  wid = CODE,#
  within = Assessment,#
  between = Group,#
  type = 3)
ez_outcome

A_0_Weeks<-U_Action_Tremor__left[U_Action_Tremor__left$Group=="A" & U_Action_Tremor__left$Assessment=="0_Weeks"]

A_12_Weeks<-U_Action_Tremor__left[U_Action_Tremor__left$Group=="A" & U_Action_Tremor__left$Assessment=="12_Weeks"]

B_0_Weeks<-U_Action_Tremor__left[U_Action_Tremor__left$Group=="B" & U_Action_Tremor__left$Assessment=="0_Weeks"]

B_12_Weeks<-U_Action_Tremor__left[U_Action_Tremor__left$Group=="B" & U_Action_Tremor__left$Assessment=="12_Weeks"]

t.test(A_0_Weeks$Action_Tremor__left, A_12_Weeks$Action_Tremor__left, paired=T, alternative="greater")

t.test(B_0_Weeks$Action_Tremor__left, B_12_Weeks$Action_Tremor__left, paired=T)

t.test(A_0_Weeks$Action_Tremor__left, B_0_Weeks$Action_Tremor__left, paired=F)

df$se<-(df$sd)/sqrt(df$count)

p<- ggplot(df, aes(x=Assessment, y=mean, group=Group, color=Group)) +
  geom_line() +
  geom_point()+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
                 position=position_dodge(0.05))
                 
p+labs(title="Action_Tremor__left", x="Timepoint", y = "Score")+
theme_classic() +
scale_color_manual(values=c('#999999','#E69F00'))

ggsave("Action_Tremor__left.png")