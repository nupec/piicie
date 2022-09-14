
nuts_raw <- readxl::read_xlsx("NUTS_raw.xlsx") |>
  janitor::clean_names()

base <- nuts_raw |>
  tidyr::fill(nuts_ii_de_2013, nuts_iii_de_2013) |>
  tidyr::drop_na()

