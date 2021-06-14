## code to prepare `nachweiserfolge_zusammenstellung` dataset goes here


library(readr)

nachweiserfolge_zusammenstellung <- read_delim("data-raw/nachweiserfolge_zusammenstellung.csv", ";")

usethis::use_data(nachweiserfolge_zusammenstellung, overwrite = TRUE)
