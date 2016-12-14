require(tm)
require(SnowballC)
require(wordcloud)
require(stringr)
require(dplyr)
require(memoise)
library(readr)

# DEFINE CLEAN TEXT FUNCTION:
# This is the same function as twitter cleaning. 
# There are some unecessary functions included for the purposes of lyrics.

clean.text <- function(some_txt)
{
  # remove retweet entities
#  some_txt = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '', some_txt)
  # remove at people
#  some_txt = gsub('@\\w+', '', some_txt)
  # remove punctuation
#  some_txt = gsub('[[:punct:]]', '', some_txt)
  # remove numbers
#  some_txt = gsub('[[:digit:]]', '', some_txt)
  # remove html links
  some_txt = gsub('http\\w+', '', some_txt)
  some_txt = gsub("https\\w+ *", "", some_txt)
  some_txt = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", some_txt)
  # remove unnecessary spaces
  some_txt = gsub('[ \t]{2,}', '', some_txt)
  some_txt = gsub('^\\s+|\\s+$', '', some_txt)
  # megan's functions
  some_txt = gsub("[^a-zA-Z #]","",some_txt)
  some_txt = gsub("RT|via", "", some_txt)
  some_txt = gsub("@\\w+ *", "", some_txt)
  some_txt = gsub("\n", " ", some_txt)
  # other  
  some_txt = gsub("amp", "", some_txt)
  some_txt = gsub("tco\\w+ *", "", some_txt)
  # lower and trim text
#  some_txt = tolower(some_txt)
  some_txt = str_trim(some_txt, side = "both")
  # define "tolower error handling" function
#  try.tolower = function(x)
#  {
#    y = NA
#    try_error = tryCatch(tolower(x), error=function(e) e)
#    if (!inherits(try_error, "error"))
#      y = tolower(x)
#    return(y)
#  }
#  
#  some_txt = sapply(some_txt, try.tolower)
#  some_txt = some_txt[some_txt != ""]
#  names(some_txt) = NULL
#  return(some_txt)
}


##########################################################################################################

# LOAD CSV FILES & CLEAN RELEVANT COLUMN

##### 50 CENT #####
fiftycent = read.csv("50cent_tweets.csv")
fiftycent <- data.frame(fiftycent)
txt_50cent = fiftycent$text
clean_50cent = clean.text(txt_50cent)
clean_50cent <- data.frame(clean_50cent, stringsAsFactors = FALSE)
colnames(clean_50cent) <- c("text")
# clean_50cent = str_replace_all(clean_50cent$text,"[^[:graph:]]", " ")

##### J COLE #####
jcole = read.csv("jcole_tweets.csv")
jcole <- data.frame(jcole)
txt_jcole = jcole$text
clean_jcole = clean.text(txt_jcole)
clean_jcole <- data.frame(clean_jcole, stringsAsFactors = FALSE)
colnames(clean_jcole) <- c("text")
# clean_jcole = str_replace_all(clean_jcole$text,"[^[:graph:]]", " ")

##### KENDRICK LAMAR #####
kendrick = read.csv("kendrick_tweets.csv")
kendrick <- data.frame(kendrick)
txt_kendrick = kendrick$text
clean_kendrick = clean.text(txt_kendrick)
clean_kendrick <- data.frame(clean_kendrick, stringsAsFactors = FALSE)
colnames(clean_kendrick) <- c("text")
# clean_kendrick = str_replace_all(clean_kendrick$text,"[^[:graph:]]", " ")

##### NAS #####
nas = read.csv("nas_tweets.csv")
nas <- data.frame(nas)
txt_nas = nas$text
clean_nas = clean.text(txt_nas)
clean_nas <- data.frame(clean_nas, stringsAsFactors = FALSE)
colnames(clean_nas) <- c("text")
# clean_nas = str_replace_all(clean_nas$text,"[^[:graph:]]", " ")

##### P DIDDY #####
pdiddy = read.csv("pdiddy_tweets.csv")
pdiddy <- data.frame(pdiddy)
txt_pdiddy = pdiddy$text
clean_pdiddy = clean.text(txt_pdiddy)
clean_pdiddy <- data.frame(clean_pdiddy, stringsAsFactors = FALSE)
colnames(clean_pdiddy) <- c("text")
# clean_pdiddy = str_replace_all(clean_pdiddy$text,"[^[:graph:]]", " ")

##### SNOOP DOGG #####
snoopdogg = read.csv("snoopdogg_tweets.csv")
snoopdogg <- data.frame(snoopdogg)
txt_snoopdogg = snoopdogg$text
clean_snoopdogg = clean.text(txt_snoopdogg)
clean_snoopdogg <- data.frame(clean_snoopdogg, stringsAsFactors = FALSE)
colnames(clean_snoopdogg) <- c("text")
# clean_snoopdogg = str_replace_all(clean_snoopdogg$text,"[^[:graph:]]", " ")

##########################################################################################################

# create list of rapper options
rappers <<- list("J. Cole" = "J. Cole",
                 "Kendrick Lamar" = "Kendrick Lamar",
                 "Nas" = "Nas",
                 "P. Diddy" = "P. Diddy",
                 "Snoop Dogg" = "Snoop Dogg",
                 "50 Cent" = "50 Cent")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(rapper) {
  if (!(rapper %in% rappers))
    stop("Unknown rapper")
  
  text <- switch(rapper,
                 "J. Cole" = clean_jcole,
                 "Kendrick Lamar" = clean_kendrick,
                 "Nas" = clean_nas,
                 "P. Diddy" = clean_pdiddy,
                 "Snoop Dogg" = clean_snoopdogg,
                 "50 Cent" = clean_50cent)
  
  text.corpus <- Corpus(VectorSource(text))
  
  text.corpus <- tm_map(text.corpus, PlainTextDocument)
  
  text.corpus <- tm_map(text.corpus, removeWords, c("amp", "dont", "know", "hashtag","just", 
                                                    "available","posted","repost", "#repost", 
                                                    "get", "got", "cant", "check", "whos", "what",
                                                    stopwords('english')))
})
