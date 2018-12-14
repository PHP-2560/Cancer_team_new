library(shinythemes)
library(shiny)

# load packages to have everything running in the app!!

ui <- fluidPage(theme= shinytheme("cosmo"),
                titlePanel("Colorectal and Lung Cancer Risk Assesment Tool"),    # Adds Title
                #Adds Navigation Bar at the top of the Page
                navbarPage("Interactive Tools to Help You", 
                           #Creates a tab
                           tabPanel("Introduction",
                                    #Under this tab the main Panel depicts the paragraph below in the color
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
The good news is that a substantial proportion of cancer risks can be significantly mitigated." ),
                                                          #break
                                                          br(),
                                                          #Paragraph output
                                                          p(
"A study conducted by The World Cancer Research Fund concluded that up to one-third of cancer 
causes in developed countries are closely related to behavioral risk factors such as obesity, 
a sedentary lifestyle, smoking, and heavy drinking. Different cancers have distinct risk factors, 
however many lifestyle associated factors such as nutrition, exercise, alcohol and drug use have been 
significantly linked to specific cancer types, including colorectal and lung cancer. However, 
                                                            important to note is that some risks factors such as one’s genetics/age cannot be altered and are
                                                            therefore not accounted for on our risk calculator. Our website offers user friendly, interactive features 
                                                            to calculate your risk of developing colorectal and lung cancer. It is our hope that by learning more you can 
                                                            adopt practices that minimize your risks. Ultimately, we seek to help you become more knowledgeable and proactive toward your health.")
),
                                                          br(),
                                                          p("In the Dietary Recommendations Tab, we have included an explanation of how diet also affects BMI and suggestions on dietary changes to improve one's BMI."),
                                                          br(),
                                                          p("Let's get started!"))),
                                              #break
                                              br(),
                                              #Image is inserted
                                              img(src="exercise.png")
                                                   )),
                           #Another Tab is inserted
                           tabPanel("BMI Analysis",
                                    sidebarPanel(
                                      # Adds buttons for selecting gender and metric system
                                      radioButtons("gender", "Gender", c("Male","Female")),
                                      radioButtons("metric_sys", "Units", choices = c("Metric","Standard"), selected = "Standard"),
                                      # Adds result of DEPENDENT slider bars created in output below
                                      wellPanel(uiOutput("ui_height")),     
                                      wellPanel(uiOutput("ui_weight")),     
                                      # Adding input slider bars reference name, label, min/max values, and starting value respectively
                                      sliderInput("target.date", "Maximum Number of Weeks To Achieve Desired Weight", min = 1, max = 100, value = 50),
                                      sliderInput("intensity", "Number of Hours Devoted to Exercising Every Week", min = 1, max = 20, value = 5)
                                    ),
                                    mainPanel(
                                      plotOutput("weight_distribution"),    # Prints the bmi graph that was created in output below
                                      textOutput("labelBMI"),               # Prints the text of your BMI that was created in ouput below
                                      textOutput("labelTargetBmi"),         # Prints the text of your target BMI that was created in output below
                                      textOutput("labelUSABmi"),            # Prints the text of the your BMI compared to the US pop as created in output below
                                      textOutput("labelUSATargetBmi"),      # Prints the text of the your target BMI compared to the US pop as created in output below
                                      span(textOutput("labelBmiNotes"),style="color:red") #Prints a note on BMI in red
                                    )
                           ),
                           #Inserts another tab
                           tabPanel("Workout Analysis",
                                    fluidRow(
                                      column(width = 5, tableOutput("exercises")),
                                      column(width=5, textOutput("labelcalburn")),
                                      tags$head(tags$style("#labelcalburn{color: blue;font-size: 40px;font-style: bold;}"))
                                    )
                           ),
                           
                           tabPanel("Dietary Recommendations", 
                                    fluidRow(
                                      column(width = 6, textOutput("diet")),
                                      column(width = 3,  img(src="food.png")),
                                      tags$head(tags$style("#diet{color: blue;font-size: 20px;font-style: bold;}"))
                                    )
                           )
                           
                           
                                    )
                )



################## Creating Output (server) section of Shiny App #######################

