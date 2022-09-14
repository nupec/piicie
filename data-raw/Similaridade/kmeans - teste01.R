library(fpc)
library(stats)
library(scatterplot3d)
library(purrr)
library(skimr)
library(cluster)

# Sempre o mesmo set.seed(1)



# PaSSO 1: Carrega a base de dados

# Importação e preparação dos dados - Índices Negativos -----------------------------------------------------------

baseNNGeral <- readxl::read_excel("../data/xlsx/baseNNGeral.xlsx") |>
  dplyr::mutate(
    inn = NIVEIS_NEGATIVOS/NRO_ALUNO
  ) |>
  janitor::clean_names()

# Passo 2: Cria uma função que filtra a base inicial pelo ano de interesse
# e gera dois vetores


filtrAno <- function(t1) {
  filtro <- dplyr::filter(baseNNGeral, ano=={{t1}}) |>
    dplyr::select(ano, municipio, ciclo, nro_aluno,
                  niveis_negativos, inn) |>
    dplyr::group_by(ano, municipio) |>
    dplyr::summarise(
      tt_alunos = sum(nro_aluno, na.rm=T),
      tt_nn = sum(niveis_negativos, na.rm = T),
      media_inn = mean(inn, na.rm=T)
    )

  return(filtro)
}

# A função a seguir, tratar a base de dados, filtra o ano de interesse
# e forma cluters

clusterAno <- function(t, k){
  set.seed(1)
  baseFiltrada <- filtrAno({{t}})
  base <- baseFiltrada[ , 3:5] |>  scale() #padroniza as variáveis
  baseInicial <- kmeans(base, {{k}}) # calcula os clusters

  return(baseInicial)
}

# Automatizar o processo

k <- 2:4 # Número de clusters
periodo <- 2017:2019 # Total de
baseCluster <- NULL

for (t in periodo) {
  for (k1 in k) {
    aux <- NULL
    aux <-  clusterAno({{t}}, {{k1}})
    baseCluster <- cbind(baseCluster, aux)
    baseCluster <- cbind(baseCluster, {{k1}}, {{t}})
  }
}

kGeral <- NULL
aux <- NULL
baseCluster <- NULL
i=1

cidades <- unique(baseNNGeral$municipio) |> rep(9)

for (i in seq(1, 24, 3)) {
  aux = cbind(baseCluster[[1, i  ]],
              baseCluster[[1, i+1]],
              baseCluster[[1, i+2]])

  kGeral = rbind(kGeral, aux)
}

kGeral <- cbind(cidades, kGeral)

kGeral

teste <- clusterAno(2019,3)
# Gráfico 3d
scatterplot3d(baseNNGeral$ano,  xlab = "Ano letivo",
              baseNNGeral$niveis_negativos, ylab = "Níveis Negativos",
              baseNNGeral$nro_aluno, zlab = "Total de alunor por município",
              color = baseNNGeral$ano)

# Formando Clusteres --------------------------------------------------------------------------

base2014 <- filtrAno(2014)

base2014 <- scale(base2014)

k2014 <- clusterAno(2014, 3)

centroides <- k2014$centers

previsoes <- k2014$cluster

clusplot(base2014,  previsoes, xlab = 'Total de Alunos',
         ylab = 'Total de níveis negativos',
         main = 'Total de Alunos X Níveis negativos por Município',
         lines = 0, shade = TRUE, color = TRUE, labels = 2)


# Alternativa 1: Por ano ----------------------------------------------------------------------



#  writexl::write_xlsx(kfinal, "dataset/cluster-kmeans.xlsx")


# Avaliação de modelos ------------------------------------------------------------------------


# Visualização dos dados ----------------------------------------------------------------------

plot <- scatterplot3d(baseAnalise$tt_alunos, baseAnalise$tt_nn, baseAnalise$media_inn,
                      main = "AMP - Dados dos municípios com Níveis Negativos",
                      xlab = "Total de alunos por município",
                      ylab = "Total de NN por município",
                      zlab = "TNN",
                      color = kc4$k4,
                      pch =  kc4$k4)

#plot$points3d(k2014$centers, pch = 8, col = 1, cex = 9)

# alta compacidade e alta separabilidade

# x2 <- cbind(kfinal$tt_nn, kfinal$tt_alunos)
#
# plot(x2,type= "n", xlab= "nn",ylab="ttAlunos", cex.lab=1.5, cex.axis=2.5)
#
# points(x2[1:150,1],x2[1:150,2],col="4",lwd=3.5,cex=3.5,pch=22)
#
# points(x2[151:300,1],x2[151:300,2],col="2",lwd=3.5,cex=3.5,pch=21)
#
# label = as.integer(c(rep(1,150),rep(2,150)))
#

#
# x1 <- rbind(matrix(rnorm(300,mean=2,sd=0.2),ncol=2),
#               matrix(rnorm(300,mean=0.5,sd=0.2),ncol=2))
#
#  plot(x1,type= "n", xlab= "nn",ylab="ttAlunos", cex.lab=1.0, cex.axis=2.5)
#
#  points(x1[1:150,1],x1[1:150,2],col="4",lwd=3.5,cex=3.5,pch=22)
#
#  points(x1[151:300,1],x1[151:300,2],col="2",lwd=3.5,cex=3.5,pch=21)
#
#  label = as.integer(c(rep(1,150),rep(2,150)))
