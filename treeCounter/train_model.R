# train_model.R


library(shiny)

# Defining a reactive for the training dataset
training_data_reactive <- reactive({
  return(training_data)
})

# Training the random forest model
rf_model <- reactive({
  formula <- as.formula("permit ~ tree_circumference")
  model <- randomForest(formula, data = training_data_reactive(), ntree = 100)
  return(model)
})

# Evaluating model performance
model_evaluation <- reactive({
  test_data <- tree_data[-train_indices, ]
  predictions <- predict(rf_model(), newdata = test_data)
  
  # Confusion matrix from caret package
  confusion_matrix <- confusionMatrix(predictions, test_data$permit)
  
  # Extracting accuracy and precision
  accuracy <- confusion_matrix$overall["Accuracy"]
  precision <- confusion_matrix$byClass["Precision"]
  
  # Adding accuracy and precision to the confusion matrix object
  confusion_matrix$accuracy <- accuracy
  confusion_matrix$precision <- precision
  
  return(confusion_matrix)
})