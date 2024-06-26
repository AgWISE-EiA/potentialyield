#################################################################################################################
## source "get_RS_Croptype.R" functions and execute it for Rwanda RAB Maize use case
#################################################################################################################

source("~/agwise-potentialyield/dataops/potentialyield/Script/generic/RemoteSensing/get_RS_Croptype.R")

country = "Rwanda"
useCaseName = "RAB"
level = 1
admin_unit_name = NULL
Planting_year = 2021
Harvesting_year = 2022
Planting_month = "September"
Harvesting_month = "June"
overwrite = TRUE
crop = c("Maize")
coord = c("lon", "lat")
CropMask = FALSE

CropType (country, useCaseName, level, admin_unit_name, Planting_year, Harvesting_year, Planting_month, Harvesting_month, crop, coord, overwrite, CropMask)