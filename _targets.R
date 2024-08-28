library(targets)

lapply(list.files("R", full.names = TRUE), source)

tar_option_set(
  packages =
    c("targets", "data.table", "ncdf4", "raster", "terra", "sf")
)

# Load config settings
config <-source("config.R")

list(
  ### dat_ste ####
  tar_target(dat_ste,
             load_dat_ste(infile_ste = file.path(indir_ste, "STE_2016_AUST.shp"))
  )
  ,
  #### dat_spei ####
  tar_target(dat_spei,
             load_dat_spei(
               infile = file.path(indir_spei, "spei06_20240829.nc")
               ,
               in_ste = dat_ste
               )
  )
  ,
  ####  do_dat_spei_long ####
  tar_target(
    dat_spei_long,
    do_dat_spei_long(dat_spei)
  )
  


)
