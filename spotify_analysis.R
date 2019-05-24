library("httr")
library("dplyr")
library("spotifyr")

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

URI <- "https://api.spotify.com/v1"
endpoint <- "/search"
request <- paste0(URI, endpoint)
params <- list("Authorization" = "d5c0d172605d428b9718156bd6fb164c",
               "q" = "Despacito", "type" = "track")
response <- GET(request, query = params)

Sys.setenv(SPOTIFY_CLIENT_ID = 'd5c0d172605d428b9718156bd6fb164c')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '006a1517c2284a20bdc64547de50e799')

access_token <- get_spotify_access_token()

library(spotifyr)
beatles <- get_artist_audio_features('the beatles')
features <- search_spotify("Smooth", type = c("track"), limit = 1)

library(knitr)
library(lubridate)
library(ggplot2)

#song_ids <- c()

#for (song in top_100_year$song) {
#  id <- search_spotify(song, type = "track", limit = 1)
#  song_ids <- append(song_ids, id$id)
#}

searchify <- function(song) {
  search_spotify(song, "track", limit = 1)
}

test <- lapply(top_100_year$song, searchify)

top_100_year$data <- test

top_100_year <- top_100_year %>% 
  mutate(id = data$id)

#get_my_top_artists_or_tracks(type = 'artists', time_range = 'short_term', limit = 5) %>% 
 # select(name, genres) %>% 
  #rowwise %>% 
  #mutate(genres = paste(genres, collapse = ', ')) %>% 
  #ungroup %>% 
  #kable()

#my_id <- 'ohokama'
#my_plists <- get_user_playlists(my_id)


#my_plists2 <- my_plists %>%
 # filter(name %in% c('Taiwan Top 50', 'France Top 50', 'Bolivia Top 50', 'U.S. Top 50'))