server <- function(input, output) {
  
  ### Creating dependent slider bars that go into input section ###    
  # Makes a cm or in Slider Bar depending on whether user selects Metric or Standard.
  output$ui_height <- renderUI({
    switch(input$metric_sys,
           "Metric" = sliderInput("height", "Current Height (cm)", min = 140, max = 215, value = 178),   # If metric_sys = "Metric", use this slider bar
           "Standard" = sliderInput("height", "Current Height (in)", min = 55, max = 85, value = 70)     # If metric_sys = "Standard", use this slider bar
    )
  })
  
  # Makes a kg or lbs Slider Bar depending on whether user selects Metric or Standard.
  output$ui_weight <- renderUI({
    switch(input$metric_sys,
           "Metric" = sliderInput("weights", "Desired Weight & Current Weight (kg)", min = 40, max = 160,value = c(80,90)),   # If metric_sys = "Metric", use this slider bar
           "Standard" = sliderInput("weights", "Desired Weight & Current Weight (lbs)", min = 85, max = 350,value = c(180,200))   # If metric_sys = "Standard", use this slider bar
    )
  })
  
  #######################################################################################    
  
  ### Adds Graph for BMI Distribution ###
  #labelBMI
  output$labelBMI<-renderText({weight_distribution(input)$labelBMI})
  #labelTargetBmi
  output$labelTargetBmi<-renderText({weight_distribution(input)$labelTargetBmi})
  #labelUSABmi
  output$labelUSABmi<-renderText({weight_distribution(input)$labelUSABmi})
  #labelUSATargetBmi
  output$labelUSATargetBmi<-renderText({weight_distribution(input)$labelUSATargetBmi})
  #labelBmiNotes
  output$labelBmiNotes<-renderText({weight_distribution(input)$labelBmiNotes})
  #labelcalburn
  output$labelcalburn<-renderText({exercises(input)$labelcalburn})
  
  
  
  #Create a plot from the weight_distribution function input
  output$weight_distribution <- renderPlot({
    weight_distribution(input)$plot
  })
  
  #######################################################################################################  
  
  weight_distribution <- function(input){
    
    # Checks if inputs are NULL, else returns NULL. 
    # Used to take away false error messages when ShinyApp initializes
    # Makes sure input is created only AFTER ShinyApp is finished fully loading
    req(input$height)  
    req(input$metric_sys)
    req(input$gender)
    req(input$weights)
    
    # Turning reactive variables into more feasable variables
    gender <- input$gender          # Converts Shiny App user input for gender slidebar into one variable
    height <- input$height          # Converts Shiny App user input for height slidebar into one variable
    weight <- input$weights[2]      # Converts Shiny App user input for current weight slidebar into one variable
    target.weight<-input$weights[1] # Converts Shiny App user input for target weight slidebar into one variable
    units<-input$metric_sys         # Converts Shiny App user input for metric system option into one variable
    bmi <- health.analysis(height,weight, target.weight,units)$BMI                # Gets BMI from previously specified function
    diagnosis <- health.analysis(height,weight, target.weight,units)$Diagnosis    # Gets BMI diagnosis from previously specified function
    target.bmi <- health.analysis(height,weight, target.weight,units)$Target.BMI  # Converts height (in) and weight (lb) into target BMI
    target.diagnosis <- health.analysis(height,weight, target.weight,units)$Target.Diagnosis   # Gets BMI diagnosis from previously specified function
    
    # Changes parameters and colors of graph depending on selected gender
    if (gender == "Male") {
      mean <- 28.7                # Average BMI of U.S. Adult Males (20+ yrs old)
      sd <- sqrt(5223)*0.13       # Converting given standard error of mean and sample size into standard deviation
      fill1 <- "cadetblue1"       # Used for overall shading of normal curve
      fill2 <- "cadetblue3"       # Darker shade in between current and target BMI
      color1 <- "cadetblue4"      # Used for outline of normal curve
      y <- 0                      
    } else if (gender =="Female"){
      mean <- 29.2
      sd <- sqrt(5413)*0.17
      fill1 <- "lightpink1"
      fill2 <- "lightpink3"
      color1 <- "lightpink4"
      y <- 0.01                   # Only shifts the labels if gender=female to re-adjust for new y-axis
    }
    
    bmi.percent <- round(pnorm(bmi,mean,sd) * 100, 2)            # Rounds bmi to 2 decimal places just for the graph
    target.bmi.percent <- round(pnorm(target.bmi,mean,sd) * 100, 2)            # Rounds bmi to 2 decimal places just for the graph
    
    # Creates cumulative normal distribution graph shading in given BMI
    plot <- ggplot(data.frame(x=c(10,48)), aes(x)) +    # Creates plot from x = 10.6 to 40.6
      # Plots a normal curve with mean = 25.6, sd = 4. Colors area below light blue.
      stat_function(fun=dnorm, args=list(mean,sd), color = color1, size = 2, geom="area", fill=fill1, alpha = 0.4) +     
      scale_x_continuous(name="BMI") +            # Labels x axis "BMI"
      #ggtitle(paste0("Percentile of United States Adult ",gender, "s Less Than Current BMI")) +   # Adds a graph title
      theme_classic() +                           # Makes the background white theme
      # Shades the normal curve between current and target BMI a darker color
      stat_function(fun=dnorm, args=list(mean,sd), xlim=c(target.bmi,bmi), geom="area", fill=fill2, alpha = 0.7) +
      
      # Creates lines and text on graph
      ggtitle("Current and Target BMI Analysis Compared to U.S. Adult Population")+ theme(plot.title = element_text(size = 22, face = "bold", color = "dodgerblue"))+ #Adds title and customizes it
      geom_vline(xintercept=c(18.5,25,30)) +                 # Adds black vertical lines in desired x location
      geom_text(aes(mean,0, label=paste0("|", "\n", "U.S. Average")), color=color1) +  # Adds average tick mark
      geom_text(aes(bmi,0.0025, label=paste0("Current", "\n", "BMI", "\n", "|")), color=color1) +  # Adds average tick mark
      geom_text(aes(target.bmi,0.0025, label=paste0("Target","\n", "BMI", "\n", "|")), color=color1) +  # Adds average tick mark
      geom_text(aes(15,0.05-y, label="Underweight")) +       # Adds Underweight text in top corresponding region
      geom_text(aes(22,0.05-y, label="Normal Weight")) +     # Adds Normal Weight text in top corresponding region
      geom_text(aes(27.5,0.05-y, label="Overweight")) +      # Adds Overweight text in top corresponding region
      geom_text(aes(32,0.05-y, label="Obese"))    +          # Adds Obese text in top corresponding region
      theme(axis.title.y=element_blank(), axis.text.y=element_blank(),axis.ticks.y=element_blank())    # Removes y axis information
    
    labelBMI=paste("Your current BMI: ", round(bmi,digits=1), " (", diagnosis, ")")
    labelTargetBmi=paste("\n","Your target BMI: ", round(target.bmi,digits=1), " (", target.diagnosis, ")")
    labelUSABmi=paste0("Percent of U.S. Adult ",gender, "s less than your current BMI: ", bmi.percent,"%")
    labelUSATargetBmi=paste0("\n", "Percent of U.S. Adult ",gender, "s less than your target BMI: ", target.bmi.percent,"%")
    labelBmiNotes=paste0("Note: BMI may be a misinformative measure", "\n", " of health as it doesn't take into account",
                         "\n", " for muscle mass or body shape.")
    
    #Return a list of the following outputs
    return(list(
      plot=plot,
      labelBMI=labelBMI,
      labelTargetBmi=labelTargetBmi,
      labelUSABmi=labelUSABmi,
      labelUSATargetBmi=labelUSATargetBmi,
      labelBmiNotes=labelBmiNotes
      
      
    ))
  }
  
  #######################################################################################
  
  ### Creating Table of Exercises ###
  output$exercises <- renderTable({
    
    # Checks if inputs are NULL, else returns NULL. 
    # Used to take away false error messages when ShinyApp initializes
    # Makes sure input is created only AFTER ShinyApp is finished fully loading
    req(input$height)  
    req(input$metric_sys)
    req(input$gender)
    req(input$weights)
    
    # Turning reactive variables into more feasable variables
    units<-input$metric_sys           # Converts Shiny App user input for metric system option into one variable
    height <- input$height            # Converts Shiny App user input for height slidebar into one variable
    weight<-input$weights[2]          # Converts Shiny App user input for current weight slidebar into one variable
    target.weight<-input$weights[1]   # Converts Shiny App user input for desired weight slidebar into one variable
    bmi <- health.analysis(height,weight, target.weight,units)$BMI                   # Gets BMI from previously specified function
    target.bmi <- health.analysis(height,weight, target.weight,units)$Target.BMI     # Converts height (in) and weight (lb) into target BMI
    target.date<-input$target.date    # Converts Shiny App user input for desired date slidebar into one variable
    intensity<-input$intensity        # Converts Shiny App user input for intensity slidebar into one variable
    
    if (units == "Standard"){
      cal.per.week <- -((target.weight - weight) / target.date * 3500)   # How many calories should be lost per week on average
      reg_table<- reg_table %>% group_by(Activity)%>%
        mutate(burn.rate=mean(c(target.weight, weight))*standard,
               burn.calories=burn.rate*intensity) 
    } else if (units =="Metric"){
      cal.per.week <- -((target.weight - weight) / target.date * 3500/ 0.453592)   # How many calories should be lost per week on average
      reg_table<- reg_table %>% group_by(Activity)%>%
        mutate(burn.rate=mean(c(target.weight, weight))*metric,
               burn.calories=burn.rate*intensity) 
    }
    summary_table=reg_table %>% filter((.9*cal.per.week)<=burn.calories) 
    
    if (target.bmi < 17) {                 
      if (bmi > 17){                     # Checks to see if target weight is too low
        print("Desired weight is very underweight and may be unhealthy. Please consider a different weight.")
      } else{                            # Checks to see if current weight needs a weight loss program
        print("You are already very underweight and may not need a weight loss program.")
      }
    } else if (cal.per.week > 7000){       # Checks to see if weight loss plan is too extreme
      print("Losing more than 2 lbs/week may be considered unrealistic and unsafe.")
    } else if (nrow(summary_table)==0){    # Checks to see if any exercises are available
      print("No exercises match your criteria. Please change intensity and/or target date.")
    } else{
      # Prints all exercises that can burn that many calories per hour or more
      summary_table %>% 
        select(Activity,burn.rate) %>% 
        arrange(burn.rate) %>%
        dplyr::rename("Calories Per Hour" = burn.rate)
    }
  })
  
  
  #######################################################################################################  
  
  output$diet <- renderText ({
    paste("Reducing the amount of fat you carry is pivotal to improving your health and lowering your BMI. 
          One of the first steps is to cut back on foods that provide excess calories. 
          Some of the main culprits in a typical diet are sugar-sweetened drinks, fatty snacks, and dairy desserts. 
          Cutting back on these foods and aiming to choose healthier alternatives such as replacing soda with water, potato chips with apples, and ice cream with yogurt is enough to improve your BMI.")
  })
  }


#######################################################################################################

exercises<-function(input){
  req(input$metric_sys)
  req(input$weights)
  
  units<-input$metric_sys           # Converts Shiny App user input for metric system option into one variable
  weight<-input$weights[2]          # Converts Shiny App user input for current weight slidebar into one variable
  target.weight<-input$weights[1]   # Converts Shiny App user input for desired weight slidebar into one variable
  target.date<-input$target.date    # Converts Shiny App user input for desired date slidebar into one variable
  
  if (units == "Standard"){ #if standard selected, use cal.per.week for standard measurements
    cal.per.week <- -((target.weight - weight) / target.date * 3500)   # How many calories should be lost per week on average
    labelcalburn=paste("To reach your goal of", input$weights[1], "lbs over",input$target.date ,"weeks, you will need to burn", round(cal.per.week,2), 'calories per week.', sep=' ') #print explanation
    
  } else if (units =="Metric"){#if metric selected, use cal.per.week for metric measurements
    cal.per.week <- -((target.weight - weight) / target.date * 3500/ 0.453592)   # How many calories should be lost per week on average
    labelcalburn=paste("To reach your goal of", input$weights[1], "kg over",input$target.date ,"weeks, you will need to burn", round(cal.per.week,2), 'calories per week.', sep=' ') #print explanation
  }
  return(list(
    labelcalburn=labelcalburn
  ))
}


#######################################################################################################

shinyApp(ui = ui, server = server)
