library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Airline Data Explore"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Choose an airline and see the Price evolution and the fuel evolution through years."),
      selectInput("var", 
                  label = "Choose an Airline:",
                  choices = list("Airline 1", "Airline 2",
                                 "Airline 3", "Airline 4","Airline 5","Airline 6"),
                  selected = "Airline 3"),
      sliderInput("range1", "Year Range:",
                  min = 1, max = 15, value = c(1,15))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("airlineData")
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("criteres", 
                  label = h4("Compare Airlines by:"),
                  choices = list("Cost" ="cost", "Fuel Price"="pf",
                                 "Output"="output", "Load Factor"="lf"),
                  selected = "cost"),
      checkboxGroupInput("checkGroup", 
                         label = h4("Select Airlines to Compare:"), 
                         choices = list("Airline 1 (black)" = 1, 
                                        "Airline 2 (red)" = 2, "Airline 3 (blue)" = 3
                                        ,"Airline 4 (green)" = 4, "Airline 5 (brown)" = 5
                                        ,"Airline 6 (orange)" = 6),
                         selected = 1)
    ,
    sliderInput("range2", "Year Range:",
                min = 1, max = 15, value = c(1,15))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
     plotOutput("airlineData1")
    )
  )
))