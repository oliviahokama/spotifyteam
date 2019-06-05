library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
source("build_scatter2.r")

shinyServer(function(input, output) { 
  output$scatter <- renderPlotly({
    return(scatter_plot(top_2018, input$search, input$oof[1], input$oof[2]))
  })
})
