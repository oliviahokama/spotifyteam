library("shiny")
library("ggplot2")
library("lintr")
library("reshape")
library("dplyr")

songs <- read.csv("data/song_data.csv", stringsAsFactors = F)
weighted_songs <- read.csv("data/weighted_song_data.csv", stringsAsFactors = F)

songs <- songs %>%
  group_by(year) %>%
  summarize(Speechiness = mean(speechiness),
            Energy = mean(energy),
            Danceability = mean(danceability),
            Acousticness = mean(acousticness))

weighted_songs <- weighted_songs %>% 
  mutate(Speechiness = speechiness,
         Energy = energy,
         Danceability = danceability,
         Acousticness = acousticness) %>% 
  select(year, Speechiness, Energy, Danceability, Acousticness, month)

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
  output$scatter <- renderPlot({
    if (input$year == 1999) {
      ggplot(data = weighted_songs) +
      geom_point(weighted_songs,
                 mapping = aes(x = weighted_songs[[input$first]],
                               y = weighted_songs[[input$second]],
                               color = factor(year))) +
        geom_smooth(mapping = aes(x = weighted_songs[[input$first]],
                    y = weighted_songs[[input$second]])) +
        labs (
          x = input$first,
          y = input$second,
          title = paste0("Comparing ", input$first, " to ", input$second,
                         " for the Past 20 Years")
        )
    } else {
      
      year_data <- weighted_songs %>% 
        filter(year == input$year)
      
      ggplot(data = year_data) +
        geom_point(year_data,
                   mapping = aes(x = year_data[[input$first]],
                                 y = year_data[[input$second]],
                                 color = factor(month))) +
        geom_smooth(mapping = aes(x = year_data[[input$first]],
                    y = year_data[[input$second]])) +
        labs (
          x = input$first,
          y = input$second,
          title = paste0("Comparing ", input$first, " to ", input$second,
                         " in ", input$year)
        )
    }
  })
}
