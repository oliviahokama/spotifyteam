library("shiny")
library("ggplot2")
library("lintr")

page_about <- tabPanel(
  
  titlePanel("About Us"),
  
  mainPanel(
    tags$div(class = "about",
      h1("Who We Are"),
      p("We are a small group from the University of Washington's INFO 201
        course with a passion for music. For our final project, we decided
        that it would be very interesting to see what the trends of modern
        music have been, and how things have changed. Often times, people
        say that music has evolved very rapidly in the past 20 years, and
        we wanted to see for ourselves how true this was. We found some
        initial datasets from Steve Hawting, who has amassed song databases
        featuring the most popular songs from around the world. While we
        didn't use all of his data, we recommend you check some of it out
        if you want to explore further. Furthermore, we utilized the Spotify
        API to procure information about these songs when applicable. Using
        these two in tandem, we were able to discern some fascinating information
        about the music that has become popular in the last 20 years."),
      tags$div(class = "data-link", checked = NA,
               tags$a(href = "https://chart2000.com/about.htm", "Hawting's work
                      can be found here.")),
      tags$div(class = "data-link", checked = NA,
               tags$a(href = "https://https://developer.spotify.com/documentation/web-api/",
                      "The Spotify API can be found here.")),
      h1("Why We Care"),
      p("Music is something that many people relate to. It's something
        that is shared universally across all cultures, and is a valuable
        piece of our lives that very few people live without. Music is one
        of the largest industries in the world, and it offers a means of
        communication that is otherwise hard to find. It plays a huge role
        in the lives of our team members, and we're sure it does for many
        others as well. While looking at these trends in music is interesting,
        we also think that it is important given how prevalent music has been
        throughout history, and how prevalent it will be going forward. We
        hope you think it's as interesting as we do!"),
      p("Produced by Andrew Chan, Paul Pham, Olivia Hokama, and Derek Hong")
    )
  )
)

page_one <- tabPanel(
  
  titlePanel("Song Trends by Year since 2000"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "trend",
        label = "Trend to Plot",
        choices = list("Danceability" = "Danceability", "Energy" = "Energy",
                       "Acousticness" = "Acousticness",
                       "Speechiness" = "Speechiness", "All" = "all"),
        multiple = F,
      ),
      p("This graph shows some of the popular trends among top songs from
        the past 20 years. It does not factor in songs that topped the charts
        for multiple months, and only used songs that appeared in the top
        50 internationally, as calculated by Steve Hawting. Once finding
        those songs, we used the Spotify API to find details about those
        songs, and we can hopefully start to see some trends with modern
        music. Try it yourself! Use the dropdown menu above to select for
        a trend that you would like to see, mapped over the course of 20
        years. If you'd like, select the 'all' category to see all of
        our observed trends stacked up against each other!"),
      p("Danceability - How suitable the song is for dance"),
      p("Energy - The measure of intensity and musical activity"),
      p("Acousticness - The confidence that a track is acoustic"),
      p("Speechiness - The prominence of spoken words in a song")
    ),
    
    mainPanel(
      plotOutput(outputId = "trends_plot")
    )
    
  )

)

page_two <- tabPanel(
  
  titlePanel("Correlation of Features"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "first",
        label = "First Feature",
        choices = list("Danceability" = "Danceability", "Energy" = "Energy",
                       "Acousticness" = "Acousticness",
                       "Speechiness" = "Speechiness"),
        multiple = F
      ),
      selectInput(
        inputId = "second",
        label = "Second Feature",
        choices = list("Danceability" = "Danceability", "Energy" = "Energy",
                       "Acousticness" = "Acousticness",
                       "Speechiness" = "Speechiness"),
        multiple = F
      ),
      sliderInput(
        inputId = "year",
        label = "Year (Set to 1999 for All Years)",
        min = 1999,
        max = 2019,
        value = 1999,
        step = 1,
        animate = T
      ),
      p("In this page, we wanted to look at any possible correlations between
        different features. We previously saw how certain trends rose and fall
        across the years, and we want to know if any of those changes may have
        been linked. After all, some of the features go very well together, and
        would make sense to rise and fall together. For example, danceability
        and energy would logically be linked, given dancing is an energetic
        activity. If you want to explore a little more, we've included the ability 
        to look at each individual year, in which case the points are color coded 
        by month instead of year. You can hit the play button as well to view an
        animated trends chart, which is pretty neat.")
    ),
    
    mainPanel(
      plotOutput(outputId = "scatter")
    )
  )
  
)

page_artist <- tabPanel(
  
  titlePanel("Comparing to Speechiness"),
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("chooseComparison", "Choose what to compare speechiness to based on the top songs in 2018:",
                   choices = list("Danceability" = "danceability", 
                                  "Acousticness" = "acousticness", 
                                  "Duration" = "duration_ms",
                                  "Energy" = "energy",
                                  "Tempo" = "tempo")),
      
      selectInput("chooseShape", "Choose the shape of the data points:",
                  choices = list("Square" = "15", "Circle" = "16", "Triangle" = "17")),
      p("This scatterplot visualizes how different attributes compare to speechiness
       in the top songs of 2018. Unlike the previous example, we wanted to expand on trends,
       using a dataset that holds the top 100 songs of 2018. We wanted to look at how 
       songs were related to speechiness specifically to see if we saw a 
       correlation between them, as well as two new factors. This can hopefully help us
       see if the trend has had any bearing on the music we heard last
       year. By clicking on the differnt options, try to see if 
       you see any patterns between the two variables. And, just for fun, feel
       free to change the shape of the points on the plot."),
      p("Danceability - How suitable the song is for dance"),
      p("Energy - The measure of intensity and musical activity"),
      p("Acousticness - The confidence that a track is acoustic"),
      p("Speechiness - The prominence of spoken words in a song"),
      p("Duration - The length of the song"),
      p("Tempo - The rhythm or beat measured of each song")
    ),
    
    mainPanel(
      plotOutput("scatter_plot")
    )
  )
)

conclusions <- tabPanel(
  titlePanel("Final Thoughts"),
  
  mainPanel(
    tags$div(class = "conclusions",
             h1("Some Final Thoughts"),
             p("With the use of different interactive data visualization,
               our team researched various Spotify datasets and the Spotify API.
               Here are the main takeaways we found through looking at our data
               visualizations: "),
             p("1.  There are many data points hovered around the lower end of
               the spectrum of speechiness, meaning many songs on the top 2018
               dataset, contain higher values of other characteristics rather than
               speechiness. In addition to this, we see that many songs contain
               lower values of acousticness and higher values of danceability.
               This shows that listeners are becoming less focused on the
               prominence of spoken word but rather the other qualities that
               make up a song."),
             p("2. Looking at the top trends in the past 20 years, danceability
               has been on the climb since 2015 with a rapid increase.  However,
               the energy of the top songs has recently been decreasing steadily.
               This shows that energy and danceability of a song are not
               necessarily correlated, and are not telling of what will be popular
               based on one of these attributes. Despite some connections being
               made based on the data, there simply isn't enough concrete
               evidence that there exists a strong correlation."),
             p("3. Arguably the least commonly fluctuating of song features,
               acousticness has not had a trend of increasing or decreasing over
               the past 20 years, but rather has been steady at a lower point.
               There are short spans of years where it spikes or drops in small
               amounts, but this non-erratic pattern is an indication that while
               acousticness is a trend that can help popular songs, it is less of
               an important factor. The trends in most modern popular music have steered
               away from a focus on acoustic songs, aiming for different types of
               music that have recently been pioneered."))
  )
)


ui <- navbarPage(
  theme = "styles.css",
  "Song Trends in the Past 20 Years",
  page_about,
  page_one,
  page_two,
  page_artist,
  conclusions
)
