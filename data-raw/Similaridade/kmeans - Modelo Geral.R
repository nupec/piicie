library(fpc)
library(stats)
library(scatterplot3d)
library(purrr)
library(skimr)
library(cluster)

# Esta função cria k clusters para uma dataframe

baseNNGeral <- readxl::read_excel("data/xlsx/baseNNGeral.xlsx") |>
  dplyr::mutate(
    inn = NIVEIS_NEGATIVOS/NRO_ALUNO
  ) |>
  janitor::clean_names()

v1 <- "ano"
v2 <- "nro_aluno"
v3 <- "niveis_negativos"
v4 <- NULL
v5 <- NULL


df <- baseNNGeral |>
  dplyr::select(v1, v2, v3) |>
  tidyr::drop_na()

# Definindo as variáveis que serão consideradas no processo de clusteriazação

clusterGeral <- function(t, k){
  set.seed(1)
  df <- dplyr::filter(df, ano == {{t}})   #padroniza as variáveis
  df <- scale(df[2:3])
  base <- stats::kmeans(df, {{k}})
}

clusterGeral(2017,2)

periodo <- 2017:2019
k <- 2:4
aux <- NULL
baseCluster <- NULL


for (t in periodo) {
  for (k1 in k) {
    aux <- NULL
    aux <-  clusterGeral({{t}}, {{k1}})
    baseCluster <- cbind(baseCluster, aux)
    baseCluster <- cbind(baseCluster, {{k1}}, {{t}}) # calcula os clusters
  }
}

# Construindo a base final

kGeral <- NULL
aux <- NULL

i=1

cidades <- unique(baseNNGeral$municipio) |> rep(9)

for (i in seq(1, 27, 3)) {
  aux = cbind(baseCluster[[1, i  ]],
              baseCluster[[1, i+1]],
              baseCluster[[1, i+2]])


  kGeral = rbind(kGeral, aux)
}

kGeral <- cbind(cidades, kGeral)

writexl::write_xlsx(kGeral, "data/similaridade/km_mat_nn.xlsx")

# scatterplot3d::scatterplot3d(df$nro_aluno, df$niveis_negativos,
#                              df$inn)
