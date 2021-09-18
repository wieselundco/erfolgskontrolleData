## code to prepare `nachweise_spontan` dataset goes here

## Wirkungskontrolle Informell ##############################################

library(readxl)
library(stringr)
library(purrr)
library(tidyr)
library(dplyr)
library(ISOweek)
sheetpath <- "data-raw/Wirkungskontrolle_informell_2019-11-09.xlsx"

sheets <- excel_sheets(sheetpath)

sheets <- sheets[!str_detect(sheets, "MASTER|blanko")]

nachweise_spontan <- sheets %>%
  map_dfr(function(x){

    sheet_i <- read_xlsx(sheetpath, x) %>%
      dplyr::select(1:16) %>%
      mutate(
        Struktur = x,
        Jahr = as.integer(Jahr)
      ) %>%
      fill(Jahr)

    sheet_fil <- sheet_i %>%
      filter(Ctrl != 0, Jahr != "Summe", Jahr != "Anz Ctrl")

    sheet_fil
  })


date_from_week <- function(year, week, weekday = 1){
  require(ISOweek)
  w <- paste0(year, "-W", sprintf("%02d", week), "-", weekday)
  ISOweek2date(w)
}

nachweise_spontan <- nachweise_spontan %>%
  filter(!is.na(KW)) %>%
  mutate(date = date_from_week(Jahr,KW))

usethis::use_data(nachweise_spontan, overwrite = TRUE)
