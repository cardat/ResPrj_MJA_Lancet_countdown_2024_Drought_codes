## tar_load(dat_drt_sev_long)
do_dat_excess_drt <- function(
  dat_drt_sev_long
){

  # dcast(dat_drt_sev_long[gid == 480 & year == 2023], gid + lon + lat + date + year ~ variable)
  dat_long_yy <- dat_drt_sev_long[,
                                  .(yrly_cnt_mo_in_drt = sum(value, na.rm = T)), 
                                  by=.(gid,variable, year, lon, lat)]
  
  # calc mean yrly_cnts over baseline period 1950-2005, and 2 SD above this. NOTE THAT 1950 only has 6 valid months, so exclude it
  thresh_dat_long_yy <- dat_long_yy[year %in% 1951:2005, 
                                         .(mean_yrly_cnts = mean(yrly_cnt_mo_in_drt),
                                           sd_yrly_cnts = sd(yrly_cnt_mo_in_drt),
                                           sd_yrly_cnts_thresh = mean(yrly_cnt_mo_in_drt) + (sd(yrly_cnt_mo_in_drt) * 2)
                                         ), 
                                         by = .(gid, variable)]
  
  # excess_drt is >if(mean_yrly_cnts + (2 * sd_yrly_cnts))
  dat_long_yy2 <- merge(dat_long_yy, thresh_dat_long_yy, by = c("gid", "variable"))
  
  dat_long_yy2$excess_drt <- ifelse(dat_long_yy2$yrly_cnt_mo_in_drt > 
                                      (dat_long_yy2$mean_yrly_cnts + (2*dat_long_yy2$sd_yrly_cnts)), 
                                    1, 0)
  
  
  return(dat_long_yy2)
}