# import libraries
library(dplyr)
library(ggplot2)

# Read in song data
songs <- read.csv("../data/song_data.csv", stringsAsFactors = F)

avg_stats_per_year <- songs %>%
  group_by(year) %>%
  summarize(avg_speechiness = mean(speechiness),
            avg_energy = mean(energy),
            avg_danceability = mean(danceability),
            avg_acousticness = mean(acousticness))

# Create visualization
ggplot(avg_stats_per_year)