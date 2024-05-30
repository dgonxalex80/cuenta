library(shiny)
library(shinydashboard)

# Define the UI
ui <- dashboardPage(
  dashboardHeader(title = "Aplicación de Inversiones"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inicio", tabName = "inicio", icon = icon("home")),
      menuItem("Inversión", tabName = "inversion", icon = icon("dollar-sign")),
      menuItem("Resultados", tabName = "resultados", icon = icon("chart-bar"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content: Login Page
      tabItem(tabName = "inicio",
              fluidRow(
                box(title = "Inicio de Sesión", width = 4, status = "primary", solidHeader = TRUE,
                    textInput("user", "Usuario"),
                    passwordInput("password", "Contraseña"),
                    actionButton("login", "Iniciar Sesión")
                )
              )
      ),
      
      # Second tab content: Input investment and sector
      tabItem(tabName = "inversion",
              fluidRow(
                box(title = "Inversión", width = 4, status = "primary", solidHeader = TRUE,
                    numericInput("investment", "Valor de la Inversión:", value = 1000, min = 0),
                    selectInput("sector", "Seleccione el Sector:", 
                                choices = list("Sector 1", "Sector 2", "Sector 3", "Sector 4", "Sector 5", 
                                               "Sector 6", "Sector 7", "Sector 8", "Sector 9", "Sector 10",
                                               "Sector 11", "Sector 12")),
                    actionButton("submit", "Enviar")
                )
              )
      ),
      
      # Third tab content: Results
      tabItem(tabName = "resultados",
              fluidRow(
                valueBoxOutput("indicator1"),
                valueBoxOutput("indicator2"),
                valueBoxOutput("indicator3")
              ),
              fluidRow(
                box(title = "Gráfico de Barras Horizontal", width = 12, status = "primary", solidHeader = TRUE,
                    plotOutput("barPlot")
                )
              ),
              fluidRow(
                box(title = "Informe de Resultados", width = 12, status = "primary", solidHeader = TRUE,
                    textOutput("report")
                )
              )
      )
    )
  )
)

