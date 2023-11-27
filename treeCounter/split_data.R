# split_data.R

# Load required libraries
library(caret)

# Split data into training and testing sets
set.seed(123)  # Set seed for reproducibility
train_indices <- createDataPartition(tree_data$permit, p = 0.8, list = FALSE)
train_data <- tree_data[train_indices, ]
test_data <- tree_data[-train_indices, ]
