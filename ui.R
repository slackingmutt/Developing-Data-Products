#
# Developing Data Products Coursera project February 2015
#
library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
        # Application title
        headerPanel("Iris Classification"),  
        # Plot images of the three species
        sidebarPanel(
                tags$head(
                        tags$img(src="virginica.jpg",height=100,width=100),
                        tags$img(src="setosa.jpg",height=100,width=100),
                        tags$img(src="versicolor.jpg",height=100,width=100)
                ),
                # Check boxes for input
                # mean values from iris data used as defaults
                numericInput("sepalLength", "Sepal Length", 
                             5.8, min = 0.1, max = 10.0, step = 0.1),
                numericInput("sepalWidth", "Sepal Width", 
                             3.1, min = 0.1, max = 10.0, step = 0.1),
                numericInput("petalLength", "Petal Length", 
                             5.8, min = 0.1, max = 10.0, step = 0.1),
                numericInput("petalWidth", "Petal Width", 
                             1.2, min = 0.1, max = 10.0, step = 0.1),
                submitButton("Submit")
        ),
        
        mainPanel(
                h3("Usage:"),
                "Through a classification tree, three species of iris 
                 - virginica, setosa, and versicolor - 
                 may be differentiated through 
                 petal and sepal measurements. 
                 Select values from the boxes on the left
                 to determine the species corresponding to those values.",
                h3("Predicted Species:"),
                verbatimTextOutput("text"),
                # picture of the tree
                h3("Classification Tree"),
                plotOutput("irisPlot")
                )
))
