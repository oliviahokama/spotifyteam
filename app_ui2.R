
library(shiny)
library(lintr)
library(plotly)

# page_three <- tabPanel(
#   titlePanel("Statistics for artists in 2018"),
#   sidebarLayout(
#     sidebarPanel(
#       textInput("search", label = "Enter Artist", value = ""),
#       br()
#     ),
#     mainPanel(
#       plotlyOutput("scatter")))
# )
# 
# ui <- navbarPage(
#   "Artist comparisons in 2018",
#   page_three
# )


page_artist <- tabPanel(
  
  titlePanel("Artist Information"),
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("chooseComparison", "Choose what information you would like to see:",
                   choices = list("Danceability" = "danceability", "Acousticness" = "acousticness", "Duration" = "duration_ms")),
      
      selectInput("chooseShape", "Choose the shape of the data points:",
                  choices = list("Square" = "15", "Circle" = "16", "Triangle" = "17")) 
    ),
    
    mainPanel(
      plotOutput("scatter")
    )
  )
)

ui <- navbarPage(
  "Artists in 2018",
  page_artist
)

