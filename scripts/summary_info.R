library("dplyr")
library("spotifyr")
library(lubridate)

song_data <- read.csv("../data/song_data.csv", stringsAsFactors = F)

# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(dataset) {
  year_most_dancable <- song_data %>%
    mutate(year = substring(year, 1, 4)) %>%
    select(year, danceability) %>%
    group_by(year) %>%
    summarise(danceability = mean(danceability, na.rm = TRUE)) %>%
    arrange(desc(danceability)) %>%
    filter(danceability == max(danceability)) %>%
    pull(year)
 artist_most_freq <- song_data %>%
    select(year, song, artist) %>%
    group_by(artist) %>%
    summarize(num_artist = n()) %>%
    arrange(desc(num_artist)) %>%
    filter(num_artist == max(num_artist)) %>%
    pull(artist)
  lowest_energy_song <- song_data %>%
    filter(energy == min(energy, na.rm = TRUE)) %>%
    pull(song)
  highest_energy_song <- song_data %>%
    filter(energy == max(energy, na.rm = TRUE)) %>%
    pull(song)
  acoustic_years <- song_data %>%
    mutate(year = substring(year, 1, 4)) %>%
    select(year, acousticness) %>%
    group_by(year) %>%
    summarise(acousticness = mean(acousticness, na.rm = TRUE)) %>%
    arrange(desc(acousticness)) %>%
    filter(acousticness == max(acousticness)) %>%
    pull(acousticness)
  artist_most_speechiness <- song_data %>%
    select(artist, speechiness) %>%
    group_by(artist) %>%
    summarise(speechiness = max(speechiness, na.rm = TRUE)) %>%
    arrange(desc(speechiness)) %>%
    filter(speechiness == max(speechiness)) %>%
    pull(artist)
  sum_info <- list(year_most_dancable, artist_most_freq, lowest_energy_song, highest_energy_song,
                   acoustic_years, artist_most_speechiness)
} 

spotify_summary <- get_summary_info(song_data)

#DESCRIPTIONS TO EACH PART OF THE GET SUMMARY INFORMATION:

# Highest dancability in each year: descending order 
year_most_dancable <- song_data %>%
  mutate(year = substring(year, 1, 4)) %>%
  select(year, danceability) %>%
  group_by(year) %>%
  summarise(danceability = mean(danceability, na.rm = TRUE)) %>%
  arrange(desc(danceability)) %>%
  filter(danceability == max(danceability)) %>%
  pull(year)
  
# Most frequent artist (not including featured songs or collaborations) from 2000 to 2019:
artist_most_freq <- song_data %>%
  select(year, song, artist) %>%
  group_by(artist) %>%
  summarize(num_artist = n()) %>%
  arrange(desc(num_artist)) %>%
  filter(num_artist == max(num_artist)) %>%
  pull(artist)

# The song with the lowest energy: The Reason by Hoobastank
lowest_energy_song <- song_data %>%
  filter(energy == min(energy, na.rm = TRUE)) %>%
  pull(song)

# The song with the highest energy: Promiscuous by Nelly Furtado & Timbaland
highest_energy_song <- song_data %>%
  filter(energy == max(energy, na.rm = TRUE)) %>%
  pull(song)

# Mean of the acoustiness in highest year
acoustic_years <- song_data %>%
  mutate(year = substring(year, 1, 4)) %>%
  select(year, acousticness) %>%
  group_by(year) %>%
  summarise(acousticness = mean(acousticness, na.rm = TRUE)) %>%
  arrange(desc(acousticness)) %>%
  filter(acousticness == max(acousticness)) %>%
  pull(acousticness)

# The artist with the highest speechiness: 
artist_most_speechiness <- song_data %>%
  select(artist, speechiness) %>%
  group_by(artist) %>%
  summarise(speechiness = max(speechiness, na.rm = TRUE)) %>%
  arrange(desc(speechiness)) %>%
  filter(speechiness == max(speechiness)) %>%
  pull(artist)







