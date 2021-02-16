U_Body_bradykinesia<-U[,c(1:3,30)]
df<-group_by(U_Body_bradykinesia,Group,Assessment) %>%#
  summarise(#
    count = n(),#
    mean = mean(Body_bradykinesia, na.rm = TRUE),#
    sd = sd(Body_bradykinesia, na.rm = TRUE)#
  )
df
df$Group[df$Group=="A"]<-"Treatment"
df$Group[df$Group=="B"]<-"Control"
df$se<-(df$sd)/sqrt(df$count)

p <- ggplot(df, aes(x=Assessment, y=mean, group = Group, color=Group))+ 
    geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,position=position_dodge(0.02)) +
    geom_line(aes(), size=1) + 
    geom_point(aes(shape=Group))+
    labs(x="Timepoint", y = "Body Bradykinesia")+
    scale_color_grey(start=0, end=0.8)+
    theme_classic(base_size=20) 
    ggsave("Fig4D.png", width=6, height=4)
    