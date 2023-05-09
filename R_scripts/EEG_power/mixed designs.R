
###within subjects anova in r

install.packages("readxl")      ### reads excel
install.packages("emmeans")     ### estimated marginal means and p values
install.packages("sjstats")     ### partial eta squared and cohens f effect size 
install.packages("lme4")        ### estimated the multi level model (random intercept for participants)
install.packages("lmerTest")    ### gives more comprehsive anova output with p values 
install.packages("MuMIn")       ### R2 for the model 

###pull packages out of the library

library(readxl)
library(emmeans)
library(sjstats)
library(lme4)
library(lmerTest)
library(MuMIn)

###turn off scientfic notation

options(scipen = 999)
###################between subjects factor added to the first example
###follows identical principals
###few variable is Language and is whether they spoke English as their first language.

####

###read in the data set

alcoholmixed <- read_excel("C:/Users/prc/Desktop/Covid-19/BOOK/within subs anova/mixed.xlsx")
View(alcoholmixed)        
attach(alcoholmixed)

############################Tell it you have factors, and what they are called

alcoholmixed$drink<- factor(alcoholmixed$drink,
                            levels = c(1,2,3),
                            labels = c("alcohol", "placebo", "control"))


alcoholmixed$Language<- factor(alcoholmixed$Language,
                               levels = c(1,2),
                               labels = c("Eng", "other"))


###R now knows your factors, the below command breaks down your variables 

summary(alcoholmixed)

drinkeff3 <- lmer(words ~ as.factor(drink)*as.factor(Language) + (1|sub)) 
anova(drinkeff3)                                      
eta_sq(drinkeff3, partial = TRUE)                     
emmeans(drinkeff3, list(pairwise ~ drink), adjust = "bonferroni")  #post hoc (two correction egs)
emmeans(drinkeff3, list(pairwise ~ drink), adjust = "tukey")

emmeans(drinkeff3, pairwise~Language | drink) #if there was an interaction your code would be this
