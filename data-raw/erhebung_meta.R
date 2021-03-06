## code to prepare `erhebung_meta` dataset goes here

library(tibble)

erhebung_meta <- tibble::tribble(
  ~Bezeichnung,       ~Strukturen,                   ~Zeitraum,     ~Dauer,                    ~Methode,                     ~Anzahl,
  "Erhebung 1",       "Asthaufen", "Herbst ’19 / Frühling ‘20", "6 Wochen",              "Spurentunnel",              "39 Asthaufen",
  "Erhebung 2", "Winterquartiere", "Herbst ’19 / Frühling ‘20", "6 Wochen",                "Fotofallen",        "11 Winterquartiere",
  "Datensatz A",       "Asthaufen",               "2014 - 2019", "Variabel", "Spurentunnel / Fotofallen",              "32 Asthaufen",
  "Datensatz B",           "Keine",               "2014 – dato",  "laufend",    "Beobachtungs-meldungen", "> 500 Einzelbeobachtungen"
)

usethis::use_data(erhebung_meta, overwrite = TRUE)
