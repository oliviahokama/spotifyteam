library("dplyr")

song_data <- read.csv("data/song_data.csv")

get_summary_table <- function(songs) {
  songs <- songs %>%
    group_by(year) %>%
    summarize(avg_danceability = mean(danceability), avg_energy = mean(energy),
              avg_speechiness = mean(speechiness), avg_acousticness =
                mean(acousticness))
  return (songs)
}

# This table is being included because of its importance in understanding
# the overall trends of music over the course of several years. By using
# yearly aggregates of a few important trends, we can hopefully deduce
# where music is going in the future, and where it used to be. For example,
# while danceability seems to have remained somewhat constant, the energy
# has interestingly went down in recent times. It also shows that
# perhaps despite the conceptions people have had about music trends,
# components of the music have actually stayed relatively consistent.