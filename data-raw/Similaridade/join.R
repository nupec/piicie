

baseModeloMR <- dplyr::left_join(matriculaPT, retencaoPT,
                                 by = "chave")

baseModeloME <- dplyr::left_join(matriculaPT, equidadePT,
                                 by = "chave")


baseModelo <- dplyr::left_join(baseModeloME, baseModeloMR,
                                 by = "chave")

baseModelo <- dplyr::select(baseModelo, ano.x.x, Município, total_matricula.x,
              media_retençao, tt_ASE, equidade_media) |>
  dplyr::rename(ano =  ano.x.x,
                total_alunos = total_matricula.x
                )

#  readr::write_rds(baseModelo, "data/rds/baseModelo.rds")
# #
#  writexl::write_xlsx(baseModelo, "data/similaridade/baseModelo.xlsx")
