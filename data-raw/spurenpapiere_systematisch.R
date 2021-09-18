## code to prepare `spurenpapiere_systematisch` dataset goes here
## Erhebung Formell #########################################################

library(purrr)
library(dplyr)

sheets <- c("Phase_1_2019", "Phase_2_2020")

spurenpapiere_systematisch <- map_dfr(sheets, function(sheet_i){
  spurenpapiere_systematisch <-read_xlsx("data-raw/Rohdaten_Erhebung_2019_2020.xlsx",sheet = sheet_i,  skip = 0) %>%
    as_tibble()

  periode_int <- as.character(spurenpapiere_systematisch[1,])[!is.na(as.integer(spurenpapiere_systematisch[1,]))]
  periode_dat <- as.character(spurenpapiere_systematisch[2,])[!is.na(as.integer(spurenpapiere_systematisch[1,]))]
  perioden <- tibble(periode_int = periode_int, periode_dat = periode_dat) %>%
    separate(periode_dat, c("von","bis")," - ") %>%
    mutate_at(2:3,~as.Date(.,format = "%d.%m.%Y"))


  spurenpapiere_systematisch <- as.data.frame(spurenpapiere_systematisch)
  spurenpapiere_systematisch[1,] <- zoo::na.locf(as.character(spurenpapiere_systematisch[1,]))

  spurenpapiere_systematisch <- as_tibble(spurenpapiere_systematisch)

  spurenpapiere_systematisch <- spurenpapiere_systematisch[,which(str_detect(as.character(as.vector(spurenpapiere_systematisch[3,])),"Struktur ID|Hermelin|Mauswiesel|Iltis|Mäuse|Steinmarder|Siebenschläfer|Hauskatze|Frosch|Igel|Vogel|Eichhörnchen|Fuchs|Dachs|unbekannt"))]
  # |Ratte|||

  cnames <- paste(spurenpapiere_systematisch[1,],spurenpapiere_systematisch[3,],sep = "_")
  cnames[1] <- "struktur_id"
  colnames(spurenpapiere_systematisch) <- cnames

  spurenpapiere_systematisch <- tail(spurenpapiere_systematisch,-3) %>%
    mutate(struktur_id = as.integer(struktur_id))

  spurenpapiere_systematisch <- spurenpapiere_systematisch %>%
    pivot_longer(-1,names_to = c("Periode","tierart"),names_sep = "_",values_to = "Detektion") %>%
    mutate(Detektion = !is.na(Detektion)) %>%
    rename(kontrollperiode = Periode) %>%
    left_join(perioden, by = c("kontrollperiode" = "periode_int")) %>%
    mutate(phase = sheet_i)
}) %>%
  mutate(
    phase = factor(phase,levels = sheets,labels = c("Herbst '19","Frühling '20")),
    zielart = str_detect(tierart,"Iltis|Hermelin|Mauswiesel")
  )



usethis::use_data(spurenpapiere_systematisch, overwrite = TRUE)
