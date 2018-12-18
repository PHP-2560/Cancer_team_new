
library(shiny)
library(tools)
library(ggrepel)
library(dplyr)
library(mapproj)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   tabPanel("Distribution Map",
          
            
   # Sidebar with a slider input for number of bins 
      sidebarPanel(
        h1("Smoking and Lung Cancer"),
        p("There are many factors are associated with lung cancer.",
          span(strong("Smoking is most important factor associated with the rate of Lung Cancer.")),
          "Below you can choose to see the distribution of smoking rate and lung cancer distribution across the United States in different years"),
        
        
        radioButtons("year","Year" ,
                     c("2011" = "2011",
                       "2012" = "2012",
                       "2013" = "2013",
                       "2014" = "2014",
                       "2015" = "2015"))
        ),
      
      # Show a plot of the generated distribution
    mainPanel(
      
         plotOutput("smoking"),
         plotOutput("cancer")
         
      )
   )
   )

# Define server logic required to draw a histogram
server <- function(input, output) {
  states= map_data("state")
  states$region=toTitleCase(states$region)
  smokinglungcancer=read.csv("~/1560/20112015smokingcancer.csv")
  state_distribution=inner_join(states, smokinglungcancer, by = "region")
  
  output$smoking <- renderPlot({
    smokingdata=state_distribution%>%
      filter(year==input$year)
    gg <- ggplot()
    gg <- gg + geom_map(data=states, map=states,
                        aes(long,lat, map_id=region),
                        fill="#ffffff", color="#ffffff", size=0.15)
    gg <- gg + geom_map(data=smokingdata, map=states,aes(fill=smoking, map_id=region),
                        color="#ffffff", size=0.15)
    gg <- gg + scale_fill_gradient(low='yellow', high='red', guide='colorbar',limits=c(9,30),name = "Smoking Rate(%)")
    gg <- gg + labs(x=NULL, y=NULL)
    gg <- gg + coord_map("albers", lat0 = 39, lat1 = 45)#+geom_text_repel(data = smokingdata, aes(long, lat, label = region), size = 3,box.padding = unit(0.1, 'lines'), force = 0.5) 
    #gg <- gg + geom_text(aes(label=smoking))
    #gg <- gg + ggrepel::geom_label_repel(data=smokingdata, aes(x=long, y=lat, label=region))
    gg <- gg + theme(panel.border = element_blank())
    gg <- gg + theme(panel.background = element_blank())
    gg <- gg + theme(axis.ticks = element_blank())
    gg <- gg + theme(axis.text = element_blank())
    gg <- gg + ggtitle("Smoking Rate Distribution in United States")
    gg
    
    
    
    
    
    
    #ggplot(data=smoking,aes(x = long, y = lat,label=smoking, fill=smoking,group = region))+geom_polygon( color = "white") + coord_fixed(1.3)+scale_fill_gradient(low="blue", high="red",limits=c(9,30),name = "Smoking Rate(%)")+ geom_text_repel()
  })
  

  
  output$cancer <- renderPlot({
    cancerdata=state_distribution%>%filter(year==input$year)
    
    gg1 <- ggplot()
    gg1 <- gg1 + geom_map(data=states, map=states,
                        aes(x=long, y=lat, map_id=region),
                        fill="#ffffff", color="#ffffff", size=0.15)
    gg1 <- gg1 + geom_map(data=cancerdata, map=states,
                        aes(fill=cancer, map_id=region),
                        color="#ffffff", size=0.15)
    gg1 <- gg1 + scale_fill_gradient(low='blue', high='green', 
                                   guide='colorbar',limits=c(0.02,0.12),name = "Lung Cancer Rate(%)")
    gg1 <- gg1 + labs(x=NULL, y=NULL)
    gg1 <- gg1 + coord_map("albers", lat0 = 39, lat1 = 45) 
    gg1 <- gg1 + theme(panel.border = element_blank())
    gg1 <- gg1 + theme(panel.background = element_blank())
    gg1 <- gg1 + theme(axis.ticks = element_blank())
    gg1 <- gg1 + theme(axis.text = element_blank())
    gg1 <- gg1 + ggtitle("Smoking Rate Distribution in United States")
    gg1    
    
    
    
    #ggplot(data = cancer,aes(x = long, y = lat, fill=smoking,group = region)) + geom_polygon( color = "white") + coord_fixed(1.3)+scale_fill_gradient(low="blue", high="red",limits=c(9,30),name = "Lung Cancer Rate(%)")

    })
}


# Run the application 
shinyApp(ui = ui, server = server)

