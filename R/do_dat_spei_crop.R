## tar_load(dat_spei)
## tar_load(dat_ste)
do_dat_spei_crop <- function(
  r_rast = dat_spei
  , 
  in_ste = dat_ste
){
  r_spat <- unwrap(r_rast)
  r_spat
  in_ste <- vect(in_ste)
  in_ste <- project(in_ste, crs(r_spat))
  # Get the extent of the polygon and add a small buffer
  poly_extent <- ext(in_ste)
  buffer <- res(r_spat)[1]  # Use the raster's resolution as a buffer
  poly_extent <- extend(poly_extent, buffer)
  # Crop the raster to the buffered extent
  cropped_raster <- crop(r_spat, poly_extent)
  # Use touch=TRUE in mask() to include cells that touch the polygon boundary
  masked_raster <- mask(cropped_raster, in_ste, touches=TRUE)
  
  # # QC
  # layer_dates <- as.Date(gsub("X", "", names(masked_raster)), format="%Y.%m.%d")
  # layer_index <- which(layer_dates == as.Date('2019-12-01'))
  # r <- masked_raster[[layer_index]]
  # plot(r)
  # plot(in_ste, add = T)
  # plot(r_spat[[which(layer_dates == as.Date('2019-12-01'))]], add = T)

  r_rast_out <- terra::wrap(masked_raster)
  return(r_rast_out)
}