

get_driver_file <- function(filepath, nhd_id){
  temp_path <- mda.lakes::get_driver_path(nhd_id)
  
  drivers <- driver_add_rain(read_csv(temp_path))
  
  write.csv(drivers, filepath, row.names=FALSE, quote=FALSE)
}

get_nml_file <- function(filepath, nhd_id, meteopath, bathy = NULL, ...){
  
  if (!is.null(bathy)){
    nml <- populate_base_lake_nml(site_id = nhd_id, bathy = bathy, 
                                  driver = meteopath)
  } else {
    nml <- populate_base_lake_nml(site_id = nhd_id, driver = meteopath)
  }
  
  nml <- set_nml(nml, arg_list = list(...))
  write_nml(glm_nml = nml, file = filepath)
}

run_export_temp <- function(outfile, nmlpath, simnml){
  
  nml <- read_nml(nmlpath)
  write_nml(glm_nml = nml, file = simnml)
  message(get_nml_value(nml, 'A'))
  run_glm('data',  verbose = TRUE)
  unlink(simnml)
  plot_temp('data/output.nc', reference = 'surface')
  temp_data <- get_temp('data/output.nc', reference = 'surface', z_out = seq(0, 24, by=0.5))

  feather::write_feather(temp_data, outfile)
  
}