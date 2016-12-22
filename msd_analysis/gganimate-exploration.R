library(readr)
library(dplyr)

# read data
song_data <- read_csv('song_data.csv')
song_data <- data.frame(song_data)

# look at just rap vs. country
rap_country = song_data %>% filter(genre %in% c("Rap","Country"), year > 1999)

library(ggplot2)
library(gganimate)

# animate rap vs country
p <- ggplot(rap_country, aes(artist_familiarity, artist_hotttnesss, color = genre, frame = year)) +
  geom_point() + labs(y = "Hotttnesss", x = "Familiarity")

gganimate(p, "rap_country.gif")

# frame = genre instead
p <- ggplot(rap_country, aes(artist_familiarity, artist_hotttnesss, color = genre, frame = genre)) +
  geom_point() + labs(y = "Hotttnesss", x = "Familiarity")

gganimate(p, "rap_country_2.gif")


# how about just rap?
rap = rap_country %>% filter(genre == 'Rap',year > 1994)

p <- ggplot(rap, aes(artist_familiarity, artist_hotttnesss, frame = year)) +
  geom_point() + labs(y = "Hotttnesss", x = "Familiarity")

gganimate(p, "rap.gif")
