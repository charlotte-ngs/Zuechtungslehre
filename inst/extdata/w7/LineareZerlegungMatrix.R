###
###
###
###   Purpose:   Lineare Zerlegung einer Matrix
###   started:   2015/10/29 (pvr)
###
### ############################################ ###

### # rnd-seed setzen
set.seed(1984)
### # matrix X mit Zufallszahlen definieren
nAnzRowMatX <- 20
nAnzColMatX <- 3
matX <- matrix(runif(nAnzRowMatX*nAnzColMatX), ncol = nAnzColMatX)

### # X^T * X berechnen
matXtX <- crossprod(matX)

### # matrix fuer Resultate
matVerify <- matrix(0, ncol = ncol(matXtX), nrow = nrow(matXtX))

### # loop der linearen Zerlegung
for (i in 1:nrow(matX)){
  matVerify <- matVerify + outer(matX[i,], matX[i,])
}

### # Ausgabe des Results
print(matVerify)
### # Differenz mit Ursprungsmatrix
max(matXtX-matVerify)
