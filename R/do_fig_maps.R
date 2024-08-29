## tar_load(dat_excess_drt)
do_fig_maps <- function(
    dat_long_yy2 = dat_excess_drt
){
  # class(dat_long_yy2)
  # dat_long_yy2[gid == 480 & year == 2019]
  # dat_long_yy2[gid == 480 & year == 2023]
  # Key: <gid, variable>
  #   gid    variable   year   lon   lat yrly_cnt_mo_in_drt mean_yrly_cnts sd_yrly_cnts sd_yrly_cnts_thresh excess_drt
  # <int>      <fctr> <char> <num> <num>              <int>          <num>        <num>               <num>      <num>
  # 1:   480      severe   2023 115.5 -28.5                  4     0.85714286    1.5774383           4.0120195          0
  # 2:   480     extreme   2023 115.5 -28.5                  3     0.35714286    0.9030971           2.1633371          1
  # 3:   480 exceptional   2023 115.5 -28.5                  2     0.05357143    0.2966260           0.6468235          1
  # what this means is that for this grid cell (in WA) it is fairly normal to have 4.01 months in severe drought per year, 
  # but only 2.16 months in extreme drought, and in 2023 they had 3 months in that class, 
  # and likewise in exceptional drought, the average in a year is 0.6 but this year they got 2
  
  # QC the 2023 pattern
  dat <- dat_long_yy2
  dat2 <- dat[dat$year=="2023",]
  dat2[gid == 480,]
  dat2 <- dcast(dat2[,c("gid", 'lon', 'lat', 'variable', 'excess_drt')], gid + lon + lat ~ variable)
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
  par(mfrow = c(2,2))
  for(i in c("severe", "extreme", "exceptional")){
    r_out <- rasterize(vect, rast(r), field = i, fun = mean)
    plot(r_out, main = paste('excess', i))
  }
  # this shows that in 2023 WA had more area in excess exceptional drought than in excess severe drought
  
  #### compare this to 2019 flash drought ####
  dat2 <- dat[dat$year=="2019",]
  dat2 <- dcast(dat2[,c("gid", 'lon', 'lat', 'variable', 'excess_drt')], gid + lon + lat ~ variable)
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
  par(mfrow = c(2,2))
  for(i in c("severe", "extreme", "exceptional")){
    r_out <- rasterize(vect, rast(r), field = i, fun = mean)
    plot(r_out, main = paste('excess', i))
  } 
  
}