library(dplyr)
library(readr)
library(leaflet)
library(rgdal)
library(twitteR)
library(streamR)
library(rgdal)

# parse us_tweets.json file
us_tweets <- parseTweets("data/json_files/us_tweets.json") # 46,567 tweets

# select some columns
us_tweets.df2 = us_tweets %>% select(text, retweet_count, favorited, retweeted, created_at, verified,
                                                 location, description, user_created_at, statuses_count, followers_count,
                                                 favourites_count, name, time_zone, friends_count, place_lat, place_lon)

# rename columns to lon / lat
us_tweets.df2 <- rename(us_tweets.df2, lon = place_lon, lat = place_lat)

# remove na values for lon/lat coordinates
us_tweets.df3 <- us_tweets.df2[complete.cases(us_tweets.df2$lon),]

# export csv, so we don't have to keep parsing through json file
write.csv(us_tweets.df3, "data/csv_files/us_tweets.csv", row.names = FALSE)

# plot map with leaflet
m <- leaflet(us_tweets.df3) %>% addTiles('http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', 
                              attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') 
m %>% setView(-100.044345, 41.314352, zoom = 4)
m %>% addCircles(~lon, ~lat, popup=us_tweets.df3$lon, weight = 3, radius=40, 
                 color="#ffa500", stroke = TRUE, fillOpacity = 0.8) 


# read csv, instead of parsing json file
us_tweets.df3 <- read_csv('data/csv_files/us_tweets.csv')
us_tweets.df3 <- data.frame(us_tweets.df3)

# get simple stats for follower count, which will be filter for shiny app
min(us_tweets.df3$followers_count) # 0
mean(us_tweets.df3$followers_count) # 2137 
median(us_tweets.df3$followers_count) # 576
max(us_tweets.df3$followers_count) # 3,697,255