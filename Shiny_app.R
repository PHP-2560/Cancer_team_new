library(shiny)
ui <- fluidPage()
server <- function(input, output) {}
shinyApp(ui = ui, server = server)


#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Setting up packages
library(shiny)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)


colon_data <- read.csv("colon_data.csv")
print(str(colon_data))

ui <- fluidPage(
  titlePanel("Colon Cancer Rates in the United States 2011-2015"),
  sidebarLayout(
    sidebarPanel("our inputs will go here"),
    mainPanel("the results will go here")
  )
)
















server <- function(input, output) {}

shinyApp(ui = ui, server = server)