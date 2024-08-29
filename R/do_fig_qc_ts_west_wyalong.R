## tar_load(dat_drt_severity)
do_fig_qc_ts_west_wyalong <- function(
  dat_drt_severity
){
  dat <- dat_drt_severity[gid==692,]
  dat[,year := substr(date, 1, 4)]
  
  dat[year > 2018]
  
  with(dat, plot(as.Date(date), SPEI, type = 'l'))
  abline(0,0)
  dev.off()
}