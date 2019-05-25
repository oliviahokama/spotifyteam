# import libraries
library(dplyr)
library(ggplot2)
library(reshape)

# Read in song data
songs <- read.csv("data/song_data.csv", stringsAsFactors = F)

avg_stats_per_year <- songs %>%
  group_by(year) %>%
  summarize(avg_speechiness = mean(speechiness),
            avg_energy = mean(energy),
            avg_danceability = mean(danceability),
            avg_acousticness = mean(acousticness))

avg_stats_per_year <- reshape2::melt(avg_stats_per_year, id.var = "year")

# Create visualization
song_trends <- ggplot(data = avg_stats_per_year) +
  geom_line(mapping = aes(x = year, y = value, col = variable)) +
  xlab("Year") +
  ylab("Feature Value") +
  ggtitle("Trends of Song Features over time (2000 - 2019)")