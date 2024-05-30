# Archivo principal para ejecutar la aplicación

# Cargar las librerías
source("librerias.R")
# Cargar los datos
source("datos.R")


# Cargar las librerías
# source("/home/deg/Documentos/PERSONAL/IXA COLOMBIA/CALCULADORA/repository/cuenta/cuenta2/librerias.R")
# Cargar los datos
#source("/home/deg/Documentos/PERSONAL/IXA COLOMBIA/CALCULADORA/repository/cuenta/cuenta2/base.R")
#-------------------------------------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(
    title = "Flights Dashboard",
    titleWidth = 200
  ),
  dashboardSidebar(
    selectInput(
      inputId = "airline",
      label = "Airline:",
      choices = base,
      selected = "DL",
      selectize = FALSE
    ),
    sidebarMenu(
      selectInput(
        inputId = "month",
        label = "Month:",
        choices = month_list,
        selected = 99,
        size = 13,
        selectize = FALSE
      ),
      actionLink("remove", "Remove detail tabs")
    )
  ),
  dashboardBody(
    tabsetPanel(
      id = "tabs",
      tabPanel(
        title = "Main Dashboard",
        value = "page1",
        fluidRow(
          valueBoxOutput("total_flights"),
          valueBoxOutput("per_day"),
          valueBoxOutput("percent_delayed")
        ),
        fluidRow(),
        fluidRow(
          column(
            width = 6,
            d3Output("group_totals")
          ),
          column(
            width = 6,
            d3Output("top_airports")
          )
        )
      )
    )
  )
)
