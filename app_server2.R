library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)

top_2018 <- read.csv("data/top2018.csv", stringsAsFactors = F)

server <- function(input, output) {
  output$scatter <- renderPlot({
    ggplot(data = top_2018) + geom_point(aes_string(x = "speechiness", y = input$chooseComparison), shape = strtoi(input$chooseShape)) + 
      ggtitle(paste("Speechiness vs.", input$chooseComparison))
  })
}
