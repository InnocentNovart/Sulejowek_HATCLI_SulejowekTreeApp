# ui.R

library(shiny)
library(shinyjs)

# Define UI components
ui <- fluidPage(
  shinyjs::useShinyjs(),  
  
  titlePanel("Sulejowek Tree Felling Decision App"),
  
  # Language switch
  sidebarLayout(
    sidebarPanel(
      actionButton("lang_switch", "Switch Language"),
      selectInput("fallen_by_nature", "Tree fallen by forces of nature?", choices = c("Yes", "No")),
      selectInput("species", "Select tree species", choices = unique(tree_data$spc_common)),
      numericInput("circumference", "Enter tree circumference (cm):", min = 0, value = 0),
      selectInput("permit_reason", "Reason for felling/cutting (if applicable)", 
                  choices = c("Agricultural/Business Activity", "Other"))
    ),
    
    mainPanel(
      plotOutput("circumference_plot"),
      textOutput("permit_status"),
      textOutput("classification"),
      textOutput("decision")
    )
  )
)
