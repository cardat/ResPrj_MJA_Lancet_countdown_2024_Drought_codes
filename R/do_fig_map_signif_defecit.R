## tar_load(dat_drt_severity)
do_fig_map_signif_defecit <- function(
    dat_drt_severity
    ,
    outfile = "figures_and_tables/GTif_spei_av_2023_sign_defct_aug_oct"
){
  # Australia's climate in 2023. The August to October period was Australia's driest three month period on record since 1900. http://www.bom.gov.au/climate/current/annual/aus/2023/

  # QC the 2023 pattern
  dat <- dat_drt_severity
  dat2 <- dat[substr(dat$date,1,4) =="2023" & substr(dat$date,6,7) %in% c('08', '09', '10'),]
  dat2[gid == 480,]
  dat2 <- dat2[,.(spei = mean(SPEI)), by = c("gid", 'lon', 'lat')]
  setDF(dat2)
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
  r_out <- rasterize(vect, rast(r), field = 'spei', fun = mean)
  plot(r_out, main = outfile)
  dev.off()
  writeRaster(raster::brick(r_out), filename = outfile, format = "GTiff", 
              bylayer = TRUE, overwrite = TRUE, suffix = "names", 
              datatype = "FLT4S", 
              options = c("COMPRESS=LZW"))
}