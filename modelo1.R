library(shiny)
library(shinydashboard)
library(ggplot2)

# Datos simulados
sectores <- c("Agricultura, ganadería", "Explotación minera", "Industria manufacturera", 
              "Suministros de electricidad", "Construcción", "Comercio", 
              "Información y comunicación", "Actividades financieras", 
              "Actividades inmobiliarias", "Actividades profesionales", 
              "Administración pública", "Actividades artísticas")

# Generar valores simulados para las gráficas
set.seed(123)
produccion_impacto <- runif(12, 50, 500)
empleo_impacto <- runif(12, 1000, 10000)

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Sistema de Impacto Económico"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Ingreso al Sistema", tabName = "login", icon = icon("lock")),
      menuItem("Impacto Económico", tabName = "impacto", icon = icon("chart-line")),
      conditionalPanel(
        condition = "input.tabs == 'impacto'",
        numericInput("inversion", "Inversión ($ MM)", value = 0),
        selectInput("sector", "Sector de Inversión", choices = sectores),
        actionButton("calcular", "Calcular", class = "btn btn-primary")
      )
    )
  ),
  
  dashboardBody(
    tabItems(
      # Tablero 1: Ingreso al sistema
      tabItem(tabName = "login",
              fluidRow(
                tags$style(HTML("
                    body, .login-bg {
                      background: url('https://via.placeholder.com/1920x1080') no-repeat center center fixed;
                      background-size: cover;
                    }
                    .login-box {
                      background: rgba(255, 255, 255, 0.8);
                      padding: 20px;
                      border-radius: 10px;
                      margin-top: 100px;
                    }
                ")),
                div(class = "login-bg",
                    div(class = "login-box",
                        textInput("usuario", "Usuario"),
                        passwordInput("clave", "Clave"),
                        actionButton("login_btn", "Ingresar", class = "btn btn-primary")
                    )
                )
              )
      ),
      
      # Tablero 2: Impacto Económico
      tabItem(tabName = "impacto",
              fluidRow(
                box(title = "Impacto sobre la actividad económica", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      valueBoxOutput("nueva_produccion"),
                      valueBoxOutput("nuevos_empleos"),
                      valueBoxOutput("pib_cali"),
                      valueBoxOutput("empleo_cali")
                    )
                )
              ),
              fluidRow(
                box(
                  title = "Impacto en la producción ($)", status = "success", solidHeader = TRUE, width = 6,
                  plotOutput("produccion_plot")
                ),
                box(
                  title = "Empleo (#)", status = "success", solidHeader = TRUE, width = 6,
                  plotOutput("empleo_plot")
                )
              ),
              fluidRow(
                box(
                  title = "Informe de Resultados", status = "warning", solidHeader = TRUE, width = 12,
                  textAreaInput("informe", "Informe", value = "Escribe el informe aquí...", width = "100%", height = "200px")
                )
              )
      )
    )
  )
)

# Server
server <- function(input, output) {
  
  # Outputs de las cajas de impacto
  output$nueva_produccion <- renderValueBox({
    valueBox("322.90", "Nueva producción ($ MM)", icon = icon("industry"), color = "blue")
  })
  
  output$nuevos_empleos <- renderValueBox({
    valueBox("4750", "Nuevos empleos (#)", icon = icon("users"), color = "green")
  })
  
  output$pib_cali <- renderValueBox({
    valueBox("0.60%", "Territorio PIB Cali", icon = icon("chart-line"), color = "yellow")
  })
  
  output$empleo_cali <- renderValueBox({
    valueBox("0.43%", "Empleo Cali", icon = icon("briefcase"), color = "purple")
  })
  
  # Outputs de las gráficas
  output$produccion_plot <- renderPlot({
    ggplot(data.frame(Sector = sectores, Impacto = produccion_impacto), aes(x = reorder(Sector, Impacto), y = Impacto)) +
      geom_bar(stat = "identity", fill = "blue") +
      coord_flip() +
      theme_minimal() +
      labs(title = "Impacto en la producción ($)", x = "Sector", y = "Impacto ($ MM)")
  })
  
  output$empleo_plot <- renderPlot({
    ggplot(data.frame(Sector = sectores, Impacto = empleo_impacto), aes(x = reorder(Sector, Impacto), y = Impacto)) +
      geom_bar(stat = "identity", fill = "green") +
      coord_flip() +
      theme_minimal() +
      labs(title = "Empleo (#)", x = "Sector", y = "Impacto (#)")
  })
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
