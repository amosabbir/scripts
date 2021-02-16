df2 <- df1 %>% group_by(var1,var2) %>% summarise_all(mean)
as.data.frame(df2)
