## tar_load(dat_spei_crop)
do_dat_spei_long <- function(
  dat_spei_crop
){
  dat_spei_crop <- unwrap(dat_spei_crop)
  wide <- as.data.frame(dat_spei_crop, xy = TRUE)
  wide$gid <- 1:nrow(wide)
  str(wide)
  setDT(wide)
  gid <- wide[,.(gid, x, y)]
  write.csv(gid, "working_ivan/gid.csv", row.names = F)
  
  long <- melt(wide, 
               id.vars = c("gid","x", "y"),  
               variable.name = "date", 
               value.name = "spei"    
  )
  long[, date := gsub("X", "", gsub("\\.", "-", date))]
  names(long) <- c('gid','lon', 'lat', 'date', 'SPEI')
  # long[gid == 1 & substr(date, 1,4) == 2019]
  return(long)
}