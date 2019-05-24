library("httr")
library("dplyr")
library("spotifyr")
library(knitr)
library(lubridate)
library(ggplot2)

songs <- read.csv("./data/chart2000-songmonth-0-3-0050.csv",
                  stringsAsFactors = F)
songs <- songs %>% 
  mutate(year = substr(month, 5, 8)) %>% 
  mutate(month = substr(month, 1, 3))

top_songs_by_year <- songs %>% 
  select(song, artist, year) %>% 
  distinct()

top_songs_by_month <- songs %>% 
  select(song, artist, month, year, score)

top_5_month <- top_songs_by_month %>% 
  filter(year == "2018") %>% 
  group_by(month) %>% 
  top_n(., 5, score)

top_100_year <- top_songs_by_month %>%
  group_by(year) %>% 
  top_n(., 50, score) %>% 
  ungroup(year) %>% 
  select(year, artist, song) %>%
  distinct()

Sys.setenv(SPOTIFY_CLIENT_ID = 'd5c0d172605d428b9718156bd6fb164c')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '006a1517c2284a20bdc64547de50e799')

access_token <- get_spotify_access_token()

searchify <- function(song) {
  search_spotify(song, "track", limit = 1)
}

test <- lapply(top_100_year$song, searchify)

top_100_year$data <- test

top_100_year <- top_100_year %>% 
  filter(song != "Lady Marmalade (Voulez-Vous Coucher Aver Moi Ce Soir?)") %>% 
  filter(song != "Moves Like Jagger")


ids <- c()
for (tibble in top_100_year$data) {
  ids <- append(ids, tibble$id)
}

top_100_year$id <- ids

song_info <- lapply(top_100_year$id, get_track_audio_features)

danceability <- c()
energy <- c()
speechiness <- c()
acousticness <- c()
for (tibble in song_info) {
  danceability <- append(danceability, tibble$danceability)
  energy <- append(energy, tibble$energy)
  speechiness <- append(speechiness, tibble$speechiness)
  acousticness <- append(acousticness, tibble$acousticness)
}

top_100_year$danceability <- danceability
top_100_year$energy <- energy
top_100_year$speechiness <- speechiness
top_100_year$acousticness <- acousticness

# THIS IS THE DATASET WE WANT TO USE
song_data <- top_100_year %>% 
  select(year, song, artist, speechiness, energy, danceability, acousticness)

song_data <- read.csv("spotifyteam/data/song_data.csv", stringsAsFactors = F)

# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(dataset) {
  year_most_dancable <- dataset %>%
    mutate(year = substring(year, 1, 4)) %>%
    select(year, danceability) %>%
    group_by(year) %>%
    summarise(danceability = mean(danceability, na.rm = TRUE)) %>%
    arrange(desc(danceability))
  artist_most_freq <- dataset %>%
    select(year, song, artist) %>%
    group_by(artist) %>%
    summarize(num_artist = n()) %>%
    arrange(desc(num_artist))
  lowest_energy_song <- dataset %>%
    filter(energy == min(energy, na.rm = TRUE)) %>%
    select(year, song, artist, energy)
  highest_energy_song <- song_data %>%
    filter(energy == max(energy, na.rm = TRUE)) %>%
    select(year, song, artist, energy)
  acoustic_years <- dataset %>%
    mutate(year = substring(year, 1, 4)) %>%
    select(year, acousticness) %>%
    group_by(year) %>%
    summarise(acousticness = mean(acousticness, na.rm = TRUE)) %>%
    arrange(desc(acousticness))
  artist_most_speechiness <- dataset %>%
    select(artist, speechiness) %>%
    group_by(artist) %>%
    summarise(speechiness = max(speechiness, na.rm = TRUE)) %>%
    arrange(desc(speechiness))
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
  filter(danceability == max(danceability))
  
# Most frequent artist (not including featured songs or collaborations) from 2000 to 2019:
artist_most_freq <- song_data %>%
  select(year, song, artist) %>%
  group_by(artist) %>%
  summarize(num_artist = n()) %>%
  arrange(desc(num_artist))

# The song with the lowest energy: The Reason by Hoobastank
lowest_energy_song <- song_data %>%
  filter(energy == min(energy, na.rm = TRUE)) %>%
  select(year, song, artist, energy)

# The song with the highest energy: Promiscuous by Nelly Furtado & Timbaland
highest_energy_song <- song_data %>%
  filter(energy == max(energy, na.rm = TRUE)) %>%
  select(year, song, artist, energy)

# Mean of the acoustiness in each year: descending order:
acoustic_years <- song_data %>%
  mutate(year = substring(year, 1, 4)) %>%
  select(year, acousticness) %>%
  group_by(year) %>%
  summarise(acousticness = mean(acousticness, na.rm = TRUE)) %>%
  arrange(desc(acousticness))

# The artists with the highest speechiness: 
artist_most_speechiness <- song_data %>%
  select(artist, speechiness) %>%
  group_by(artist) %>%
  summarise(speechiness = max(speechiness, na.rm = TRUE)) %>%
  arrange(desc(speechiness))








