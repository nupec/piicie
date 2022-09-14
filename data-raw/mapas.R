# Carregar pacotes -------------
library(sf)
library(geobr)
library(ggplot2)
library(dplyr)
library(fs)


# Trabalhando com bases georreferenciadas -----------------


freguesias <- st_read("data-raw/shp/Cont_AAD_CAOP2021/Cont_AAD_CAOP2021.shp",
                      quiet = TRUE) |>
  janitor::clean_names()

# freguesias |>
#   ggplot() +
#   geom_sf()

conselhos <- st_read("data-raw/shp/concelhos-shapefile/concelhos.shp",
                     quiet = TRUE) |>
  janitor::clean_names()

continente <- dplyr::filter(conselhos, !name_1 %in% c("Madeira", "Azores"))

continente |>
    ggplot() +
    geom_sf()

writexl::write_xlsx(continente, "data/xlsx/baseMapaConselhos.xlsx")
