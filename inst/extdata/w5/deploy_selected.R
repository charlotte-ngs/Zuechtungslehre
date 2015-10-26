#RCourseTools::deploy_document(psDocument = "simgenphencorr.csv", psSrcDir = "inst/extdata/w5",
#                                                            psTrgDir = "../LivestockBreedingAndGenomics/gh-pages/w5")
#
#
# deploy solution
#list.files("vignettes", pattern = "pdf$")
#[1] "zl_w6_l3-MlPlotRes.pdf"       "zl_w6_l3-SimpleRegLocus1.pdf" "zl_w6_l3-SimpleRegLocus2.pdf"
#[4] "zl_w6_l3-SimpleRegLocus3.pdf" "zl_w6_l3.pdf"

#RCourseTools::deploy_document(psDocument = "zl_w6_l3.pdf", psSrcDir = "vignettes",
#                              psTrgDir = "../LivestockBreedingAndGenomics/gh-pages/w6")

deploy_selected <- function(psSrcDir, psPattern = NULL, psTrgDir){
  sDeployFiles <- list.files(path = psSrcDir, pattern = psPattern)
  cat(" * Which file should be deployed\n")
  print(sDeployFiles)
  nDeployFileIdx <- as.numeric(readline(prompt = " * Please enter index of file to be deployed: "))
  if (nDeployFileIdx <= length(sDeployFiles)) {
    cat(" * Selected file to be deployed: ", sDeployFiles[nDeployFileIdx], "\n")
    RCourseTools::deploy_document(psDocument = sDeployFiles[nDeployFileIdx],
                                  psSrcDir = psSrcDir,
                                  psTrgDir = psTrgDir)

  }
}
