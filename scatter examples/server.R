library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
source("build_hist.r")
source("build_scatter.r")

shinyServer(function(input, output) { 
  output$scatter <- renderPlotly({
    return(scatter_plot(midwest, input$search, input$oof[1], input$oof[2]))
  })
  output$hist <- renderPlot({
    return(histogram(mean_black, input$state1, input$state2))
  })
})

shinyServer(function(input, output) { 
  output$hist <- renderPlot({
    return(histogram(mean_black, input$state1, input$state2))
  })
  output$scatter <- renderPlotly({
    return(scatter_plot(midwest, input$search, input$oof[1], input$oof[2]))
  })
})
