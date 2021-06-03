## code to prepare `strukturen_alle` dataset goes here
library(DBI)
library(sf)
conn = DBI::dbConnect(
  RPostgres::Postgres(),
  host = "svma-s-01348.zhaw.ch",
  dbname = "wieselundco",
  user = rstudioapi::askForPassword("Database user"),
  password = rstudioapi::askForPassword("Database password")
)


## Strukturen ##############################################################


strukturen_alle <- DBI::dbGetQuery(conn, "SELECT * FROM wico.strukturen WHERE datum IS NOT NULL and x IS NOT NULL") %>%
  st_as_sf(coords = c("x","y"), crs = 2056)

usethis::use_data(strukturen_alle, overwrite = TRUE)

