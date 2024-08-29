## tar_load(dat_spei_long)
do_dat_drt_severity <- function(
    dat_spei_long
){
  dat_spei_long[, `:=`(severe = SPEI < -1.3,
                       extreme = SPEI < -1.6,
                       exceptional = SPEI < -2.0)]
  return(dat_spei_long)
}