library(dplyr)

### Carregando as bases

### Carregando as bases
# Fonte: PORTAL INFOESCOLAS - 1 .º CICLO - ENSINO GERAL - DADOS POR NUTS III / MUNICÍPIO
#        Fonte: DGEEC/MEdu (Dados reportados pelas escolas ao sistema de informação do MEdu)
# Disponível em:

# url("https://infoescolas.pt/bds.asp")

# 1 Ciclo -----------------------------------------------------------------------------------

cofinanciamento <- readxl::read_excel("data-raw/Cofinanciamento/Fundos_PIICIE_Educação.xls",
                                              sheet = "gisMUNICIPIOS") |>
  janitor::clean_names() |>
  dplyr::select(-c(9,10))

base <- cofinanciamento |>
  dplyr::rename(
    `2016/2017`= fa_2016,
    `2017/2018`= fa_2017,
    `2018/2019`= fa_2018,
    `2019/2020`= fa_2019,
    `2020/2021`= fa_2020,
    Total = total_fa
  )

# Empilhando as bases

basetidy <- base |>
  tidyr::pivot_longer(
    cols = Total:`2020/2021`,
    names_to = "ano",
    values_to = "cofinanciamento"
  ) |>
  dplyr::mutate(
    chave = paste(dico, ano, sep = "_")
  ) |>
  dplyr::relocate(chave, .before = "dico") |>
  tidyr::replace_na() |>
  dplyr::filter(ano == "Total") |>
  dplyr::select("dico", "municipios_ju", "cofinanciamento")

munCof <- basetidy[1] |> dplyr::pull()


# Censo Portugal 2021 -------------------------------------------------------------------------

censo21 <- readxl::read_excel("data-raw/Cofinanciamento/Censos_2021.xls",
                              sheet = "censoMun") |>
  janitor::clean_names() |>
  dplyr::mutate(cod = as.numeric(cod))

subPop21Cof <- censo21 |>
  dplyr::mutate(cod = as.numeric(cod)) |>
  dplyr::filter(cod %in% munCof)

base <- dplyr::left_join(basetidy, subPop21Cof, by = c("dico"="cod")) |>
  dplyr::mutate(
    racio_cof_0a14 = x0_14_anos/cofinanciamento,
    racio_cof_15a24 = x15_24_anos/cofinanciamento,
    racio_cof_25a64 = x25_64_anos/cofinanciamento,
    racio_cof_65M = x65_e_mais_anos/cofinanciamento

  )

popMatCof <- matriculaPT |>
  dplyr::filter(dico %in% munCof) |>
  tidyr::pivot_wider(
    names_from = c(ciclo2),
    values_from = tt_alunos) |>
  dplyr::group_by(dico, ano, Município) |>
  dplyr::summarise(
    ciclo_basico = sum(cb, na.rm=T),
    secundario   = sum(sec, na.rm = T)
  ) |>
  dplyr::mutate(
    total = ciclo_basico+secundario
  )

# readr::write_rds(basetidy, "data/rds/baseCofinanciamento.rds")
# writexl::write_xlsx (basetidy, "data/xlsx/baseCofinanciamento.xlsx")
#
