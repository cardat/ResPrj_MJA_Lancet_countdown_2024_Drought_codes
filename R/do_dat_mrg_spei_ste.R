# tar_load(dat_ste)
# tar_load(dat_spei_crop)
do_dat_mrg_spei_ste <- function(
  in_ste = dat_ste
  , 
  dat_spei_crop
){
  r_spei <- unwrap(dat_spei_crop)
  
  e <- terra::extract(r_spei, in_ste, fun = mean)
  #  str(e[,1:10])
  #  e[,c(1, 6:9)]
  e$STE_CODE16 <- e$ID
  e$ID <- NULL
  # st_drop_geometry(in_ste)
  e2 <- merge(st_drop_geometry(in_ste), e, by = "STE_CODE16")
  setDT(e2)
  e_out <- melt(e2, id.var = c("STE_CODE16", "STE_NAME16", "AREASQKM16"))
  e_out$date <- gsub("X", "", gsub("\\.", "-", e_out$variable))
  e_out$date <- as.Date(e_out$date)
  
  return(e_out)
}