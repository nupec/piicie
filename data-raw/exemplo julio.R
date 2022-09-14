library(tidyverse)

tabela <- tibble::tibble(
  id = 1:6,
  coluna_nao_mudar = c("a","b","c","d","e", "f"),
  ano_1 = c(2000, 2000, 2000, 2010, 2010, 2010),
  ano_2 = c(2011, 2011, 2011, 2011, 2011, 2011),
  indice_1 = rnorm(6),
  indice_2 = runif(6)
)

tabela1 <- tabela |>
  tidyr::pivot_longer(
    c(starts_with("ano_"), starts_with("indice_")),
    names_to = c("ano", "valor_variavel"),
    names_sep = "_"
  )

|>
  tidyr::pivot_wider(
    names_from = c(ano),
    values_from = c(value)
  )
