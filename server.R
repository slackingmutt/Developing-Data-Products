###############################################################################
#
# Classify an iris into one of three species depending on four parameters:
# sepal length, sepal width, petal length and petal width
#
library(shiny)
library(datasets)
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)
library(e1071)


#
data(iris)

#
# Construct a model using classification trees
#
fit <- train(Species~.,method="rpart",data=iris)

#
# Initialize the data frame to be used for prediction
#
df <- data.frame(Sepal.Length = 0.0,
           Sepal.Width = 0.0,
           Petal.Length = 0.0,
           Petal.Width = 0.0)

# Define server logic required to plot various variables against Species
shinyServer(function(input, output) {
     
         x <- reactive({df$Sepal.Length = as.numeric(input$sepalLength)
                        df$Sepal.Width = as.numeric(input$sepalWidth)
                        df$Petal.Length = as.numeric(input$petalLength)
                        df$Petal.Width = as.numeric(input$petalWidth)
                        pred <- predict(fit,df)
                        ifelse( as.numeric(pred[which(pred != 0)]) ==1, "setosa",
                                ifelse( as.numeric(pred[which(pred !=0)]) == 2, "versicolor",
                                        "virginica"))
                      })
         
         output$slvalue <- renderPrint({input$sepalLength})  
         output$swvalue <- renderPrint({input$sepalWidth})
         output$plvalue <- renderPrint({input$petalLength})
         output$pwvalue <- renderPrint({input$petalWidth})
         output$text <- renderText({x()})
#        output$caption <- renderText({
#                formulaText()
#                })
        
       output$irisPlot <- renderPlot({
              fancyRpartPlot(fit$finalModel,sub="")
       }) 
  
})
