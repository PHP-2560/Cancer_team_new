library(shinythemes)
library(shiny)
library(ggplot2)
library(dplyr)


# load packages prior to running the app in order to have everything running in the app!!

ui <- fluidPage(theme= shinytheme("cosmo"),
                titlePanel("Lung Cancer Risk Assesment Tool"),    # Adds Title of the Website, hence Main Title
                # Adds Navigation Bar at the top of the Page
                # This is to have different tabs in the website
                navbarPage("Interactive Tools to Help You", 
                           #Creates a tab
                           tabPanel("Introduction",
                                    # Under this tab the main Panel depicts the paragraph below in the color
                                    mainPanel(span(style="color:black",
                                                   #Paragraph output bold
                                                   strong(p(""),
                                                          #break
                                                          br(),
                                                          #Paragraph output
                                                          # Paragrpah to introduce the app and explain the risk assesment tool
                                                          
                                                          p(
                                                            "Welcome to our website! With the incidence of cancer at an all-time high, 
                                                            it is imperative to learn about the associated risk factors in order to 
                                                            be better equipped to take proactive measures. According to 
                                                            the United States National Institute of Health (NIH), an estimated 1,735,350 
                                                            new cases of cancer will be diagnosed in the U.S. each year and 609,640 people will
                                                            die from the disease in 2018 alone. Cancer is the second leading cause of death in the U.S., 
                                                            and scientists predict that as the current population continues to age, these numbers will 
                                                            dramatically increase. This will have a major impact on many aspects of society, including economics. 
                                                            The NIH reported that in 2017, national expenditure for cancer care was $147.3 billion, 
                                                            and this number is also likely to increase in coming years. 
                                                            Given the unsettling implications of this data, action is required. 
                                                            The good news is that a substantial proportion of cancer risks can be significantly mitigated."),
                                                          #break
                                                          br(),
                                                          #Paragraph output
                                                          p(
                                                            "A study conducted by The World Cancer Research Fund concluded that up to one-third of cancer 
                                                            causes in developed countries are closely related to behavioral risk factors such as obesity, 
                                                            a sedentary lifestyle, smoking, and heavy drinking. Different cancers have distinct risk factors, 
                                                            however many lifestyle associated factors such as nutrition, exercise, alcohol and drug use have been 
                                                            significantly linked to specific cancer types, including lung cancer. However, 
                                                            important to note is that some risks factors such as one’s genetics/age cannot be altered and are
                                                            therefore not accounted for on our risk calculator. Our website offers user friendly, interactive features 
                                                            to calculate your risk of developing colorectal and lung cancer. It is our hope that by learning more you can 
                                                            adopt practices that minimize your risks. Ultimately, we seek to help you become more knowledgeable and proactive toward your health."),
                                                          br(),
                                                          
                                                          p("Disclaimer"),
                                                          
                                                          br(),
                                                          
                                                          p("All the information and analysis provided on this website is for educational purposes ONLY. 
                                                            The information is NOT intended to replace any clinical judgement in any matter. 
                                                            Please seek professional help from a qualified medical provider if you have any concerns about your health and/or cancer risk."),
                                                          
                                                          br(),
                                                          p("Let's get started!"))),
                                              #break
                                              br(),
                                              #Image is inserted
                                              img(src ="Prevention_pic.jpg", width="400"),
                                              br()
                                              
                                                          )),
                           
                           
                           tabPanel("Body Mass Index Calculator (BMI)",
                                    sidebarPanel(
                                      helpText("Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women. 
                                               The BMI is not always an accurate measure of health because it does not take into account muscle mass or body shape."),
                                      numericInput("num_height", label = h3("Height (in)"),value=60),
                                      numericInput("num_weight", label = h3("Weight (lbs)"),value=100),
                                      actionButton("action_calc", label = "Calculate")),
                                    # Create the individual tabs separatley!
                                    mainPanel(
                                    h2("Calculated values:"),div(textOutput("text_bmi"), style="font-weight: bold;"), 
                                    textOutput("text_type")),
                                    img(src="Intro-diagram.jpg", width=420,align="center")),
                                    
                            
                           
                           
                           
                           
                           
                           
                           
                           tabPanel("Tobacco Use Increases Lung Cancer Risk",
                                    sidebarPanel(
                                      helpText("This plot shows a linear regression model of tobacco use and cancer risk. 
                                               The data used to make this plot was gathered from the CDC's website."),
                                      #radioButtons("Region", c("midwest", "northeast","south","west"), selected = "midwest")),
                                      selectInput("Region","Region:", 
                                                  choices=c("midwest", "northeast","south","west"))),
                                    # Show a plot of the generated distribution
                                    mainPanel(
                                      plotOutput("lungplot")
                                    )),
                           
                           
                           
                           
                           ##Inserts another tab, lung cancer calculator tab
                           tabPanel("Lung Cancer Risk Calculator",
                                    sidebarPanel(
                                      helpText("This calculator is based on the LLP risk model: an individual risk prediction model for lung cancer. 
                                               It is a model-based approach that estimates your probability of developing lung cancer within a 5-year period. 
                                               It takes into account specific risks factors that have been strongly correlated with lung cancer such as tobacco use, 
                                               exposure to environmental contaminants, and a family history of lung cancer. Source: Cassidy et al., 2008. 
                                               British Journal of Cancer (2008) 98, 270-276."),
                                      # Adds buttons for selecting gender and metric system
                                      radioButtons(
                                        inputId  = "sex",
                                        label    = "Sex",
                                        choices  = c("Male" = 1, "Female" = 2),
                                        selected = 2
                                      ),
                                      numericInput("age",label= h4("Age"),value=50),
                                      numericInput("smoking",label=h4("Number of Years You Have Smoked"), value=1),
                                      
                                      radioButtons(
                                        inputId  = "pneumonia",
                                        label    = "Have You Ever Been Diagnosed with Pneumonia",
                                        choices  = c("Yes" = 1, "No" = 0),
                                        selected = 0
                                      ),
                                      
                                      radioButtons(
                                        inputId  = "asbestos",
                                        label    = "Have You Been Exposed to Asbestos",
                                        choices  = c("Yes" = 1, "No" = 0),
                                        selected = 0
                                      ),
                                      
                                      radioButtons(
                                        inputId  = "malignant_tumour",
                                        label    = "Prior Diagnosis of a Malignant Tumor",
                                        choices  = c("Yes" = 1, "No" = 0),
                                        selected = 0
                                      ),
                                      
                                      numericInput("family_history", label=h4("Prior Family History of Lung Cancer (Onset)"),value=1)),
                                    mainPanel(span(style="color:black",
                                                   p(h4("Calculated values:")),
                                                   textOutput("text_risk"), style="font-weight: bold;")))
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           ######################################################################################################################################################
                           ## Do Not touch this part! This is to close the UI part
                           
                           ))
######################################################################################################################################################
# Setting up the server!!!!

server <- function(input, output,session) {
  values <- reactiveValues()
  
  ######################################################################################################################################################
  # BMI Function Server
  
  
  output$text_bmi <- renderText({
    input$action_calc
    values$bmi<-isolate({input$num_weight/((input$num_height)*(input$num_height))}*703)
    paste("BMI: ", isolate(round(values$bmi,digits=1))) # prints out only 1 decimal place
  })
  
  output$text_type <- renderText({
    input$action_calc
    values$bmi<-isolate({input$num_weight/((input$num_height)*(input$num_height))}*703)
    if(values$bmi<18.5){
      paste("Underweight")
      #img(src="underweight-bmi.png")
      
    }else
      if(values$bmi>=18.5 & values$bmi<20.0){
        paste("Healthy")
        #img(src="normal-weight-bmi.png")
        
      }else
        if(values$bmi>=20.0 & values$bmi<24.9){
          paste("Overweight")
          
        }else
          if(values$bmi>=24.9 & values$bmi<29.9){
            paste("Obesity")
            
            
          }else
            if(values$bmi>=29.9){
              paste("Morbid Obesity")}
    
  })
  
  lung <-read.csv("lung.csv")
  #lung
  
  
  output$lungplot <- renderPlot({
    ggplot(lung %>% filter(Region == input$Region) %>% mutate(Year=as.factor(Year)),
           aes(x=Smokerate, y=Cancerrate)) +
      geom_point(size=5, aes(color=Year)) +
      xlab("Smoking Rate") +
      ylab("Cancer Rate") +
      ggtitle("Smoking is Directly Correlated to Lung Cancer") +
      #facet_grid(~Region)+
      geom_smooth(method = "lm") +
      theme_bw()
  })
  
  
  
  # Lung Cancer Preduction Function
  
  output$text_risk <- renderText({
    source("lung_func.R")	
    #	as.numeric( )
    
    lung_cancer_risk(age = as.numeric(input$age), sex = as.numeric(input$sex), smoking = as.numeric(input$smoking),
                     pneumonia = as.numeric(input$pneumonia), asbestos = as.numeric(input$asbestos),
                     malignant_tumour = as.numeric(input$malignant_tumour), family_history = as.numeric(input$family_history))
    
    
    #lung_cancer_risk(age=50,sex=1,smoking=1,pneumonia=1,asbestos=1,malignant_tumour=1,family_history=1)
    
  })
  
  
  
  
  
  
  
  
  
  ######################################################################################################
  # Do not touch anything after this part!!!!
  
  
}
shinyApp(ui, server)