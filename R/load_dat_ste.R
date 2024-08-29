# indir_ste <- "data_provided/ABS_Census_2016_STE"
# infile_ste <- "STE_2016_AUST.shp"
load_dat_ste <- function(
    infile_ste = file.path(indir_ste, infile_ste)
    ){
  shp <- st_read(infile_ste)  
  return(shp)
}