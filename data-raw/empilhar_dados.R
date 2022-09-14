library(tidyverse)
library(readxl)

caminho <- list.files("data-raw/DEGES-Escola/", full.names = T)

base <- purrr::map_dfr(caminho, read_xlsx)

writexl::write_xlsx(base, "data-raw/matricula1419Genero.xlsx")

readr::write_rds(base, "data/rds/matricula1419Genero.rds")
#
# nuts <- read_xlsx("data-raw/NUTS.xlsx")

