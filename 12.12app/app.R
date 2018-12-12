#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
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

library(shiny)
ui <- fluidPage(
  
  pageWithSidebar(
    
    # Application title
    headerPanel("Body Mass Index (BMI) Calculator"),
    
    sidebarPanel(
      helpText(strong("The Body Mass Index (BMI)"), ("is a measure of body fat based on height and weight and applies 
                                                     to adult men and women. BMI can be used   to screen for weight categories that may lead to 
                                                     health problems but it is not diagnostic of the body fatness or health of an individual.
                                                     Source: United States Centers for Disease Control and Prevention."),
               strong("Disclaimer: All the information and analysis provided in this app is for educational purposes only. 
                      The information is NOT intended to replace any clinical judgment in any manner. 
                      Please seek professional help if you have any concerns about your health."))),
    
    
    
    