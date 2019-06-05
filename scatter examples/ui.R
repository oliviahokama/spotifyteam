library(shiny)
library(lintr)
library(plotly)
source("build_hist.R")
source("build_scatter.R")

shinyUI(navbarPage(
  "Midwest Dataset",
  tabPanel(
    "Scatter Plot",
    titlePanel("County Adult Poverty % vs College Educated %"),
      sidebarPanel(
        textInput("search", label = "Enter County", value = ""),
      br(),
      sliderInput("oof", label = "% of Population - College Educated",
                  min = round(education[1]),
                  max = round(education[2]),
                  value = education
                  )
      ),
    mainPanel(
      plotlyOutput("scatter"))),
      tabPanel(
        "Histogram",
        titlePanel("Comparing African-American Population % Between States"),
        sidebarPanel(
          selectInput("state1", label = "Choose a State",
                      choices = midwest$state, selected = midwest$state[1]),
          selectInput("state2", label = "Choose Another State",
                      choices = midwest$state, selected = midwest$state[2])),
      mainPanel(
        plotOutput("hist")))))