library(shiny)
library(Ecdat)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates plot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$airlineData <- renderPlot({
    
    ## Retrieving the Airline Data
    data("Airline")
    xData <- as.data.frame(Airline)  # Old Faithful Geyser data
    
    ## function enabling to take last character for a string
    substrRight <- function(x, n){
      substr(x, nchar(x)-n+1, nchar(x))
    }
    
    ## Subsetting AirlineData to extract only the data for the selecte airline
    xDataAirlineSelected <- xData[xData$airline == substrRight(input$var, 1),]
    y <- xDataAirlineSelected$cost
    y1 <- xDataAirlineSelected$pf
    x <- xDataAirlineSelected$year
    
    # Drawing the graph of cost and fuel price for the selected Airline
    par(mfrow=c(2,1))
    plot(x,y,type="l", xlab="Years",ylab="total cost, in $1,000", main=paste("Evolution of ",input$var," cost through years"), xlim=input$range1)
    plot(x,y1,type="l", col='red',xlab="Years",ylab="fuel price", main=paste("Evolution of ",input$var," fuel price through years"), xlim=input$range1)
  })
  
  # This is the second section
  ## Where you can select some airlines to compare according to a criteria selected
  output$airlineData1 <- renderPlot({
    
    ## Retrieving the Airline Data
    data("Airline")
    xData <- as.data.frame(Airline)  
    
    ## Getting the selected criteria
    xDataCritereSelected <- input$criteres
    colors <-  as.vector(c('black','red','blue','green','brown','orange'))
    
    
    # Drawing the Graph
    if(length(input$checkGroup)>=0)
    {
        columnCritere = xData[,c(xDataCritereSelected)]
        miny = min(columnCritere)
        maxy = max(columnCritere)
        years = xData[xData$airline == '1',c("year")]
        
        x <- years
        for(i in c('1','2','3','4','5','6'))
        {
          if(i %in% input$checkGroup)
          {
            xDataAirlineSelected1 = xData[xData$airline == i,c(xDataCritereSelected)]
            y <- xDataAirlineSelected1
            if(substr(input$checkGroup,1,1)==i)
            {
              plot(x,y,type="l", xlab="Years",ylab=input$criteres, main=paste("Comparison of Evolution of Airlines'",input$criteres," through years"), xlim=input$range2,ylim=c(miny,maxy), col=colors[as.numeric(i)])
            }
            else
            {
              lines(x,y, col=colors[as.numeric(i)])
            }
          }
        }
    }
    })
 
})