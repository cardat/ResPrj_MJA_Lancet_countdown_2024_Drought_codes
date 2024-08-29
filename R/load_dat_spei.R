# indir_spei <- "data_provided/Drought_SPEI_CSIC_global_drought_monitor_1950_2023"
# infile_spei <- "spei06_20240829.nc"
# tar_load(dat_ste)
load_dat_spei <- function(
    infile = file.path(indir_spei, infile_spei)
    ,
    in_ste = dat_ste
    ){
  
  # r_nc <- nc_open(infile)
  # r_nc
  # varlist <- names(r_nc[['var']])
  # varlist
  # nc_close(infile)

  # Load the data
  r_rast <- raster::brick(infile, varname = "spei")
  r_rast <- rast(r_rast)
  r_rast_out <- terra::wrap(r_rast)
  return(r_rast_out)
}
