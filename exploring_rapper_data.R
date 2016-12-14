library(readr)
library(dplyr)
library(ggplot2)

# read in data, convert to df
jcole = read.csv("rapper_data/jcole_tweets.csv")
jcole <- data.frame(jcole)

kendrick = read.csv("rapper_data/kendrick_tweets.csv")
kendrick <- data.frame(kendrick)

snoopdogg = read.csv("rapper_data/snoopdogg_tweets.csv")
snoopdogg <- data.frame(snoopdogg)

pdiddy = read.csv("rapper_data/pdiddy_tweets.csv")
pdiddy <- data.frame(pdiddy)

nas = read.csv("rapper_data/nas_tweets.csv")
nas <- data.frame(nas)

fiftycent = read.csv("rapper_data/50cent_tweets.csv")
fiftycent <- data.frame(fiftycent)

##########################################################################################################

# create a function to extract hashtags
extract.hashes = function(vec){
  
  hash.pattern = "#[[:alpha:]]+"
  have.hash = grep(x = vec, pattern = hash.pattern)
  
  hash.matches = gregexpr(pattern = hash.pattern,
                          text = vec[have.hash])
  extracted.hash = regmatches(x = vec[have.hash], m = hash.matches)
  
  df = data.frame(table(tolower(unlist(extracted.hash))))
  colnames(df) = c("tag","freq")
  df = df[order(df$freq,decreasing = TRUE),]
  return(df)
}

##########################################################################################################

# manipulating each df to get top 5 hastags (get warnings for few dfs, but no problem)

######## J COLE ######## 

vec_jcole = jcole$text
dat_jcole = head(extract.hashes(vec_jcole),50)
dat_jcole = transform(dat_jcole,tag = reorder(tag,freq))

######## KENDRICK LAMAR ######## 

vec_kendrick = kendrick$text
dat_kendrick = head(extract.hashes(vec_kendrick),50)
dat_kendrick = transform(dat_kendrick,tag = reorder(tag,freq))

######## SNOOP DOGG ######## 

vec_snoopdogg = snoopdogg$text
dat_snoopdogg = head(extract.hashes(vec_snoopdogg),50)
dat_snoopdogg = transform(dat_snoopdogg,tag = reorder(tag,freq))

######## P DIDDY ######## 

vec_pdiddy = pdiddy$text
dat_pdiddy = head(extract.hashes(vec_pdiddy),50)
dat_pdiddy = transform(dat_pdiddy,tag = reorder(tag,freq))

######## NAS ######## 

vec_nas = nas$text
dat_nas = head(extract.hashes(vec_nas),50)
dat_nas = transform(dat_nas,tag = reorder(tag,freq))

######## 50 CENT ######## 

vec_50cent = fiftycent$text
dat_50cent = head(extract.hashes(vec_50cent),50)
dat_50cent = transform(dat_50cent,tag = reorder(tag,freq))

##########################################################################################################

# PLOTTING THE TOP 5 HASHTAGS

######## J COLE ######## 

ggplot(dat_jcole[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500")+
  ggtitle("J. Cole: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/JCole.png", width = 4.46, height=3.075)

######## KENDRICK LAMAR ######## 

ggplot(dat_kendrick[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500") +
  ggtitle("Kendrick Lamar: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/Kendrick.png", width = 4.46, height=3.075)

######## SNOOP DOGG ######## 

ggplot(dat_snoopdogg[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500") +
  ggtitle("Snoop Dogg: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/SnoopDogg.png", width = 4.46, height=3.075)

######## P DIDDY ######## 

ggplot(dat_pdiddy[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500") +
  ggtitle("P. Diddy: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/PDiddy.png", width = 4.46, height=3.075)

######## NAS ######## 

ggplot(dat_nas[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500") +
  ggtitle("Nas: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/Nas.png", width = 4.46, height=3.075)

######## 50 CENT ######## 

ggplot(dat_50cent[1:5, ], aes(x = tag, y = freq)) + geom_bar(stat = "identity", color = "#ffa500", fill = "#ffa500") +
  ggtitle("50 Cent: Top 5 Hashtags") +
  labs(y = "Frequency", x = "Hashtag") + coord_flip()
# ggsave("hashtag_charts/50Cent.png", width = 4.46, height=3.075)
