library(targets)

lapply(list.files("R", full.names = TRUE), source)

tar_option_set(
  packages =
    c("targets", "data.table", "ncdf4", "raster", "terra", "sf")
)

# Load config settings
config <-source("config.R")

list(
  ####  dat_ste ####
  tar_target(
    dat_ste,
    load_dat_ste(infile_ste = file.path(indir_ste, infile_ste))
  )
  ,
  ####  dat_spei ####
  tar_target(
    dat_spei,
    load_dat_spei(infile = file.path(indir_spei, infile_spei)
                  ,
                  in_ste = dat_ste
    )
  )
  ,
  ####  dat_spei_crop ####
  tar_target(
    dat_spei_crop,
    do_dat_spei_crop(dat_spei, dat_ste)
  )
  ,
  ####  dat_spei_long ####
  tar_target(
    dat_spei_long,
    do_dat_spei_long(dat_spei_crop)
  )
  ,
  ####  dat_drt_severity ####
  tar_target(
    dat_drt_severity,
    do_dat_drt_severity(dat_spei_long)
  )
  ,
  ####  fig_qc_raster ####
  tar_target(
    fig_qc_raster,
    do_fig_qc_raster(dat_drt_severity)
  )
  ,
  ####  dat_drt_sev_long ####
  tar_target(
    dat_drt_sev_long,
    do_dat_drt_sev_long(dat_drt_severity)
  )
  ,
  ####  dat_excess_drt ####
  tar_target(
    dat_excess_drt,
    do_dat_excess_drt(dat_drt_sev_long)
  )
  ,
  ####  fig_maps ####
  tar_target(
    fig_maps,
    do_fig_maps(dat_excess_drt)
  )
  ,
  ####  dat_excess_drt_pct ####
  tar_target(
    dat_excess_drt_pct,
    do_dat_excess_drt_pct(dat_excess_drt)
  )
  ,
  ####  fig_map_signif_defecit ####
  tar_target(
    fig_map_signif_defecit,
    do_fig_map_signif_defecit(dat_drt_severity)
  )
  ,
  ####  dat_mrg_spei_ste ####
  tar_target(
    dat_mrg_spei_ste,
    do_dat_mrg_spei_ste(dat_ste, dat_spei_crop)
  )
  ,
  ####  fig_long_yy_pct_area ####
  tar_target(
    fig_long_yy_pct_area,
    do_fig_long_yy_pct_area(
      dat_excess_drt_pct
      ,
      dat_mrg_spei_ste
      ,
      outfile = "figures_and_tables/dat_long_yy_pct_area_V20240829.png"
    )
  )
  
)
