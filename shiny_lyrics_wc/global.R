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

# LOAD TEXT FILES
lyrics_biggie = scan(file = "biggie.txt", what = 'list')
lyrics_2pac = scan(file = "2pac.txt", what = 'list')

# CLEAN TEXT
clean_biggie = clean.text(lyrics_biggie)
clean_2pac = clean.text(lyrics_2pac)

##########################################################################################################

# create list of rapper options
rappers <<- list("Biggie" = "biggie.lyrics",
                 "2Pac" = "2pac.lyrics")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(rapper) {
  if (!(rapper %in% rappers))
    stop("Unknown rapper")
  
  text <- switch(rapper,
                 "biggie.lyrics" = clean_biggie,
                 "2pac.lyrics" = clean_2pac)
  
  text.corpus <- Corpus(VectorSource(text))
  
  text.corpus <- tm_map(text.corpus, PlainTextDocument)
  
  text.corpus <- tm_map(text.corpus, removeWords, c("amp", "dont", "know", stopwords('english')))
})
