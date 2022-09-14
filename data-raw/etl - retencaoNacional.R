library(dplyr)

### Carregando as bases
# Fonte: https://www.dgeec.mec.pt/np4/248/

# url("https://www.dgeec.mec.pt/np4/248/%7B$clientServletPath%7D/?newsId=382&fileName=DGEEC_DSEE_DEEBS_2022_TxRetDes_NUTSIII20.xlsx")
# 1 Ciclo -----------------------------------------------------------------------------------

# Taxa de retenção e desistência (%), por sexo, nível de ensino, ciclo de estudos e ano de escolaridade -
#   Continente, NUTS II, III e Municípios – 2003/04 a 2020/2

Retencao <- readxl::read_excel("data-raw/Retenção/Tx_Ret-2003-2021.XLSX") |>
  janitor::clean_names()

base <- Retencao |>
  tidyr::fill("nut_i_continente", "nuts_ii_de_2013", "nuts_iii_de_2013")|>
  tidyr::drop_na(municipio) |>
  dplyr::filter(ano %in% c(2017, 2018, 2019))


baseRetencao <- dplyr::select(base, c(ano, ano_letivo, dico,
                                       municipio, cb, sec)) |>
  tidyr::pivot_longer(
    cols = c(cb, sec),
    names_to = "ciclo",
    values_to = "tx_ret"
  ) |>
  dplyr::mutate(
    chave = paste(dico, ano_letivo, ciclo, sep = "_")
  ) |>
  dplyr::relocate(chave, .before = ano) |>
  dplyr::arrange(municipio, ano) |>
  dplyr::select(-ano_letivo)


# readr::write_rds(baseRetencao, "data/rds/baseRetencao.rds")
#
# writexl::write_xlsx(baseRetencao, "data/xlsx/baseRetencao.xlsx")

# basetidy <- baseMunicipio |>
#   tidyr::pivot_longer(
#     cols =  eb:sec_cttp2,
#     names_to = "ano_escolar",
#     values_to = "taxa_retencao"
#   )
#
#
# baseCiclos <- dplyr::filter(basetidy,
#                            ano_escolar == c("eb", "cb1", "cb2",  "cb3", "sec_cc_ht_p",
#                                             "sec_cgch", "sec_cttp2"))
#

# baseCiclos1 <- baseCiclos |>
#   dplyr::mutate(
#     ano = stringr::str_remove_all(baseCiclos$ano, "/04", "/05", "/06", "/08",
#                                                 "/09", "/10", "/11", "/12",
#                                                 "/13", "/14", "/15", "/16",
#                                                 "/17", "/18", "/19", "/20", "/21")
#   )
#
#   stringr::str_replace_all(baseCiclos$ano, c("/04", "/05"= "", "/06", "/08"= "",
#                                              "/09", "/10"= "", "/11", "/12"= "",
#                                              "/13", "/14"= "", "/15", "/16"= "",
#                                              "/17", "/18"= "", "/19", "/20"= "", "/21"))
#


