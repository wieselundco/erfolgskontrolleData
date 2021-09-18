## code to prepare `bezirksgrenze_horge` dataset goes here

library(sf)

horgen <- read_sf("data-raw/bezirksgrenze_horgen.gpkg")


usethis::use_data(horgen, overwrite = TRUE)
