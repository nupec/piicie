library(tidyverse)

# As bases de dados


# Passo 1: Empilhando as bases de Níveis Negativos: ----------------------------------------------------------------------------------

# 1) DGEEC_Santa Maria da Feira_201920
# 2) PIICE_AMP2e3CEB - 2º e 3º Ciclo
# 17 cidades:
# Arouca
# Espinho
# Gondomar
# Maia
# Matosinhos
# Oliveira de Azeméis
# Paredes
# Porto
# Póvoa de Varzim
# Santa Maria da Feira
# Santo Tirso
# São João da Madeira
# Trofa
# Vale de Cambra
# Valongo
# Vila do Conde

# 3) PIICIE_Taxas_Alunos_níveis_negativos_1415a1819_DGEEC(AMP)2_



caminho <- list.files("data-raw/Níveis Negativos/",
                      pattern = "Tratados",
                      full.names = T)

ler_base <-function(file, pastas){
  readxl::read_xlsx(caminho, sheet = pastas)
}


# # 2º Ciclo e 3º Ciclo -----------------------------------------------------------------------
pastas1 <- 1:5
baseNN2c <- purrr::map2_dfr(caminho, pastas1, ler_base)

pastas2 <- 6:10
baseNN3c <- purrr::map2_dfr(caminho, pastas2, ler_base)


# # Empilhando a base NN2c --------------------------------------------------------------------
base <- baseNN2c
nomesNN <- names(base)
baseEmpilhada1 <- NULL
aux <- NULL
seq1 <- c(12, 14)

i = 12

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:11, all_of(i), all_of(i) +1) |>
    dplyr::rename(
      matricula = nomesNN[all_of(i)],
      nn  = nomesNN[all_of(i)+1]
    )

  aux <- aux |>
    dplyr::mutate(
      anocurricular = nomesNN[all_of(i)]
    )

  baseEmpilhada1 <- rbind(baseEmpilhada1, aux)

}

baseEmpilhada1 <- baseEmpilhada1 |>
  dplyr::mutate(
    nn = as.numeric(nn)
  )


# # Empilhando a base 3NNC --------------------------------------------------------------------
i = 12

base <- NULL
base <- baseNN3c
nomesNN <- names(base)
baseEmpilhada2 <- NULL
aux <- NULL

seq1 <- c(12, 14, 16)


for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:11, all_of(i),all_of(i)+1) |>
    dplyr::rename(
      matricula = nomesNN[all_of(i)],
      nn  = nomesNN[all_of(i)+1]
    )

  aux <- aux |>
    dplyr::mutate(
      anocurricular = nomesNN[all_of(i)]
    )

  baseEmpilhada2 <- rbind(baseEmpilhada2, aux)

}

baseNN <- dplyr::bind_rows(baseEmpilhada1, baseEmpilhada2) |> tidyr::drop_na() |>
  dplyr::mutate(
    ciclo = dplyr::case_when(
      anocurricular %in% c("Alunos_Ano1", "Alunos_Ano2", "Alunos_Ano3", "Alunos_Ano4") ~ "cb1",
      anocurricular %in% c("Alunos_Ano5", "Alunos_Ano6") ~ "cb2",
      anocurricular %in% c("Alunos_Ano7", "Alunos_Ano8", "Alunos_Ano9") ~ "cb3",
      anocurricular %in% c("Alunos_Ano10", "Alunos_Ano11", "Alunos_Ano12") ~ "sec"
    ))


  # readr::write_rds(baseNN, "data/rds/baseNN.rds")
  #
  # writexl::write_xlsx(baseNN, "data/xlsx/baseNN.xlsx")
