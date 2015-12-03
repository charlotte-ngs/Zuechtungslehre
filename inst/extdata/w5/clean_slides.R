#RCourseTools::clean_slides
clean_slides <- function (psPkgDir = ".", psVigKeepPattern = "[.][rRsS]nw|cls|[Rr]md")
{
  #psPkgDir = "."
  #psVigKeepPattern = "[.][rRsS]nw|cls|[Rr]md"

  pkg <- devtools::as.package(psPkgDir)
  vigInfo <- tools::pkgVignettes(dir = pkg$path)
  sDefaultVignSubdir <- "vignettes"
  if (basename(vigInfo$dir) != sDefaultVignSubdir)
    return()
  devtools::clean_vignettes(pkg = psPkgDir)
  if (any(vigInfo$engines == "utils::Sweave")) {
    vExtraVigFiles <- list.files(path = sDefaultVignSubdir)
    bExtraPatRm <- !grepl(pattern = psVigKeepPattern, vExtraVigFiles)
    bFilterDir <- unlist(lapply(vExtraVigFiles, function(x) !file.info(file.path(sDefaultVignSubdir,
                                                                                 x))$isdir))
    vExtraFilesRm <- vExtraVigFiles[bExtraPatRm & bFilterDir]
    cat(" * Should the following files be deleted:\n")
    print(vExtraFilesRm)
    sAnswerRmFile <- readline(" * Please answer [y = yes to all/n = no]: ")
    if (sAnswerRmFile == "y") {
      for (f in vExtraFilesRm) {
        file.remove(file.path(sDefaultVignSubdir, f))
        cat(" * ... file ", f, " ... removed\n")
      }
    }
  }
  invisible(TRUE)
}

clean_slides()
