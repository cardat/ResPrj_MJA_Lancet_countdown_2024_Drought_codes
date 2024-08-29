## tar_load(dat_drt_severity)
do_fig_qc_raster <- function(
  dat = dat_drt_severity
){
  setDF(dat)
  dat2 <- dat[dat$date=="1950-09-01",]
  
  ## Notice work to align output of rasterize
  dat2$lon <- dat2$lon - .5
  dat2$lat <- dat2$lat + .5
  x_range <- range(dat2$lon)
  x_range[2] <- x_range[2] + 1
  y_range <- range(dat2$lat)
  y_range[1] <- y_range[1] - 1
  resolution <- min(diff(sort(unique(dat2$lon))), diff(sort(unique(dat2$lat))))
  
  # Create an empty raster with the correct extent and resolution
  r <- raster(xmn=x_range[1], xmx=x_range[2], 
              ymn=y_range[1], ymx=y_range[2], 
              resolution=resolution)
  
  vect <- vect(dat2, geom = c("lon", "lat"), crs = "EPSG:4283")

  r_out <- rasterize(vect, rast(r), field = "SPEI", fun = mean)
  

  writeRaster(r_out, "working_ivan/output_raster.tif", overwrite = T)
  
  # view in QGIS
}
