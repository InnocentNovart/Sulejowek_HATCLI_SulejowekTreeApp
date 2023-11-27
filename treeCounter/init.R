# file name is init.R
# This sample R code is used to install packages and initialize R

my_pckgs <- c("htmltools", "leaflet", "mice", "shiny", "dplyr", "ggplot2", "shinyjs", "readxl", "randomForest", "data.table", "caret")

install_if_missing <- function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

# Install the specific version of htmltools
if ("htmltools" %in% my_pckgs) {
  install.packages("htmltools", version = "0.5.7", dependencies = TRUE)
}

# Install other packages
invisible(sapply(my_pckgs, install_if_missing))
