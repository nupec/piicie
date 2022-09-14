library(highcharter)
library(devtools)
library(fdth)

### Carregando as bases

baseNN <- readr::read_rds("../data/rds/baseNN.rds") |>
  dplyr::mutate(rnn = round(nn/matricula, 4)) |>
  tidyr::drop_na(ciclo)

baseRet <- readr::read_rds("data/rds/baseRet.rds") |>
  dplyr::mutate(rret = round(RETENCAO/ALUNOS, 4))

## Níveis Negativos

# Calculando os níveis negativos médios por cidade

tabelaCidadesNN <- baseNN |>
  dplyr::group_by(ANOESCOLAR, Município) |>
  dplyr::summarise(media_rnn = mean(rnn, na.rm = TRUE),
                   tt_aluno  = sum(matricula),
                   tt_nn     = sum(nn) )

tabelaCidadesREt <- dplyr::filter(baseRet, AREA_METROPOLITANA == "Área Metropolitana do Porto") |>
  dplyr::group_by(ANO, NOME_MUNICIPIO) |>
  dplyr::summarise(media_rret = mean(rret, na.rm = TRUE),
                   tt_aluno = sum(ALUNOS),
                   tt_ret = sum(RETENCAO) )

# Calculando os níveis negativos médios por cidade e ciclo escolar

tabelaCidCicloNN <- baseNN |>
  dplyr::group_by(ANOESCOLAR, Município, ciclo) |>
  dplyr::summarise(media_rnn = mean(rnn, na.rm = TRUE))




hchart(tabelaCidadesNN, "line", hcaes(x = ANOESCOLAR, y = media_rnn, group = Município))


## Retenção

