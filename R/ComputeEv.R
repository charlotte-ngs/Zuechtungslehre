###
###
###   Purpose:  Compute EV
###   started:   2015/09/25 (pvr)
###
### #################################### ###

nNrCows <- 50
nMilkPerCow <- 7000
nMilkYear <-  nNrCows * nMilkPerCow

nNetRevMilkPerKg <- 0.55
nCostPerMilkKg <- 0.45
nGainPerMilkKg <- nNetRevMilkPerKg-nCostPerMilkKg

### # total cost current situation
nTotCostCurrent <- nCostPerMilkKg * nMilkYear
nTotRevCurrent <- nNetRevMilkPerKg * nMilkYear
nTotGainCurrent <- nTotRevCurrent - nTotCostCurrent

