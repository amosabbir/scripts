library("dplyr")
group_by(my_data, Ivar, Ivar) %>%
  summarise(
    count = n(),
    mean = mean(dvar, na.rm = TRUE),
    sd = sd(dvar, na.rm = TRUE)
  )