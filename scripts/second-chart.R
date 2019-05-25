# import libraries
library(dplyr)
library(ggplot2)

# Read in song data
songs <- read.csv("../data/song_data.csv", stringsAsFactors = F)

# Choose a feature to check against a regression, in this case
# we're looking at `danceability`
value <- "danceability"
feature <- songs[[value]]

ggplot(data = songs) +
  geom_point(mapping = aes(x = year, y = feature), color = "blue") +
  geom_smooth(mapping = aes(x = year, y = feature), color = "black") +
  xlab("Year") +
  ylab(value) +
  ggtitle("Danceability of Top 20 Songs from 2000 - 2019")
