

get_driver_file <- function(filepath, nhd_id){
  temp_path <- mda.lakes::get_driver_path(nhd_id)
  file.copy(from = temp_path, to = filepath)
}

get_nml_file <- function(filepath, nhd_id, meteopath, ...){
  
  nml <- populate_base_lake_nml(site_id = nhd_id, ...,
                                driver = meteopath)
  write_nml(glm_nml = nml, file = filepath)
}

run_export_temp <- function(outfile, nmlpath, simnml, ...){
  
  nml <- read_nml(nmlpath)
  nml <- set_nml(nml, arg_list = list(...))
  write_nml(glm_nml = nml, file = simnml)
  
  run_glm('data')
  unlink(simnml)
  
  browser()
  temp_data <- get_temp('data/output.nc', reference = 'surface', z_out = seq(0, 24, by=0.5))
  plot_temp()
  unlink('data/output.nc')
  readr::write_tsv(x = temp_data, path = outfile)
  
}