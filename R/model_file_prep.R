

get_driver_file <- function(filepath, nhd_id){
  temp_path <- mda.lakes::get_driver_path(nhd_id)
  file.copy(from = temp_path, to = filepath)
}

get_nml_file <- function(filepath, nhd_id, meteopath){
  nml <- populate_base_lake_nml(site_id = nhd_id, 
                                driver = meteopath)
  write_nml(glm_nml = nml, file = filepath)
}