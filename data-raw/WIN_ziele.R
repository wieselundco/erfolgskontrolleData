## code to prepare `WIN_ziele` dataset goes here

library(readr)

WIN_ziele <- read_csv("data-raw/WIN_ziele.csv")

usethis::use_data(WIN_ziele, overwrite = TRUE)
