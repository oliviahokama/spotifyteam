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


ui <- navbarPage(
  theme = "styles.css",
  "Song Trends in the Past 20 Years",
  page_about,
  page_one
)