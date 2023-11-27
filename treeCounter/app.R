# app.R or main.R

# Source initialization script
source("init.R")

# Source data loading and preprocessing script
source("eda.R")

# Source data splitting script
source("split_data.R")

# Source machine learning model training script
source("path/to/train_model.R")

# Source Shiny app UI and server scripts
source("ui.R")
source("server.R")

# Launch the Shiny app
shinyApp(ui, server)
