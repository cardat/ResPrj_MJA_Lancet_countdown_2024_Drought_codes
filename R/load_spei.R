#' Title load_spei
#'
#' @param infile 
#'
#' @return r_rast_out
#' @examples
# indir_spei <- "data_provided/Drought_SPEI_CSIC_global_drought_monitor_1950_2023"
# infile <- file.path(indir_spei, "spei06.nc")
# tar_load(dat_ste)
load_spei <- function(
    infile
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
  # Preserve time information
  # time_info <- getZ(r_rast)
  
  in_ste <- vect(in_ste)
  
  # Convert raster brick to SpatRaster
  r_spat <- rast(r_rast)
  # time(r_spat) <- time_info
  
  # Ensure the polygon and raster have the same CRS
  in_ste <- project(in_ste, crs(r_spat))
  
  # Get the extent of the polygon and add a small buffer
  poly_extent <- ext(in_ste)
  buffer <- res(r_spat)[1]  # Use the raster's resolution as a buffer
  poly_extent <- extend(poly_extent, buffer)
  
  # Crop the raster to the buffered extent
  cropped_raster <- crop(r_spat, poly_extent)
  
  # Use touch=TRUE in mask() to include cells that touch the polygon boundary
  masked_raster <- mask(cropped_raster, in_ste, touches=TRUE)
  
  # layer_dates <- as.Date(gsub("X", "", names(masked_raster)), format="%Y.%m.%d")
  # layer_index <- which(layer_dates == as.Date('2019-12-01'))
  # r <- masked_raster[[layer_index]]
  # plot(r)
  # plot(in_ste, add = T)
  # plot(r_rast[[which(layer_dates == as.Date('2019-12-01'))]], add = T)
  
  
  r_rast_out <- terra::wrap(masked_raster)
  return(r_rast_out)
}
