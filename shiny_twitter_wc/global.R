require(tm)
require(SnowballC)
require(wordcloud)
require(streamR)
require(stringr)
require(dplyr)
require(memoise)

library(twitteR)

# DEFINE CLEAN TEXT FUNCTION:
# The function will remove Twitter handles, hashtags, special characters, URLs, etc. 

clean.text <- function(some_txt)
{
  some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
  some_txt = gsub("@\\w+", "", some_txt)
  some_txt = gsub("[[:punct:]]", "", some_txt)
  some_txt = gsub("[[:digit:]]", "", some_txt)
  some_txt = gsub("http\\w+", "", some_txt)
  some_txt = gsub("[ \t]{2,}", "", some_txt)
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  some_txt = gsub("amp", "", some_txt)
  # define "tolower error handling" function
  try.tolower = function(x)
  {
    y = NA
    try_error = tryCatch(tolower(x), error=function(e) e)
    if (!inherits(try_error, "error"))
      y = tolower(x)
    return(y)
  }
  
  some_txt = sapply(some_txt, try.tolower)
  some_txt = some_txt[some_txt != ""]
  names(some_txt) = NULL
  return(some_txt)
}


##########################################################################################################

# PARSE TWEETS FROM JSON FILES

tweets.biggie <- parseTweets("biggie.json") # 50 tweets
tweets.2pac <- parseTweets("2pac.json") # 216 tweets

# GET TEXT
txt_biggie = tweets.biggie$text
txt_2pac = tweets.2pac$text

# CLEAN TEXT
clean_biggie = clean.text(txt_biggie)
clean_2pac = clean.text(txt_2pac)

# CONVERT TO DF
clean_biggie <- data.frame(clean_biggie, stringsAsFactors = FALSE)
clean_2pac <- data.frame(clean_2pac, stringsAsFactors = FALSE)

# NAME COLUMN AS TEXT
colnames(clean_biggie) <- c("text")
colnames(clean_2pac) <- c("text")


##########################################################################################################

# create list of rapper options
rappers <<- list("Biggie Tweets" = "biggie.tweets",
                 "2Pac Tweets" = "2pac.tweets")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(rapper) {
  if (!(rapper %in% rappers))
    stop("Unknown rapper")
  
  text <- switch(rapper,
                 "biggie.tweets" = clean_biggie,
                 "2pac.tweets" = clean_2pac)
  
  text.corpus <- Corpus(VectorSource(text))
  
  text.corpus <- tm_map(text.corpus, PlainTextDocument)
  
  text.corpus <- tm_map(text.corpus, removeWords, c("amp", stopwords('english')))
})
