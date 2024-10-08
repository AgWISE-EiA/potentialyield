# Run the simulation for the entire study area  
#' Title length(my_list_clm)
#' @param my_list_clm 
#' @param extd.dir 
#' @param stn 
#' @return
#' @export
#' @examples
my_list_sim<- function(crop, my_list_clm, extd.dir, stn, my_list_soil){

  cores<- detectCores()
  myCluster <- makeCluster(cores -2, # number of cores to use
                           type = "PSOCK") # type of cluster
  registerDoParallel(myCluster)
  my_list_sims<- foreach (i =1:length(my_list_clm)) %dopar% {  
    setwd(paste0(extd.dir, '/', i)) 
    tryCatch(apsimx::apsimx(crop, value = "HarvestReport"), error=function(err) NA)
  }
  newlist<- foreach (i =1:length(my_list_clm)) %dopar% { 
    if(is.na(my_list_sims[i]) == TRUE) {
      setwd(paste0(extd.dir, '/', i)) 
      my_list_soil[[i]]$SoilName_1$crops <- c("Rice","Wheat","Teff","Sugarcane","Maize","Soybean","OilPalm","Cassava")
      apsimx::edit_apsimx_replace_soil_profile(crop, root = c("pd", "Base_one"), soil.profile = my_list_soil[[i]]$SoilName_1, overwrite = TRUE) 
      my_list_sims[[i]]<-tryCatch(apsimx::apsimx(crop, value = "HarvestReport"), error=function(err) NA)
    }
    else  my_list_sims[[i]]
  }
  
   return(newlist)
}

