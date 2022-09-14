library(dplyr)

### Carregando as bases
# Fonte: PORTAL INFOESCOLAS - 1 .º CICLO - ENSINO GERAL - DADOS POR NUTS III / MUNICÍPIO
#        Fonte: DGEEC/MEdu (Dados reportados pelas escolas ao sistema de informação do MEdu)
# Disponível em:

# url("https://infoescolas.pt/bds.asp")

# 1 Ciclo -----------------------------------------------------------------------------------

Equidade1CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_1Ciclo_DadosPorRegiao.xlsx",
                                            sheet = "Equidade") |>
  janitor::clean_names()

# Empilhando as bases

base <- Equidade1CicloPorRegiao

nomesCol <- names(base)

equi1ciclo <- NULL
aux <- NULL

(seq1 <- seq(4, 12, 3))

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:3, all_of(i),all_of(i)+1, all_of(i)+2) |>
    dplyr::rename(
      ano = nomesCol[all_of(i)],
      aluASE  = nomesCol[all_of(i)+1],
      equidade  = nomesCol[all_of(i)+2]
    )
  equi1ciclo <- rbind(equi1ciclo, aux)
}

equi1ciclo <- equi1ciclo |>
  dplyr::mutate(
    ciclo1 = "cb1",
    ciclo2 = "cb"
  )

rm(Equidade1CicloPorRegiao)


# 2 Ciclo -----------------------------------------------------------------------------------

Equidade2CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_2Ciclo_DadosPorRegiao.xlsx",
                                              sheet = "Equidade") |>
  janitor::clean_names()

# Empilhando as bases

base <- Equidade2CicloPorRegiao

nomesCol <- names(base)

equi2ciclo <- NULL
aux <- NULL

(seq1 <- seq(4, 12, 3))

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:3, all_of(i),all_of(i)+1, all_of(i)+2) |>
    dplyr::rename(
      ano = nomesCol[all_of(i)],
      aluASE  = nomesCol[all_of(i)+1],
      equidade  = nomesCol[all_of(i)+2]
    )
  equi2ciclo <- rbind(equi2ciclo, aux)
}

equi2ciclo <- equi2ciclo |>
  dplyr::mutate(
    ciclo1 = "cb2",
    ciclo2 = "cb"
  )

rm(Equidade2CicloPorRegiao)

# 3 Ciclo -----------------------------------------------------------------------------------

Equidade3CicloPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_3Ciclo_DadosPorRegiao.xlsx",
                                              sheet = "Equidade") |>
  janitor::clean_names()

# Empilhando as bases

base <- Equidade3CicloPorRegiao

nomesCol <- names(base)

equi3ciclo <- NULL
aux <- NULL

(seq1 <- seq(4, 12, 3))

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:3, all_of(i),all_of(i)+1, all_of(i)+2) |>
    dplyr::rename(
      ano = nomesCol[all_of(i)],
      aluASE  = nomesCol[all_of(i)+1],
      equidade  = nomesCol[all_of(i)+2]
    )
  equi3ciclo <- rbind(equi3ciclo, aux)
}

equi3ciclo <- equi3ciclo |>
  dplyr::mutate(
    ciclo1 = "cb3",
    ciclo2 = "cb"
  )

rm(Equidade3CicloPorRegiao)

names(equi3ciclo) <- names(equi1ciclo)

# Secundário -----------------------------------------------------------------------------------

EquidadeSecPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_Secundario_CH_DadosPorRegiao.xlsx",
                                              sheet = "Equidade") |>
  janitor::clean_names()

# Empilhando as bases

base <- EquidadeSecPorRegiao

nomesCol <- names(base)

equiSec <- NULL
aux <- NULL

(seq1 <- seq(4, 12, 3))

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:3, all_of(i),all_of(i)+1, all_of(i)+2) |>
    dplyr::rename(
      ano = nomesCol[all_of(i)],
      aluASE  = nomesCol[all_of(i)+1],
      equidade  = nomesCol[all_of(i)+2]
    )
  equiSec <- rbind(equiSec, aux)
}

equiSec <- equiSec |>
  dplyr::mutate(
    dico = as.numeric(dico),
    ciclo1 = "sec",
    ciclo2 = "sec"
  )

rm(EquidadeSecPorRegiao)

# Secundário Profissional-----------------------------------------------------------------------------------

EquidadeSecProfPorRegiao <- readxl::read_excel("data-raw/Dados Infoescolas em maio de 2022/2021_Secundario_Profissional_DadosPorRegiao.xlsx",
                                           sheet = "Equidade") |>
  janitor::clean_names()

# Empilhando as bases

base <- EquidadeSecProfPorRegiao

nomesCol <- names(base)

equiSecProf <- NULL
aux <- NULL

(seq1 <- seq(4, 12, 3))

for (i in seq1) {

  print(paste("Início do processo. Base", i, "empilhada"))

  aux <- base |> dplyr::select(1:3, all_of(i),all_of(i)+1, all_of(i)+2) |>
    dplyr::rename(
      ano = nomesCol[all_of(i)],
      aluASE  = nomesCol[all_of(i)+1],
      equidade  = nomesCol[all_of(i)+2]
    )
  equiSecProf <- rbind(equiSecProf, aux)
}

equiSecProf <- equiSecProf |>
  dplyr::mutate(
    ciclo1 = "secpr",
    ciclo2 = "sec"
  )

rm(EquidadeSecProfPorRegiao, base, aux)

# Empilhando tudo -----------------------------------------------------------------------------

equidadePt1719T <- dplyr::bind_rows(equi1ciclo, equi2ciclo, equi3ciclo,
                                    equiSec, equiSecProf) |>
  dplyr::mutate(
  chave = paste(dico, ano, ciclo2, sep = "_")) |>
  dplyr::relocate(chave, .before = "dico") |>
  dplyr::group_by(ciclo2, chave, ano, regiao) |>
  dplyr::summarise(
    tt_ASE = sum(aluASE, na.rm = T),
    equidade_media = mean(equidade, na.rm =T))

 #Exportando a base tratada -------------------------------------------------------------------

rm(equi1ciclo, equi2ciclo, equi3ciclo, equiSec, equiSecProf)

  # readr::write_rds(equidadePt1719T, "data/rds/baseEquidade.rds")
  #
  # writexl::write_xlsx(equidadePt1719T, "data/xlsx/baseEquidade.xlsx")

