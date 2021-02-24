setwd("/Users/abdullahmosabbir/Desktop/CANBIND/Anhedonia_erp/")
library(ggplot2)
library(dplyr)
library(data.table)
library(ez)
library(matrixStats)

data<-fread("Anhedonia_raw_erp.csv")

data_PO7<-subset(data, data$Channel=="PO7")

data_PO7$Responder <- ifelse(data_PO7$Part_Num == 1,"R",
	ifelse(data_PO7$Part_Num == 3,"R",
	ifelse(data_PO7$Part_Num == 5,"R",
	ifelse(data_PO7$Part_Num == 9,"R",
	ifelse(data_PO7$Part_Num == 13,"R",
	ifelse(data_PO7$Part_Num == 15,"R",
	ifelse(data_PO7$Part_Num == 20,"R",
	"NR")))))))
	

data_PO7_R_SE1_I<-subset(data_PO7, Responder=="R" & SE1_SE2=="SE1" & I1_NI2=="Incentive")  

data_PO7_R_SE1_NI<-subset(data_PO7, Responder=="R" & SE1_SE2=="SE1" & I1_NI2=="NonIncentive")

data_PO7_NR_SE1_I<-subset(data_PO7, Responder=="NR" & SE1_SE2=="SE1" & I1_NI2=="Incentive")

data_PO7_NR_SE1_NI<-subset(data_PO7, Responder=="NR" & SE1_SE2=="SE1" & I1_NI2=="NonIncentive")

data_PO7_R_SE2_I<-subset(data_PO7, Responder=="R" & SE1_SE2=="SE2" & I1_NI2=="Incentive") 

data_PO7_R_SE2_NI<-subset(data_PO7, Responder=="R" & SE1_SE2=="SE2" & I1_NI2=="NonIncentive") 
 
data_PO7_NR_SE2_I<-subset(data_PO7, Responder=="NR" & SE1_SE2=="SE2" & I1_NI2=="Incentive")  

data_PO7_NR_SE2_NI<-subset(data_PO7, Responder=="NR" & SE1_SE2=="SE2" & I1_NI2=="NonIncentive") 


#data_PO7_R_SE1_I --------------------------------------------

a<-colMeans(data_PO7_R_SE1_I[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_R_SE1_I[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_R_SE1_I[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_R_SE1_I[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_R_SE1_I<-rbind(dmean,dsd)


#data_PO7_R_SE1_NI -------------------------------------------

a<-colMeans(data_PO7_R_SE1_NI[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_R_SE1_NI[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_R_SE1_NI[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_R_SE1_NI[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_R_SE1_NI<-rbind(dmean,dsd)


#data_PO7_NR_SE1_I --------------------------------------------

a<-colMeans(data_PO7_NR_SE1_I[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_NR_SE1_I[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_NR_SE1_I[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_NR_SE1_I[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_NR_SE1_I<-rbind(dmean,dsd)



#data_PO7_NR_SE1_NI ------------------------------------------

a<-colMeans(data_PO7_NR_SE1_NI[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_NR_SE1_NI[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_NR_SE1_NI[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_NR_SE1_NI[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_NR_SE1_NI<-rbind(dmean,dsd)


#data_PO7_R_SE2_I -----------------------------------------

a<-colMeans(data_PO7_R_SE2_I[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_R_SE2_I[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_R_SE2_I[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_R_SE2_I[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_R_SE2_I<-rbind(dmean,dsd)

#data_PO7_R_SE2_NI -----------------------------------------

a<-colMeans(data_PO7_R_SE2_NI[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_R_SE2_NI[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_R_SE2_NI[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_R_SE2_NI[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_R_SE2_NI<-rbind(dmean,dsd)

#data_PO7_NR_SE2_I -----------------------------------------

a<-colMeans(data_PO7_NR_SE2_I[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_NR_SE2_I[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_NR_SE2_I[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_NR_SE2_I[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_NR_SE2_I<-rbind(dmean,dsd)

#data_PO7_NR_SE2_NI -----------------------------------------

a<-colMeans(data_PO7_NR_SE2_NI[,c(5:3076)])
b<-colSds(data.matrix(data_PO7_NR_SE2_NI[,c(5:3076)]))
a<-transpose(data.frame(a))
b<-transpose(data.frame(b))

aa<-data_PO7_NR_SE2_NI[1,c(2,3,4,3077)]
aa$Value<-"Mean"
bb<-data_PO7_NR_SE2_NI[1,c(2,3,4,3077)]
bb$Value<-"StDev"

dmean<-cbind(aa,a)
dsd<-cbind(bb,b)

PO7_NR_SE2_NI<-rbind(dmean,dsd)


PO7_data<-rbind(PO7_R_SE1_I,PO7_R_SE1_NI,PO7_NR_SE1_I,PO7_NR_SE1_NI,PO7_R_SE2_I,PO7_R_SE2_NI,PO7_NR_SE2_I,PO7_NR_SE2_NI)


write.csv(PO7_data,"PO7_data.csv")


#data<-data[!(data$Channel=="CB1" |  data$Channel=="CB2" | data$Channel=="TP9" |  data$Channel=="TP10" |  data$Channel=="FT9" |  data$Channel=="FT10" |  data$Channel=="F9" |  data$Channel=="F10" | data$Channel=="IO1" |  data$Channel=="IO2" |  data$Channel=="LO1" |  data$Channel=="LO2") ,]
#datafull_data<-datafull_data[,!3]
  