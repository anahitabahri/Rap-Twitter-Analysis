# load relevant libraries
# set twitter api info

library(tm)
library(twitteR)
library(devtools)
library(streamR)
library(dplyr)
library(SnowballC)

api_key <- "5njbAfOyzRT5NL4sYmWdbaMxE"
api_secret <- "wI2LwoY3YPtpiPJIseRTA9Fn9uEZDnpiUzKZBPqEsziSBzGVrP"
access_token <- "2316357445-6nXC1NSGcQamfwg7Xb4LkaEE86pdCE0dwieTczO"
access_token_secret <- "MNo28UmOMG0vuYR1AL4K5NkellgMSdm99aHj4oA0zpFeF"

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

load("my_oauth.Rdata")

##########################################################################################################

# GET TWEETS THAT MENTION BIGGIE AND 2PAC, REGARDLESS OF LOCATION INFORMATION

filterStream(file.name = "shiny_twitter_wc/biggie.json", # Save tweets in a json file
             track = c("biggie","biggiesmalls","notoriousbig"), 
             language = "en",
             timeout = 900, # Keep connection alive for 900 seconds / 15 min
             oauth = my_oauth) # Use my_oauth file as the OAuth credentials
# 161 tweets

filterStream(file.name = "shiny_twitter_wc/2pac.json", # Save tweets in a json file
             track = c("2pac","tupac"), 
             language = "en",
             timeout = 900, # Keep connection alive for 900 seconds / 15 min
             oauth = my_oauth) # Use my_oauth file as the OAuth credentials

# 376 tweets

##########################################################################################################

# GET TWEETS THAT MENTION BIGGIE OR 2PAC WITHIN THE UNITED STATES

filterStream(file.name = "map_shiny/us_tweets.json", # Save tweets in a json file
             track = c("biggie","biggiesmalls","notoriousbig","2pac","tupac"), 
             language = "en",
             location = c(-125,25,-66,50),
             timeout = 900, # Keep connection alive for 900 seconds / 15 min
             oauth = my_oauth) # Use my_oauth file as the OAuth credentials

# 37,681 tweets

##########################################################################################################

# GET TWEETS FROM J COLE AND KENDRICK LAMAR'S TIMELINE: WHAT ARE THE MOST FREQUENT HASHTAGS? 
# https://www.r-bloggers.com/using-r-to-find-obamas-most-frequent-twitter-hashtags/


# USING TWITTER PACKAGE

jcole = userTimeline("JColeNC", n = 3200) # 1060 tweets
jcole = twListToDF(jcole)
write.csv(jcole, "rapper_data/jcole_tweets.csv", row.names = FALSE)

kendrick = userTimeline("kendricklamar", n = 3200) # 133 tweets
kendrick = twListToDF(kendrick)
write.csv(kendrick, "rapper_data/kendrick_tweets.csv", row.names = FALSE)

snoopdogg = userTimeline("SnoopDogg", n = 3200) # 290 tweets
snoopdogg = twListToDF(snoopdogg)
write.csv(snoopdogg, "rapper_data/snoopdogg_tweets.csv", row.names = FALSE)

pdiddy = userTimeline("iamdiddy", n = 3200) # 100 tweets
pdiddy = twListToDF(pdiddy)
write.csv(pdiddy, "rapper_data/pdiddy_tweets.csv", row.names = FALSE)

nas = userTimeline("Nas", n = 3200) # 461 tweets
nas = twListToDF(nas)
write.csv(nas, "rapper_data/nas_tweets.csv", row.names = FALSE)

fiftycent = userTimeline("50cent", n = 3200) # 836 tweets
fiftycent = twListToDF(fiftycent)
write.csv(fiftycent, "rapper_data/50cent_tweets.csv", row.names = FALSE)

