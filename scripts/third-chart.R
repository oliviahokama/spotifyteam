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
<<<<<<< HEAD
  ggtitle("Trends in Speechiness from 2000 - 2019")
=======
  ggtitle("Trends in Speechiness from 2000 - 2019")
>>>>>>> 705e94305a1a296c4afa33d3c9dd103b831a9b50
