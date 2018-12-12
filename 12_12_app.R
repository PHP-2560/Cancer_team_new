# Define UI for application that draws a histogram
ui <- fluidPage(
  navbarPage("Introduction",
  
             # UI is what the user changes and interacts with, mostly the  left side of the panel!
  # Application title
  tabPanel("Body Mass Index Calculator (BMI)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women."),
     radioButtons("is.standard","Units",choices=c("Standard","Metric"),selected="Standard"),
       numericInput("num_height", label = h4("Height (Cms)"),value=160),
      numericInput("num_weight", label = h4("Weight (Kg)"),value=58.50),
      actionButton("action_calc", label = "Calculate")        
    ),
    
    # Create the individual tabs separatley!
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Output",
                 p(h4("Entered values:")), div(textOutput("text_weight"), style="font-size:100%;"),textOutput("text_height"),  
                 p(h4("Calculated values:")),div(textOutput("text_bmi"), style="font-weight: bold;"), textOutput("text_type")
                 
                
                 )
                 )
      )
        )
        )
)

server <- function(input, output,session) {
  values <- reactiveValues()
  
  # Display values entered
  output$text_weight <- renderText({
    input$action_calc
    paste("Weight (Kg): ", isolate(input$num_weight))
  })
  
  output$text_height <- renderText({
    input$action_calc
    paste("Height (Cms): ", isolate(input$num_height))
  })
  
  output$text_bmi <- renderText({
    input$action_calc
    values$bmi<-isolate({input$num_weight/((input$num_height/100)*(input$num_height/100))})
    paste("BMI: ", isolate(values$bmi))
  })
  
  output$text_type <- renderText({
    input$action_calc
    values$bmi<-isolate({input$num_weight/((input$num_height/100)*(input$num_height/100))})
    if(values$bmi<18.5){
      paste(strong("Underweight"))
      img(src="")
      
    }else
      if(values$bmi>=18.5 & values$bmi<20.0){
        paste("Healthy")
      }else
        if(values$bmi>=20.0 & values$bmi<24.9){
          paste(("Overweight"))
        }else
          if(values$bmi>=24.9 & values$bmi<29.9){
            paste(("Obesity"))
          }else
            if(values$bmi>=29.9){
              paste("Morbid Obesity")}
  })
  
  
}

shinyApp(ui, server)