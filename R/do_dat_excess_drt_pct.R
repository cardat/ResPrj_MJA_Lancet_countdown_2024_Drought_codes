## tar_load(dat_excess_drt)
do_dat_excess_drt_pct <- function(
  dat_excess_drt
){
  summary(dat_excess_drt)
  toplot <- dat_excess_drt[,.(excess_drt_n = sum(excess_drt), n = .N,
                            excess_drt_pct = (sum(excess_drt)/.N)*100 ) ,
                         by=.(year,variable)]
  toplot[order(year, variable)]
  summary(toplot)
  return(toplot)
}