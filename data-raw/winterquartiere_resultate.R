## code to prepare `winterquartiere_resultate` dataset goes here

library(tidyverse)
library(readxl)


winterquartiere_resultate <- list(erhebung2019 = c("B", "K"), erhebung2020 = c("L", "U")) %>%
  imap_dfr(function(index, erhebung){
    range <- paste0(index[1],2,":",index[2],13)
    read_xlsx("data-raw/Rohdaten_Erhebung_2019_2020.xlsx",sheet = "Winterquartiere",  range = range) %>%
      mutate(across(.fns = ~case_when(
        . == "x"~TRUE,
        is.na(.)~FALSE,
        . == "-"~NA
      )
      )) %>%
      mutate(erhebung = as.integer(str_remove(erhebung, "erhebung"))) %>%
      cbind(read_xlsx("data-raw/Rohdaten_Erhebung_2019_2020.xlsx",sheet = "Winterquartiere",  range = "A3:A13",col_names = "struktur"))
  }
  )






usethis::use_data(winterquartiere_resultate, overwrite = TRUE)
