p<-ggplot(UUB, aes(x=Week_0, y=Difference)) +
  geom_point(size=2)+
  labs(x="Baseline UPDRS Score (Treatment)", y = "Change in UPDRS Score")+
    scale_color_grey(start=0.7, end=0.5)+
    geom_smooth(method=lm, se=FALSE, color="black")+
    geom_hline(data = df_lines[1, ], aes(yintercept = y, color = Legend, linetype=Legend)) +
  geom_vline(data = df_lines[2:3, ], aes(xintercept = y, color = Legend, linetype=Legend), show.legend = F)+
   theme_classic(base_size=20)
    
    p + scale_x_continuous(name="Baseline UPDRS Score (Control)", limits=c(9, 45)) +
  scale_y_continuous(name="Change in UPDRS Score", limits=c(-10,20)) 
ggsave("Fig2D.png", width=8, height=6)  






geom_hline(data = df_lines[1, ], aes(yintercept = y, linetype = Legend)) +
  geom_vline(data = df_lines[2:3, ], aes(xintercept = y, linetype = Legend), show.legend = F)+