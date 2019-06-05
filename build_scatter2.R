library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)
library(lintr)

top_2018 <- read.csv("data/top2018.csv", stringsAsFactors = F)

scatter_plot <- function(data,
                         search = "",
                         xvar = "danceability",
                         yvar = "duration_ms") {
  data <- data %>%
    filter(
      grepl(toupper(search), data$top_2018),
      duration_ms > min,
      duration_ms < max
    )
  
  plot_ly(data = data,
          x = ~danceability,
          y = ~duration_ms,
          mode = "markers",
          color = ~artists,
          text = ~name,
          marker = list(
            opacity = 0.5,
            size = 11
          ),
          type = "scatter"
  ) %>%
    
    layout(yaxis = list(
      range = c(0, ymax), title = "Top 2018 Statistics"),
      xaxis = list(range = c(0, xmax), title = "Duration of songs vs. danceability")
    )
}

