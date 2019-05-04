# spotifyteam
Our team chose to work with Spotify, and more specifically music in general, as our area of interest.
For many of us, music represents a constant and consistent source of enjoyment, and provides
a much needed accompaniment to many parts of our lives. We chose this domain not only because we
love music, but also because we believe that music can show us interesting trends across
generations and allow us to better understand the preferences of the general population.

[This interesting article](https://medium.com/artists-and-machine-intelligence/neural-nets-for-generating-music-f46dffac21c0) 
documents the recent progress of trying to use a neural network to compose music. It's fascinating
because we don't often think of music as something that can be fabricated down to an algorithm, and
yet that's exactly what is happening here. 
[This article](https://www.nytimes.com/interactive/2017/08/07/upshot/music-fandom-maps.html) maps
out 50 different artists from the top 100, and then plots their popularity and density in the US. It
is similar to what we want to look at, and also shows how there are indeed trends relating the
musical preference and location (at least in the US). 
[This last article](https://www.nytimes.com/interactive/2018/08/09/opinion/do-songs-of-the-summer-sound-the-same.html) 
attempts to see why music produced in the summer always seems to sound the same. It, once again, fits
this idea of music being formulaic and how trends have started solidifying themselves across
generations.

While there are several different questions we think we could answer, we had a few specifically
we wanted to focus on. First, what are the identifiable trends of genre popularity across generations?
Second, are there any identifiable factors that lead to a genre becoming popular? Lastly, is there
any variation of how different genres become popular within a year (seasonal)?

The first (and largest) dataset we found initially is a compilation of every Billboard weekly 
hot 100 song since 1958, and up to 2018. The dataset was downloaded [here](https://data.world/kcmillersean/billboard-hot-100-1958-2017). The data was collected via the
public data found on the Billboard website and compiled by Sean Miller. It has a whopping
315296 rows, each with 10 features. This dataset can be used to answer what kinds of songs
have been popular for the past 60 years, while also showing their detailed weekly position.

The second dataset was compiled by Steve Hawting, taking data from a variety of sources. The
dataset can be found [here](https://chart2000.com/about.htm), as well as additional information
about how the data was compiled and sorted. It also includes additional datasets which we could use
in the future for further analysis. This dataset has 11551 observations, with 11 features. It is a
compilation of the 50 most popular songs of the month for every month from 2000 to 2019. It also shows
popularity of the song in different countries. This dataset should allow us to have a better idea of
where music becomes popular, and how genre correlates to each of the countries included in the set.
Furthermore, it calculates scores monthly, so it should also allow us to see seasonal trends.

The third dataset we decided to look at was a compiled list of the Rolling Stones Top 500
Albums of all time, which can be downloaded [here](https://data.world/notgibs/rolling-stones-top-500-albums/workspace/file?filename=albumlist.csv).
This dataset is a bit smaller, with only 500 observations and 6 features. It was compiled using 
the Rolling Stones website, and includes the year of the album, as well the genre of the album. 
While this may be a bit less useful at first glance, as we cannot see how popular each album was at
the time, it does allow for us to possibly see if there is any sort of relationship between its status
as a "top 500 album of all time" and its popularity at the time of its relases (which we can find using other datasets). 