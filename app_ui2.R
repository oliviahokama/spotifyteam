
library(shiny)
library(lintr)
library(plotly)

page_artist <- tabPanel(
  
  titlePanel("Speechiness comparisons"),
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("chooseComparison", "Choose what to compare speechiness to based on the top songs in 2018:",
                   choices = list("Danceability" = "danceability", 
                                  "Acousticness" = "acousticness", 
                                  "Duration" = "duration_ms",
                                  "Energy" = "energy",
                                  "Tempo" = "tempo")),
      
      selectInput("chooseShape", "Choose the shape of the data points:",
                  choices = list("Square" = "15", "Circle" = "16", "Triangle" = "17")),
      p("This scatterplot visualizes how different attributes compare to speechiness
       in the top songs of 2018. Unlike the previous example, we wanted to expand on trends,
       using a dataset that holds the top 100 songs of 2018. We wanted to look at how 
       songs were related to speechiness specifically to see if we saw a 
       correlation between them, as well as two new factors. This can hopefully help us
       see if the trend has had any bearing on the music we heard last
       year. By clicking on the differnt options, try to see if 
       you see any patterns between the two variables."),
      p("Danceability - How suitable the song is for dance"),
      p("Energy - The measure of intensity and musical activity"),
      p("Acousticness - The confidence that a track is acoustic"),
      p("Speechiness - The prominence of spoken words in a song"),
      p("Duration - The length of the song"),
      p("Tempo - The rhythm or beat measured of each song")
    ),
    
    mainPanel(
      plotOutput("scatter")
    )
  )
)

ui <- navbarPage(
  "Songs in 2018: Speechiness Analysis",
  page_artist
)

