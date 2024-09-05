## tar_load(dat_excess_drt_pct)
## tar_load(dat_mrg_spei_ste)
do_fig_long_yy_pct_area <- function(
  toplot = dat_excess_drt_pct
  ,
  indat0 = dat_mrg_spei_ste
  ,
  outfile = "figures_and_tables/dat_long_yy_pct_area_V20240829.png"
){
  lwdi = 2.5
  toplot <- toplot[year < 2024]
  png(outfile, width = 1000, height = 1250, res = 100)
  par(mfrow = c(2,1))
  var_todo <- "severe"
  with(toplot[variable == var_todo], plot(year, excess_drt_pct, type = "l", col = "darkblue", 
                                     lwd = lwdi,
                                     ylab = "% of land area",
                                     xlab = "Year"))
  axis(side = 1, at = c(1950, 1970, 1990, 2010), labels = c("1950", "1970", "1990", "2010"))
  var_todo <- "extreme"
  with(toplot[variable == var_todo], lines(year, excess_drt_pct, col = "darkgrey", lwd = lwdi))
  var_todo <- "exceptional"
  with(toplot[variable == var_todo], lines(year, excess_drt_pct, col = "orange", lwd = lwdi))
  segments(1950:2023, 0, 1950:2023, 80, lty = 2, col = "lightgrey")
  legend("topleft", legend = c("Excess severe drought", "Excess extreme drought", "Excess exceptional drought"), lwd = lwdi, 
         col = c("darkblue", "darkgrey", "orange"))
  title("A)", adj = 0)
  
  
  
  #### spei by year 
  indat0[,year :=  substr(date, 1, 4)]
  
  indat <- indat0[,.(value = mean(value, na.rm=T)), by = .(STE_NAME16, year)][order(STE_NAME16, year)]
  ste_todo <- unique(indat$STE_NAME16)
  # exclude OT
  ste_todo <- ste_todo[c(1:3,5:9)]
  ste_todo
  
  with(indat[STE_NAME16 == ste_todo[1]], plot(year, value, type = "l", col = 1, axes = T, ylab = '', ylim = c(-1.7,1.7)))
  abline(0,0)
  for(i in 2:8){
    # i = 2
    with(indat[STE_NAME16 == ste_todo[i]], lines(year, value,
                                             col = i
                                             )
         )
  }
  spei_national <- indat0[,.(spei_av = mean(value, na.rm=T)), by = .(year)][order(year)]
  with(spei_national, lines(year, spei_av, lwd = 3, col = 'black'))
  abline(h = c(2,1,-1,-2), lty = 2)
  legend("bottomleft", legend = c(ste_todo, "National"), col = c(1:length(ste_todo),1), lty = 1, lwd = c(rep(1,length(ste_todo)), 3), bg = "white", cex = .8)
  
  title("B)", adj = 0)
    
  dev.off()
}
