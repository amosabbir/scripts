COVID_topoplot_prep

setwd("/Users/abdullahmosabbir/Desktop/PostDoc_Work/COVID/Raw_data_Statistics/EEG")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)

stats<-fread("Relative_power_total.csv")
stats<-subset(stats, Session==1 | Session==2)


topo_summary <- stats %>% group_by(Group,Session,Channel, EO1_EC2, Chan_index) %>%##
  summarise(##
    count = n(),##
    m_delta = mean(delta, na.rm = TRUE),##
    m_theta = mean(theta, na.rm = TRUE),##
    m_alpha = mean(alpha, na.rm = TRUE),##
    m_beta = mean(beta, na.rm = TRUE),##
    m_gamma = mean(gamma, na.rm = TRUE),##
    m_slow = mean(slow, na.rm = TRUE),##
    m_gamma2 = mean(gamma2, na.rm = TRUE),##
    m_gamma3 = mean(gamma3, na.rm = TRUE),##
    m_gamma4 = mean(gamma4, na.rm = TRUE),##
    m_total = mean(total, na.rm = TRUE)
  )

#topo_summary$x<-c("EO_NR","EO_R","EC_NR","EC_R")
topo_summary

write.csv(topo_summary, "Topo_summary_relative.csv")




rel_topo<-fread("Topo_summary_relative.csv")
rel_topo_S2<-subset(rel_topo, Session == 2)
rel_topo_S1<-subset(rel_topo, Session == 1)
write.csv(rel_topo_S2, "rel_topo_S2.csv")
write.csv(rel_topo_S1, "rel_topo_S1.csv")


rel_diff<-fread("rel_topo_S2.csv")
rel_diff$delta_diff<-rel_diff$m_delta_2-rel_diff$m_delta
rel_diff$theta_diff<-rel_diff$m_theta_2-rel_diff$m_theta
rel_diff$alpha_diff<-rel_diff$m_alpha_2-rel_diff$m_alpha
rel_diff$beta_diff<-rel_diff$m_beta_2-rel_diff$m_beta
rel_diff$gamma_diff<-rel_diff$m_gamma_2-rel_diff$m_gamma
rel_diff$slow_diff<-rel_diff$m_slow_2-rel_diff$m_slow
rel_diff$gamma2_diff<-rel_diff$m_gamma2_2-rel_diff$m_gamma2
rel_diff$gamma3_diff<-rel_diff$m_gamma3_2-rel_diff$m_gamma3
rel_diff$gamma4_diff<-rel_diff$m_gamma4_2-rel_diff$m_gamma4
rel_diff$total_diff<-rel_diff$m_total_2-rel_diff$m_total

write.csv(rel_diff,"rel_topo_final.csv")







