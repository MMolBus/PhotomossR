remove.packages("PhotomossR")
if(require(librarian)!=T){
  install.packages('librarian')
  require(librarian)
}


# librarian::shelf(devtools, MMolBus/photomoss, MMolBus/MButils)
librarian::shelf(devtools, MMolBus/MButils)

install.packages("Rcpp", type = "binary")  # fuerza el binario, evita compilar
install.packages(c("rlang", "glue", "cli", "vctrs", "magrittr"))

devtools::install_github("MMolBus/PhotomossR", ref = "dev")
repo <- getpath()
devtools::install(repo)  



# if(require(devtools)!=T){
#   install.packages('devtools')
#   require(devtools)
# }else{
#   library(devtools)
# }
# # Then we install photomoss from my GitHub branch:
#   
#   install_github("MMolBus/photomoss")
# library(photomoss)

  
  wd <- getpath() #your working directory
  setwd (wd)
  tif.path <- getwd()
  
  chart2(paste0(tif.path,"/vis"), pic.format = "tif")
chart <- readRDS(list.files(pattern = "chart"))  


roi.paths <- list.files(path = "./rois",pattern=".roi$",full.names = T, recursive = T)

obs.areas <- lapply(roi.paths, roi2polygon, tif.path)

ccspectral.df(tif.path,
              chart,
              obs.areas,
              pdf = F,
              calculate.thresh = F,
              descrip = F,
              manual.mask.test = F,
              index. = c("SR"),
              threshold.method = c("Li"),
              threshold.vector = c(0.6),
              descriptors. = 
                c("mean")
)
