

baseModelo1 <- dplyr::full_join(matriculaPT, retencaoPT, by = "chave")

equidadePT <- equidadePT

baseModelo <- dplyr::left_join(baseModelo1, equidadePT, by = "chave")

# readr::write_rds(baseModelo, "data/rdsbaseModelo.rds")
#
# writexl::write_xlsx(baseModelo, "data/xlsx/baseModelo.xlsx")
