#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    bs4Dash::bs4DashPage(
      bs4Dash::bs4DashNavbar(title = "POAT-PIICIE"),
      bs4Dash::bs4DashSidebar(
        bs4Dash::bs4SidebarMenu(

          bs4Dash::bs4SidebarMenuItem(
          "AMP",
          tabName = "amp",
          icon = icon("table")
          ),
          bs4Dash::bs4SidebarMenuItem(
            "Santa Maria da Feira",
            tabName = "smf",
            icon = icon("map")
          )
      )
    ),
    bs4Dash::bs4DashBody(
      bs4Dash::bs4TabItems(
        bs4Dash::bs4TabItem(
        tabName = "amp",
        mod_amp_ui("amp_1")
          ),
        bs4Dash::bs4TabItem(
          tabName = "sfm",
          mod_smf_ui("smf_1")
        )
      )

    )
  )
)

}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "piicie"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
