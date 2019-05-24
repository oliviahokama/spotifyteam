library("httr")

URI <- "https://api.musixmatch.com/ws/1.1/"
endpoint <- "/chart.tracks.get"
request <- paste0(URI, endpoint)
response <- GET(request)
