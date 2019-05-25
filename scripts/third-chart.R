# import libraries
library(dplyr)
library(ggplot2)

# Read in song data
songs <- read.csv("../data/song_data.csv", stringsAsFactors = F)

value <- "speechiness"
feature <- songs[[value]]

speechiness_trends <- ggplot(songs) +
  geom_col(mapping = aes(x = year, y = feature), fill = "blue") +
  xlab("Year") +
  ylab(value) +
  ggtitle("Trends in Speechiness from 2000 - 2019")
