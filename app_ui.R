library("shiny")
library("ggplot2")
library("lintr")

page_one <- tabPanel(
  
  titlePanel("Song Trends by Year since 2000"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "trend",
        label = "Trend to Plot",
        choices = list("Danceability" = "Danceability", "Energy" = "Energy",
                       "Acousticness" = "Acousticness",
                       "Speechiness" = "Speechiness", "All" = "all"),
        multiple = F,
      )
    ),
    
    mainPanel(
      plotOutput(outputId = "trends_plot")
    )
    
  )
  
)

ui <- navbarPage(
  "Song Trends in the Past 20 Years",
  page_one
)