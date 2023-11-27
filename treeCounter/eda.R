# file name is eda.R
# This sample R code is used to perform the exploratory data analysis and preprocessing

# Loading the required library
library(dplyr)
library(readxl)

# Loading and reading data
tree_data <- read_excel("new_york_tree_census_2015.xlsx", sheet="species")

location_data <- read_excel("new_york_tree_census_2015.xlsx", sheet="location")

# checking the shape of the tree_data
tree_data_shape <- dim(tree_data)
cat("Number of rows:", tree_data_shape[1], "\n")
cat("Number of columns:", tree_data_shape[2], "\n")

location_data_Shape <- dim(location_data)
cat("Number of rows:", location_data_Shape[1], "\n")
cat("Number of columns:", location_data_Shape[2], "\n")

# handling missing values
tree_data <- na.omit(tree_data, inplace = TRUE)
location_data <- na.omit(location_data, inplace = TRUE)

# checking for null values
tree_missing_data <- data.frame(
  Column = names(tree_data),
  Missing_Values = colSums(is.na(tree_data))
)

print(tree_missing_data)

location_missing_Data <- data.frame(
  Column = names(location_data),
  Missing_values = colSums(is.na(location_data))
)

print(location_missing_Data)


# permit column
# Assuming 'tree_data' is your data frame
tree_data$permit <- ifelse(tree_data$tree_circumference >= 50, 1, 0)

View(head(tree_data))
