## code to prepare `asthaufen_qualitaet` dataset goes here


library(readxl)
library(janitor)
library(dplyr)
library(forcats)
library(stringr)
library(purrr)
# ort
# ah_id
# alter_datum_erstellung
# astmaterial_grob_fein_4_3_2_1_0
# volumen_gross_klein_4_3_2_1_0
# storung_klein_gross_4_3_2_1_0
# beute_angebot_gross_klein_4_3_2_1_0
# katzen_wenig_viel_4_3_2_1_0
# andere_feinde_wenig_viel_4_3_2_1_0
# benachbarte_kleinstr_viel_wenig_4_3_2_1_0
# benachbarte_korridore_habitate_gunstig_ungunstig_4_3_2_1_0
# pflege_auf_stockung_gut_schlecht_4_3_2_1_0
# total_nach_weise_wk_2019_2020
# hermelin
# iltis
# mauswiesel

asthaufen_qualitaet <- read_excel("data-raw/WK_Qualitativ_Ah_20210408.xlsx", 1, range = "B1:R28") %>%
  clean_names() %>%
  select(-punkte_summe) %>%
  filter(ort != "Mittelwert") %>%
  rename_with(~str_replace(., "_[a-z]+_[a-z]+_4_3_2_1_0","")) %>%
  rename(pflege_aufstockung = pflege_auf_stockung) %>%
  mutate(
    across(4:12, ~as.integer(.))
  )


code_explanation <- tibble::tribble(
  ~Code, ~astmaterial,     ~volumen,     ~storung, ~beute_angebot,      ~katzen, ~andere_feinde, ~benachbarte_kleinstr, ~benachbarte_korridore_habitate, ~pflege_aufstockung,
     4L,  "sehr grob", "sehr gross", "sehr klein",   "sehr gross", "sehr wenig",   "sehr wenig",                  "sehr viel",         "sehr günstig",          "sehr gut",
     3L,       "grob",       "gross",      "klein",        "gross",      "wenig",        "wenig",                       "viel",              "günstig",               "gut",
     2L,     "mittel",     "mittel",     "mittel",       "mittel",     "mittel",       "mittel",                     "mittel",               "mittel",            "mittel",
     1L,       "fein",      "klein",      "gross",        "klein",       "viel",         "viel",                      "wenig",            "ungünstig",          "schlecht",
     0L,  "sehr fein", "sehr klein", "sehr gross",   "sehr klein",  "sehr viel",    "sehr viel",                 "sehr wenig",       "sehr ungünstig",     "sehr schlecht"
  )



codes <- tail(colnames(code_explanation),-1)
codes <- setNames(codes, codes)
asthaufen_qualitaet_list <- map(codes, function(code, placeholder){

  # select all columns that are not in codes
  sel <- !(colnames(asthaufen_qualitaet) %in% codes)

  ashaufen_sel <- asthaufen_qualitaet %>%
    select(all_of(code))%>%
    pull()

  asthaufen_qualitaet <- asthaufen_qualitaet[,sel]

  code_fac <- code_explanation[, c("Code", code)]

  asthaufen_qualitaet$beurteilung <- factor(ashaufen_sel, levels = code_fac$Code, labels = pull(code_fac, code), ordered = TRUE)
  asthaufen_qualitaet
})

usethis::use_data(code_explanation, overwrite = TRUE)
usethis::use_data(asthaufen_qualitaet, overwrite = TRUE)
usethis::use_data(asthaufen_qualitaet_list, overwrite = TRUE)