# Retencao1CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_1Ciclo_DadosPorRegiao.xlsx",
#                              sheet = "Retencao") |>
#   janitor::clean_names()
#
#
# # Empilhando as bases
#
# base <- Retencao1CicloPorRegiao
#
# nomesCol <- names(base)
#
# ret1ciclo <- NULL
# aux <- NULL
#
# (seq1 <- seq(4, 19 , 5))
#
# for (i in seq1) {
#
#   print(paste("Início do processo. Base", i, "empilhada"))
#
#   aux <- base |> dplyr::select(1:3, i,i+1, i+2, i+3, i+4) |>
#     dplyr::rename(
#       ano = nomesCol[all_of(i)],
#       ano1  = nomesCol[all_of(i)+1],
#       ano2  = nomesCol[all_of(i)+2],
#       ano3  = nomesCol[all_of(i)+3],
#       ano4  = nomesCol[all_of(i)+4]
#     )
#   ret1ciclo <- rbind(ret1ciclo, aux)
#
# }
#
# ret1ciclo <- ret1ciclo|>
#   tidyr::pivot_longer(
#     cols = ano1:ano4,
#     names_to = "anocurricular",
#     values_to = "retenção"
#   ) |>
#   dplyr::mutate(across(
#     .data,
#     .cols = "retenção",
#     .fns = as.numeric
#   ))
#
#  rm(Retencao1CicloPorRegiao)
#
# # 2 Ciclo -------------------------------------------------------------------------------------
#
# Retencao2CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_2Ciclo_DadosPorRegiao.xlsx",
#                                             sheet = "Retencao") |>
#   janitor::clean_names()
#
# # Empilhando as bases
#
# base <- Retencao2CicloPorRegiao
#
# nomesCol <- names(base)
#
# ret2ciclo <- NULL
# aux <- NULL
#
# (seq1 <- seq(4, 13, 3))
#
# for (i in seq1) {
#
#   print(paste("Início do processo. Base", i, "empilhada"))
#
#   aux <- base |> dplyr::select(1:3, i,i+1, i+2) |>
#     dplyr::rename(
#       ano = nomesCol[all_of(i)],
#       ano5  = nomesCol[all_of(i)+1],
#       ano6  = nomesCol[all_of(i)+2]
#     )
#   ret2ciclo <- rbind(ret2ciclo, aux)
# }
#
# ret2ciclo <- ret2ciclo |>
#   tidyr::pivot_longer(
#   cols = ano5:ano6,
#   names_to = "anocurricular",
#   values_to = "retenção")|>
#   dplyr::mutate(across(
#     .data,
#     .cols = "retenção",
#     .fns = as.numeric
#   ))
#
#  rm(Retencao2CicloPorRegiao)
#
# # 3 Ciclo -------------------------------------------------------------------------------------
#
# Retencao3CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_3Ciclo_DadosPorRegiao.xlsx",
#                                             sheet = "Retencao") |>
#   janitor::clean_names()
#
# # Empilhando as bases
#
# base <- Retencao3CicloPorRegiao
#
# nomesCol <- names(base)
#
# ret3ciclo <- NULL
# aux <- NULL
#
# (seq1 <- seq(4, 16, 4))
#
# for (i in seq1) {
#
#   print(paste("Início do processo. Base", i, "empilhada"))
#
#   aux <- base |> dplyr::select(1:3, i,i+1, i+2, i+3) |>
#     dplyr::rename(
#       ano = nomesCol[all_of(i)],
#       ano7  = nomesCol[all_of(i)+1],
#       ano8  = nomesCol[all_of(i)+2],
#       ano9  = nomesCol[all_of(i)+3]
#     )
#   ret3ciclo <- rbind(ret3ciclo, aux)
# }
#
#   ret3ciclo <- ret3ciclo |>  tidyr::pivot_longer(
#   cols = ano7:ano9,
#   names_to = "anocurricular",
#   values_to = "retenção") |>
#     dplyr::mutate(across(
#       .data,
#       .cols = "retenção",
#       .fns = as.numeric
#     ))
#
#  rm(Retencao3CicloPorRegiao)
#
# # Secundário -------------------------------------------------------------------------------------
#
# RetSecPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_Secundario_CH_DadosPorRegiao.xlsx",
#                                             sheet = "Retencao") |>
#   janitor::clean_names()
#
# # Empilhando as bases
#
# base <- RetSecPorRegiao
#
# nomesCol <- names(base)
#
# retsec <- NULL
# aux <- NULL
#
# (seq1 <- seq(4, 16, 4))
#
# for (i in seq1) {
#
#   print(paste("Início do processo. Base", i, "empilhada"))
#
#   aux <- base |> dplyr::select(1:3, i,i+1, i+2, i+3) |>
#     dplyr::rename(
#       ano = nomesCol[all_of(i)],
#       ano10  = nomesCol[all_of(i)+1],
#       ano11  = nomesCol[all_of(i)+2],
#       ano12  = nomesCol[all_of(i)+3]
#     )
#   retsec <- rbind(retsec, aux)
# } |>
#   dplyr::mutate(across(
#     .data,
#     .cols = start("ano"),
#     .fns = as.numeric
#   ))
#
#   retsec <- retsec |>
#     tidyr::pivot_longer(
#       cols = ano10:ano12,
#       names_to = "anocurricular",
#       values_to = "retenção")
#
# rm(RetSecPorRegiao)
#
# # Empilhando tudo -----------------------------------------------------------------------------
#
# retencaoPt1619T <- dplyr::bind_rows(ret1ciclo, ret2ciclo, ret3ciclo,
#                                  retsec)
#
# retencaoPt1619T <- retencaoPt1619T |>
#   dplyr::mutate(
#     Município = nome_da_nuts_iii_municipio,
#     ano = stringr::str_remove(retencaoPt1619T$ano, "Ano_"),
#     ciclo = dplyr::case_when(
#       anocurricular %in% c("ano1", "ano2", "ano3", "ano4") ~ "cb1",
#       anocurricular %in% c("ano5", "ano6") ~ "cb2",
#       anocurricular %in% c("ano7", "ano8", "ano9") ~ "cb3",
#       anocurricular %in% c("ano10", "ano11", "ano12") ~ "sec",
#       anocurricular == "secp" ~ "secpr"))|>
#   dplyr::mutate(anocurricular = as.factor(anocurricular)) |>
#   dplyr::mutate(
#     chave = paste(codigo_da_regiao, ano, sep = "_")
#   ) |>
#   dplyr::relocate(chave, .before = "codigo_da_regiao")
#
#
#   rm(AlunosSecProfPorRegiao, aux, base, i, nomesCol, seq1,
#      ret1ciclo, ret2ciclo, ret3ciclo, retsec, baseSecProf)
#
#

# Exportando a base tratada -------------------------------------------------------------------

#  retencaoPt1619      <- dplyr::filter(retencaoPt1619T, tipo_de_regiao == "Município")
  # retencaoPt1719      <- dplyr::filter(retencaoPt1619T, ano == c("2017/2018",
  #                                                                "2018/2019",
  #                                                                "2019/2020"))
  #
  # retencaoPt1719 <- retencaoPt1719 |>
  #   dplyr::group_by(chave, ano, Município) |>
  #   dplyr::summarise(media_retençao = mean(retenção, na.rm =T))
  #

