## tar_load(dat_drt_severity)
do_dat_drt_sev_long <- function(
  dat= dat_drt_severity
){
  dat_long <- melt(dat[,c("gid","lon","lat","date","severe", "extreme", "exceptional")], 
                   id.vars = c("gid","lon","lat","date"))
  dat_long[,year := substr(date, 1,4)]
  
  # qc<-dat_long[gid == 692 & year == 2019][order(date, variable)]
  # dcast(qc, gid + lon + lat + date + year ~ variable)
  # qc<-dat_long[gid == 480 & year == 2023][order(date, variable)]
  # dcast(qc, gid + lon + lat + date + year ~ variable)
  # qc <- dat_long[substr(date, 1,4)== '2019']
  # table(qc$value, qc$variable)
  
  return(dat_long)
}