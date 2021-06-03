## code to prepare `winterquartier_monitoring` dataset goes here

library(readr)
library(dplyr)

winterquartier_monitoring <- read_csv("data-raw/winterquartiere.csv") %>%
  transmute(struktur_id, monitoring_typ = "fotofalle")


asthaufen_monitoring <- read_csv("data-raw/Standorte_Monitoring_Asthaufen_2019-2020.csv") %>%
  transmute(struktur_id = spurentunnel_nummer, monitoring_typ = "spurentunnel")


monitoring_systematisch <- rbind(asthaufen_monitoring, winterquartier_monitoring)

usethis::use_data(monitoring_systematisch, overwrite = TRUE)
