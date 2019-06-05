
library(shiny)
library(lintr)
library(plotly)
source("build_scatter2.R")

page_three <- tabPanel(
  titlePanel("Statistics for Top 10 artists in 2018"),
  sidebarLayout(
    sidebarPanel(
      textInput("search", label = "Enter Artist", value = ""),
      br(),
      sliderInput("oof", label = "Danceability",
                  min = round(top_2018$danceability[0.0]),
                  max = round(top_2018$danceability[1]),
                  value = top_2018$danceability
      )
    ),
    mainPanel(
      plotlyOutput("scatter")))
)

ui <- navbarPage(
  "Song Trends in the Past 20 Years",
  page_three
)
