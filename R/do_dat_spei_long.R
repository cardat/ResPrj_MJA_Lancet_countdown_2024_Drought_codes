## tar_load(dat_spei)
do_dat_spei_long <- function(
  dat_spei
){
  dat_spei <- unwrap(dat_spei)
  wide <- as.data.frame(dat_spei, xy = TRUE)
  str(wide)
  setDT(wide)
  long <- melt(wide, 
               id.vars = c("x", "y"),  
               variable.name = "date", 
               value.name = "spei"    
  )
  long[, date := gsub("X", "", gsub("\\.", "-", date))]
  names(long) <- c('lon', 'lat', 'date', 'SPEI')
  long
  
}