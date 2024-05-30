library(shiny)
library(shinydashboard)

# Define the server logic
server <- function(input, output, session) {
  
  # Placeholder user credentials
  credentials <- reactiveValues(authenticated = FALSE)
  
  observeEvent(input$login, {
    if (input$user == "admin" && input$password == "admin") {
      credentials$authenticated <- TRUE
      updateTabItems(session, "tabs", selected = "inversion")
    } else {
      showModal(modalDialog(
        title = "Error de Autenticación",
        "Usuario o contraseña incorrectos. Por favor, intente de nuevo.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  observeEvent(input$submit, {
    # Logic to process the investment value and sector selection
    investment <- input$investment
    sector <- input$sector
    
    # Placeholder logic for indicators and results
    output$indicator1 <- renderValueBox({
      valueBox(value = investment * 0.1, subtitle = "Indicador 1", color = "yellow")
    })
    
    output$indicator2 <- renderValueBox({
      valueBox(value = investment * 0.2, subtitle = "Indicador 2", color = "green")
    })
    
    output$indicator3 <- renderValueBox({
      valueBox(value = investment * 0.3, subtitle = "Indicador 3", color = "blue")
    })
    
    output$barPlot <- renderPlot({
      barplot(c(investment * 0.1, investment * 0.2, investment * 0.3),
              horiz = TRUE, names.arg = c("Indicador 1", "Indicador 2", "Indicador 3"),
              col = c("yellow", "green", "blue"))
    })
    
    output$report <- renderText({
      paste("La inversión de", investment, "en el sector", sector, "ha producido los siguientes resultados:")
    })
  })
}

