#' Title load_ste
#'
#' @param infile_ste 
#'
#' @return shp
#' @examples
# indir_ste <- "data_provided/ABS_Census_2016_STE"
# infile_ste <- file.path(indir_ste, "STE_2016_AUST.shp")
load_ste <- function(infile_ste){
  shp <- st_read(infile_ste)  
  return(shp)
}