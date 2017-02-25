#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(tidyr)
library(plyr)
library(dplyr)
library(janitor)
library(readr)
library(ggplot2)
library(shiny)

attacks <- read_csv2("./attackInAggregate.csv") 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
  
        minValue <- eventReactive(input$goButton, {input$years[1]})
        maxValue <- eventReactive(input$goButton, {input$years[2]})
       
        yearSelected <- eventReactive(input$goButton, {
                paste("From ", input$years[1], " to ", input$years[2])
        })
        
        output$title <- renderText({ 
                yearSelected()
        })
        
       
        
        output$attacks<-renderPlot({
                
                attack_year_rgn <- 
                        attacks %>%
                        filter (iyear >= minValue() & iyear <= maxValue()) %>%
                                mutate (iyear = as.factor(iyear))
                
                maxAttacks <- 
                        attack_year_rgn %>%
                                group_by (iyear) %>%
                                summarize (total = sum(attacks)) %>%
                                ungroup()
                
                maxAttacks <- (max(maxAttacks$total) + 500)
                
                p <- ggplot(data = attack_year_rgn, aes(x = iyear, y=attacks, fill = Region)) +
                        geom_bar( stat = "identity") +
                        theme_bw() +
                        theme(axis.text.x = element_text(angle = 90, hjust=0.85,vjust=0.5),
                              legend.justification=c(0,0), legend.position=c(.05,.6),
                              legend.background = element_rect(colour = "black")) +
                        scale_y_continuous(expand=c(0,0), limits=c(0, maxAttacks)) +
                        labs(title = "Terrorism Incidents by Year and Region", x = "Year", y = "Number of Incidents")
                print(p)
                        
        },
        height = 800, units="px")
        
        
})
       
        
  
       
