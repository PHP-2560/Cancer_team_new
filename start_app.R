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
             
      
      
    
      numericInput('weight', 'Insert your weight (kilograms)', 0),
      numericInput('height', 'Insert your height (metres)', 0, min = 0.2, max = 3, step = 0.01),
      submitButton('Submit')
    ), 
    
    mainPanel(
      
      tabsetPanel(
        tabPanel("BMI Calculator",
                 h4(('Your BMI is:'),style = "color:blue"),
                 verbatimTextOutput("output"),
                 h4(('Your category:'),style = "color:magenta"),
                 strong(verbatimTextOutput("calculate"))
        ),
        tabPanel("Documentation",
                 p(h4("Simple BMI Calculator:")),
                 helpText("This application calculates BMI of adult person for given height and weight. To calculate your BMI, enter your height(in metres) and weight(in KG) in the form."),
                 p(h4("What is BMI?")),
                 helpText("BMI means Body Mass Index. The BMI shows the relation between a person's height and weight, 
                          and can be used to indicate whether the person has a normal weight or if he/she is underweight or overweight. 
                          BMI can also be called the Quetelet index, after its inventor, the Belgian scientist Adolphe Quetelet (1796-1874)"),
                 helpText("Regarding the BMI measure, the World Health Organization (WHO) proposes the following classification (For adults over 20 years old):"),
                 helpText("[<18.5] : Underweight"),
                 helpText("[18.5-24.9] : Normal weight"),
                 helpText("[25-29.9] : Overweight"),
                 helpText("[>=30] : Obesity"),
                 HTML("<u><b>Equation for calculation: </b></u>
                      <br> <br>
                      <b> BMI = W /(H * H) </b>
                      <br>
                      where: <br>
                      BMI = Body Mass Index <br>
                      W = Weight in KG <br>
                      H = Height in metres")                
                 )
                 )
                 )
                 )   
                 )

# Run the application 
shinyApp(ui = ui, server = server)
