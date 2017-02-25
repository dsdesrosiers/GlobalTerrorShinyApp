#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Terrorism by Year"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("years",
                   "Select Years:",
                   min = 1970,
                   max = 2016,
                   value = c(1970,2016),
                   sep = "") ,
       actionButton("goButton", "Go!"),
       tags$p(),
       withTags({
               div(class="header", checked=NA,
                   p("National Consortium for the Study of Terrorism and Responses to Terrorism (START). (2016). Global Terrorism Database [Data file]. Retrieved from ", a(href="https://www.start.umd.edu/gtd/", "https://www.start.umd.edu/gtd/")),
                   p(),
                   a(href="https://www.start.umd.edu/gtd/downloads/Codebook.pdf", "Codebook"),
                   p(),
                   a(href="https://github.com/dsdesrosiers/GlobalTerrorShinyApp", "Git Hub Repo")
               )
       })
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
            
            h2("Incidents by Region"),
            tags$p(),
            h3(textOutput("title")),
            
            #tableOutput("values"),
            tags$p(),
            
            plotOutput("attacks")
            
            
    )
  )
))
