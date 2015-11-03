###
###
###
###   Purpose:   Small coagulation data set
###   started:   2015/10/30 (pvr)
###
### ######################################### ###

data("coagulation")
dfSmallCoag <- rbind(coagulation[1:3,],
                     coagulation[5:8,],
                     coagulation[11:13,])
print(dfSmallCoag)
