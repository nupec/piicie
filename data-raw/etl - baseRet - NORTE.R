library(tidyverse)

## Imporatando e empilhando a base Retenção ------------------------------------------------------------------------

# Caminho até a base Retenção

caminho <- list.files("data-raw/Retenção/",
                      pattern = "PIICIE_TxRetencaoDesistencia",
                      full.names = T)

# Função que ler os dados

ler_base <-function(file, pastas){
  readxl::read_xlsx(caminho, sheet = pastas)
}


# Empilhando os dados do 2º e 3º Ciclos Escolares -----------------------------------------------------------------------
pastas1 <- 1:5
ret_1415_1819 <- purrr::map2_dfr(caminho, pastas1, ler_base)

# Colocando no formato Tidy  -----------------------------------------------

base <- ret_1415_1819

nomesRet <- names(base)
baseEmpRet <- NULL
aux <- NULL
seq1 <- seq(12, 34, 2)

for (i in seq1) {
  aux <- base |> dplyr::select(1:11, all_of(i),all_of(i)+1) |>
    dplyr::rename(
      qtdeAlunos = nomesRet[all_of(i)],
      retAlunos  = nomesRet[all_of(i)+1]) |>
    tidyr::drop_na(qtdeAlunos) |>
    dplyr::mutate(
      anocurricular = nomesRet[all_of(i)]
    )

  aux <- aux |> dplyr::mutate(
    CICLO = dplyr::case_when(
      anocurricular %in% c("Alunos_Ano1", "Alunos_Ano2", "Alunos_Ano3", "Alunos_Ano4") ~ "1CEB",
      anocurricular %in% c("Alunos_Ano5", "Alunos_Ano6") ~ "2CEB",
      anocurricular %in% c("Alunos_Ano7", "Alunos_Ano8", "Alunos_Ano9") ~ "3CEB",
      anocurricular %in% c("Alunos_Ano10", "Alunos_Ano11", "Alunos_Ano12") ~ "SEC"
    ))

  baseEmpRet<- rbind(baseEmpRet, aux)

}

# for (i in seq1) {
#
#   print(paste("Início do processo. Base", i, "empilhada"))
#
#   aux <- base |> dplyr::select(1:11, all_of(i),all_of(i) + 1) |>
#     dplyr::rename(
#       qtdeAlunos = nomesRet[all_of(i)],
#       retAlunos  = nomesRet[all_of(i)+1]
#     )


# aux <- aux |>
#   dplyr::mutate(
#     anocurricular = nomesRet[i]
#   )

# }

# baseEmpRet <- baseEmpRet |> tidyr::drop_na()


# baseEmpRet <- baseEmpRet |> dplyr::mutate(
#   ciclo = dplyr::case_when(
#     anocurricular %in% c("Alunos_Ano1", "Alunos_Ano2", "Alunos_Ano3", "Alunos_Ano4") ~ "1CEB",
#     anocurricular %in% c("Alunos_Ano5", "Alunos_Ano6") ~ "2CEB",
#     anocurricular %in% c("alunos_Ano7", "alunos_Ano8", "alunos_Ano9") ~ "3CEB",
#     anocurricular %in% c("Alunos_Ano10", "Alunos_Ano11", "Alunos_Ano12") ~ "SEC"
#   ))

baseEmpRet$id <- c(1:nrow(baseEmpRet))

baseEmpRet$ANO <- baseEmpRet$ANOLETIVO |>
  str_replace_all(c("2014/15" = "2014",
                    "2015/16" = "2015",
                    "2016/17" = "2016",
                    "2017/18" = "2017",
                    "2018/19" = "2018"))

baseEmpRet <- baseEmpRet |> select(
  "id", "CICLO", "ANO", "anocurricular",
  "CNUTSII_2013", "NUTSIII_2013", "Código de Município",
  "Município", "C_UO", "UO", "CESCOLA",  "ESCOLA",
  "qtdeAlunos", "retAlunos")

# nomes <- readxl::read_xlsx("dataset/baseRETGeral.xlsx",
#                           sheet = 2)

colnames(baseEmpRet) <- c("id", "CICLO", "ANO", "ANO_CURRICULAR", "CNUTSIII_2013",
                          "AREA_METROPOLITANA", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO",
                          "C_UO", "UO", "CESCOLA", "ESCOLA", "ALUNOS", "RETENCAO")


 # readr::write_rds(baseEmpRet, "data/rds/baseRETGera.rds")
 # writexl::write_xlsx(baseEmpRet, "data/xlsx/baseRETGeral.xlsx")
