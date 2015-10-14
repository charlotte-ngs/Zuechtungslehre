###
###
###
###   Purpose:   Generate an original genotype file
###   started:   2015/10/13 (pvr)
###
### ################################################ ###


### # define a few constants
### # directory where the original data can be found
sDatDir <- ifelse(.Platform$OS.type == "windows",
                  "C:/Daten/pvr/Google Drive/eBooks/GWH2013_Genome-Wide_Association_Studies_and_Genomic_Prediction/978-1-62703-446-3/Chapter10",
                  "~/Google Drive/eBooks/GWH2013_Genome-Wide_Association_Studies_and_Genomic_Prediction/978-1-62703-446-3/Chapter10")
### # name of the file with original data
sGenDatFn <- "Genotypes.dat"
### # number of lines to be read from orignial data file
nDataLine <- 31
### # column indices to extract
nStartCol <- 2
nEndCol <- 5
### # rowindex of header lines
nHeaderLineIdx <- 1
### # regexp with which to split columns
sColSplit <- "[ ]+"
### # constants for simulation
nInterceptTrue <- -10.76
nSubsEffLocus1 <- 1
nSubsEffLocus2 <- 0.5
nSubsEffLocus3 <- 0.2
nMeanRes <- 0
nSdRes   <- 2.5

##############################
### # functions
sGetHeaderLine <- function(psGenDataLine, pnHeaderLineIdx, psColSplit, pnStartCol, pnEndCol) {
  sResultHeaderLine <- unlist(strsplit(psGenDataLine[pnHeaderLineIdx],
                                       split = psColSplit))[pnStartCol:pnEndCol]
  return(sResultHeaderLine)
}
##############################
### # code starts here ....
### # save the current working directory
#zlwd <- getwd()
zlwd <- ifelse(.Platform$OS.type == "windows",
               "C:/Daten/GitHub/Zuechtungslehre",
               "~/Data/Projects/GitHub/Zuechtungslehre")

### # change wd to where genotype.dat is located
setwd(sDatDir)

### # open a connection and read first 20 records with header
conDat <- file(description = sGenDatFn)
sGenDataLine <- readLines(con = conDat, n = nDataLine)
close(con = conDat)

sHeaderLine <- sGetHeaderLine(psGenDataLine   = sGenDataLine,
                              pnHeaderLineIdx = nHeaderLineIdx,
                              psColSplit      = sColSplit,
                              pnStartCol      = nStartCol,
                              pnEndCol        = nEndCol)

### # body of data records
matGenoDat <- matrix(data = NA, nrow = length(sGenDataLine)-1, ncol = length(sHeaderLine))
for (i in 2:length(sGenDataLine)){
  matGenoDat[(i-1),] <- as.numeric(unlist(strsplit(sGenDataLine[i],
                                                   split = sColSplit))[nStartCol:nEndCol])
}

### # generate the data
matDesignX <- matGenoDat
matDesignX[,1] <- rep(1, nrow(matGenoDat))
### # check rank of design matrix
qr(matDesignX)$rank
### # make adjustments to get full column rank
matDesignX[19,4] <- -10
matDesignX[19,4] <- 0
qr(matDesignX)$rank

### # true beta vector
vecBetaTrue <- c(nInterceptTrue,
                 nSubsEffLocus1,
                 nSubsEffLocus2,
                 nSubsEffLocus3)
vecYTrue <- matDesignX %*% vecBetaTrue + rnorm(n = nrow(matDesignX), mean = nMeanRes, sd = nSdRes)

### # conversion to a dataframe
id <- matGenoDat[,1]
locus1 <- matDesignX[,2]/10
locus2 <- matDesignX[,3]/10
locus3 <- matDesignX[,4]/10
y <- vecYTrue
dfSimGenPhenDat <- data.frame(id,locus1, locus2, locus3, y, stringsAsFactors = FALSE)

### # fit lm
fitMultReg <- lm( y ~ locus1 + locus2 + locus3, data = dfSimGenPhenDat)
summary(fitMultReg)

### # single regressions
summary(lm(y ~ locus1, data = dfSimGenPhenDat))
summary(lm(y ~ locus2, data = dfSimGenPhenDat))
summary(lm(y ~ locus3, data = dfSimGenPhenDat))


### # re-set working directory
setwd(zlwd)

### # write df to csv file
write.csv2(dfSimGenPhenDat, file = "inst/extdata/w5/simgenphen.csv", quote = FALSE, row.names = FALSE)
