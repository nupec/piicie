#' smf UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_smf_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("Santa Maria da Feira")

  )
}

#' smf Server Functions
#'
#' @noRd
mod_smf_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_smf_ui("smf_1")

## To be copied in the server
# mod_smf_server("smf_1")
