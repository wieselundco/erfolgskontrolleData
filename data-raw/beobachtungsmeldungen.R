## code to prepare `beobachtungsmeldungen` dataset goes here

## Beobachtungsmeldungen ###################################################


library(DBI)
library(sf)
conn = DBI::dbConnect(
  RPostgres::Postgres(),
  host = "svma-s-01348.zhaw.ch",
  dbname = "wieselundco",
  user = rstudioapi::askForPassword("Database user"),
  password = rstudioapi::askForPassword("Database password")
)


beobachtungsmeldungen <- read_sf(conn,
                                 query = "SELECT datum, name,name_genauigkeit_datum, name_sichtungsart,name_lagegenauigkeit, status,erfassungsdatum, geom  FROM wico.beobachtungsmeldungen_joined",
                                 crs = 2056)




usethis::use_data(beobachtungsmeldungen, overwrite = TRUE)
