## code to prepare `erhebungswochen` dataset goes here

library(tibble)
library(dplyr)
library(forcats)
library(lubridate)

erhebungswochen <- tribble(
  ~von, ~bis,
  "26.08.2019", "05.09.2019",
  "05.09.2019", "17.09.2019",
  "17.09.2019", "25.09.2019",
  "25.09.2019", "07.10.2019",
  "01.04.2020", "09.04.2020",
  "09.04.2020", "16.04.2020",
  "16.04.2020", "23.04.2020",
  "23.04.2020", "01.05.2020",
  "01.05.2020", "09.05.2020",
  "09.05.2020", "18.05.2020"
) %>%
  mutate_all(~as.Date(., format = "%d.%m.%Y")) %>%
  mutate(
    Phase = ifelse(year(von) == 2019,"Herbst 2019","Frühling 2020"),
    Phase = fct_rev(Phase)
  )

usethis::use_data(erhebungswochen, overwrite = TRUE)
