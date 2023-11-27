# server.R

library(shiny)
library(shinyjs)

# Defining server logic
server <- function(input, output, session) {
  
  # Language switch reactive value
  lang <- reactiveVal("en")
  
  # Initialize the language attribute on app startup
  observe({
    shinyjs::runjs(sprintf('document.documentElement.lang = "%s";', lang()))
  })
  
  # Switch language button
  observeEvent(input$lang_switch, {
    if (lang() == "en") {
      lang("pl")
    } else {
      lang("en")
    }
  })
  
  # Circumference plot
  output$circumference_plot <- renderPlot({
    ggplot() +
      geom_bar(aes(x = "", y = input$circumference), stat = "identity", fill = "blue") +
      labs(
        title = if (lang() == "en") "Tree Circumference Distribution" else "Rozkład obwodu drzewa",
        y = if (lang() == "en") "Circumference (cm)" else "Obwód (cm)"
      ) +
      theme_minimal()
  })
  
  # Permit status text
  output$permit_status <- renderText({
    permit_required <- FALSE
    
    if (input$fallen_by_nature == "No") {
      if (input$circumference > 80 && input$species %in% c("maple", "silver maple", "willow", "lake", "Populus")) {
        permit_required <- TRUE
      } else if (input$circumference > 65 && input$species %in% c("chestnut", "acacia", "black locust", "cycamore")) {
        permit_required <- TRUE
      } else if (input$circumference > 50 && !(input$species %in% c("maple", "silver maple", "willow", "lake", "Populus", "chestnut", "acacia", "black locust", "cycamore"))) {
        permit_required <- TRUE
      }
    }
    
    if (permit_required) {
      return(if (lang() == "en") "Permit Required" else "Wymagane pozwolenie")
    } else {
      return(if (lang() == "en") "No Permit Required" else "Nie wymaga pozwolenia")
    }
  })
  
  # Classification text
  output$classification <- renderText({
    if (input$circumference < 50) {
      return(if (lang() == "en") "Low Level-Value Tree" else "Drzewo niskiej wartości")
    } else if (input$circumference < 80) {
      return(if (lang() == "en") "Moderate Level-Value Tree" else "Drzewo o umiarkowanej wartości")
    } else {
      return(if (lang() == "en") "High Level-Value Tree" else "Drzewo wysokiej wartości")
    }
  })
  
  # Decision text
  output$decision <- renderText({
    if (input$permit_reason == "Agricultural/Business Activity") {
      return(if (lang() == "en") "File for a Permit" else "Złóż wniosek o pozwolenie")
    } else {
      return(if (lang() == "en") "Report the Removal of the Tree" else "Zgłoś usunięcie drzewa")
    }
  })
}
