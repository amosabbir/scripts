kktrctcanada <- blockrand(n = 30, 
                     num.levels = 2, # two groups
                     levels = c("Treatment", "Placebo"), 
                     stratum = "Canada", # stratum name
                     id.prefix = 1, # stratum abbrev
                     block.sizes = c(1,2,3), 
                     block.prefix = "kRCT") # stratum abbrev
kktrctcanada$id <- sub("^","kRCT",kktrctcanada$id)

kktrctcanada


kktrctksa <- blockrand(n = 1000, 
                     num.levels = 2, # two groups
                     levels = c("Treatment", "Placebo"), 
                     stratum = "KSA", # stratum name
                     id.prefix = 31, # stratum abbrev
                     block.sizes = c(1,2,3), 
                     block.prefix = "kRCT") # stratum abbrev
kktrctksa$id <- sub("^","kRCT",kktrctksa$id)

kktrctksa


kktrct<-rbind(kktrctcanada,kktrctksa)


setwd("/Users/abdullahmosabbir/Desktop")