#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny)
library(ggplot2)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Adult BMI Calculator"),
   
   # To add a paragaph on BMI
   mainPanel(
     p(
strong("The Body Mass Index (BMI)"), ("is a measure of body fat based on height and weight and applies 
to adult men and women. BMI can be used   to screen for weight categories that may lead to 
health problems but it is not diagnostic of the body fatness or health of an individual.
Source: United States Centers for Disease Control and Prevention."),
strong("Disclaimer: All the information and analysis provided in this app is for educational purposes only. 
The information is NOT intended to replace any clinical judgment in any manner. 
Please seek professional help if you have any concerns about your health."))),

   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

