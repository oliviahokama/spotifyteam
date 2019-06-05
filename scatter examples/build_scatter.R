library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)
library(lintr)

education <- range(midwest$percollege)

scatter_plot <- function(data,
    search = "",
    min,
    max,
    xvar = "percadultpoverty",
    yvar = "percollege") {
  xmax <- max(data[, xvar])
  ymax <- max(data[, yvar])
  
  data <- data %>%
    filter(
      grepl(toupper(search), data$county),
      percollege > min,
      percollege < max
    )

   plot_ly(data = data,
    x = ~percadultpoverty,
    y = ~percollege,
    mode = "markers",
    color = ~state,
    text = ~county,
    marker = list(
      opacity = 0.5,
      size = 11
    ),
    type = "scatter"
  ) %>%

    layout(yaxis = list(
        range = c(0, ymax), title = "% of Population - College Educated"),
      xaxis = list(range = c(0, xmax), title = "% of Adults in Poverty")
    )
}

