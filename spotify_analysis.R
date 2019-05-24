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
