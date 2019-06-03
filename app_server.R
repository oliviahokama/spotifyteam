library("shiny")
library("ggplot2")
library("lintr")
library("reshape")

songs <- read.csv("data/song_data.csv", stringsAsFactors = F)

songs <- songs %>%
  group_by(year) %>%
  summarize(Speechiness = mean(speechiness),
            Energy = mean(energy),
            Danceability = mean(danceability),
            Acousticness = mean(acousticness))

server <- function(input, output) {
  output$trends_plot <- renderPlot({
    if (input$trend == "all") {
      
      avg_stats_per_year <- reshape2::melt(songs, id.var = "year")
      
      ggplot(data = avg_stats_per_year) +
        geom_line(mapping = aes(x = year, y = value, col = variable)) +
        labs(
          x = "Year",
          y = "Trend Value",
          title = "Trends of Popular Song Features from 2000 to 2019"
        )
    } else {
      ggplot(data = songs) +
        geom_line(mapping = aes(x = year, y = songs[[input$trend]])) +
        labs(
          x = "Year",
          y = paste0(input$trend, " Value"),
          title = paste0("Trend of ", input$trend, " from 2000 to 2019")
        )
    }
  })
}
