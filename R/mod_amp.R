#' amp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_amp_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("Área Metropolitana do Porto"),
    br(),
    fluidRow(
      bs4Dash::bs4Card(
        title = "Filtros",
        width = 12,
        fluidRow(
          column(
            width = 4,
            selectInput(
              ns("ano"),
              label = "Selecione um ano",
              choices = unique(baseNN$ano),
              width = "90%",
              )
          ),
          column(
            width = 4,
            selectInput(
              ns("metrica"),
              label = "Selecione uma métrica",
              choices = c(
                "Município" = "Município",
                "Escola" = "ESCOLA",
                "Ano curricular" = "anocurricular",
                "Número de alunos" = "matricula",
                "Níveis negativos" = "nn"
                ),
              width = "90%",
              )
            )
          )
        )
      ),
    br(),
    fluidRow(
      column(
        width = 8,
        reactable::reactableOutput(ns("tabela"))
      ),
      column(
        width = 2,
        leaflet::leafletOutput(ns("mapa"))
      ),
    )
  )
}

#' amp Server Functions
#'
#' @noRd
mod_amp_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$tabela <- reactable::renderReactable({
      baseNN |>
        dplyr::filter(
          ano == input$ano,
          ) |>
        dplyr::arrange(.data[[input$metrica]]) |>
        dplyr::slice(1:10) |>
        dplyr::select(ano, one_of(input$metrica), Município, ESCOLA, anocurricular, matricula, nn ) |>
        dplyr::mutate(tnn = round(nn/matricula,3)) |>
        reactable::reactable(
          selection = "multiple"
        )
      })

    output$mapa <- leaflet::leaflet({

    })


  })
}

## To be copied in the UI
#

## To be copied in the server
#
