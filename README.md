# MA 615 Final Project
## Analysis of Rappers Using Twitter & Million Song Data
### Anahita Bahri

![2pac & biggie](http://thinkingsidewayspodcast.com/wp-content/uploads/2015/04/tupac-and-biggie.jpg)

As a super fan of hip-hop and rap, I decided to embark on a study of tweets revolving around these genres, focusing on a few rappers. This project stems from my work with the [Million Song Dataset](https://github.com/anahitabahri/Million-Song-Project), for which the slides can be found [here](https://docs.google.com/presentation/d/13tOvAZHGCCmxWPWQydHQgfHqdQbYAEYmDfxn_jmuroo/edit?usp=sharing). 

I wanted to focus on the rivalry between the late 2Pac and Biggie, but decided to bring in data for rappers who were either heavily influenced by the 2 rappers or considered associated acts. These rappers include 50 Cent, J. Cole, Kendrick Lamar, Nas, P. Diddy, and Snoop Dogg.

## How to navigate this repo

Interested in learning about how I got twitter data? My [get_tweets](https://github.com/anahitabahri/Rap-Twitter-Analysis/blob/master/get_tweets.R) script will guide you through the process of using the twitteR and streamR packages.

How about mapping the us_tweets file in the get_tweets script? Refer to my [mapping_us_tweets](https://github.com/anahitabahri/Rap-Twitter-Analysis/blob/master/mapping_us_tweets.R) script. I used the leaflet package to create a simple map of where the tweets were tweeted from. I wanted to add further functionality to this using shiny, but have stayed unsuccessful for now. The [shiny_map](https://github.com/anahitabahri/Rap-Twitter-Analysis/tree/master/shiny_map) folder will be updated when I've fixed the code.

Exploring tweets mentioning biggie vs. 2pac through a shiny app can be found in the [shiny_twitter_wc](https://github.com/anahitabahri/Rap-Twitter-Analysis/tree/master/shiny_twitter_wc) folder. The wordclouds created here didn't tell a very meaningful story. A better next step was to look into how lyrics differed between the 2 rappers. This shiny app can be found in the [shiny_lyrics_wc](https://github.com/anahitabahri/Rap-Twitter-Analysis/tree/master/shiny_lyrics_wc) folder. The lyrics data comes from the million song dataset. 

The [exploring_rapper_data](https://github.com/anahitabahri/Rap-Twitter-Analysis/blob/master/exploring_rapper_data.R) script includes code that extracts the most common hashtags used by those rappers that were either heavily influenced by 2Pac and/or Biggie or were considered associated acts. The charts can be found in the [hashtag_charts](https://github.com/anahitabahri/Rap-Twitter-Analysis/tree/master/hashtag_charts) folder, but are also displayed below.

### 50 Cent
![50 Cent](hashtag_charts/50Cent.png | | height = 100px)

### J. Cole
![J. Cole](hashtag_charts/JCole.png)

### Kendrick Lamar
![Kendrick Lamar](hashtag_charts/Kendrick.png)

### Nas
![Nas](hashtag_charts/Nas.png)

### P. Diddy
![P. Diddy](hashtag_charts/PDiddy.png)

### Snoop Dogg
![Snoop Dogg](hashtag_charts/SnoopDogg.png)

