library("shiny")
library("ggplot2")
library("lintr")
library("reshape")
library("dplyr")

songs <- read.csv("data/song_data.csv", stringsAsFactors = F)
weighted_songs <- read.csv("data/weighted_song_data.csv", stringsAsFactors = F)
top_2018 <- read.csv("data/top2018.csv", stringsAsFactors = F)
complete_songs <- songs

complete_songs <- complete_songs %>%
  group_by(year) %>%
  top_n(10, X)

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

build_bar <- function(data, time, feature) {
  data <- data %>%
  group_by(year) %>%
  filter(year == as.numeric(time))
  print(as.numeric(time))

  ggplot(data = data) +
    geom_bar(mapping = aes(x = data$song, y = data[[feature]]), fill = "#1ed760",
             stat = "identity") +
    labs(title = paste0(feature, " of Songs From ", time), y = feature, x = "Songs") +
    theme(axis.text.x = element_text(angle = -70, hjust = 0))
}

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
  output$scatter_plot <- renderPlot({
    ggplot(data = top_2018) + geom_point(aes_string(x = "speechiness", y = input$chooseComparison), shape = strtoi(input$chooseShape)) + 
      ggtitle(paste("Speechiness vs.", input$chooseComparison))
  })
  
  output$bar_plot <- renderPlot({
    return(build_bar(complete_songs, input$time, input$feature))
  })
}
