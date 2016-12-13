library(shiny)

function(input, output) {
  output$map <- renderLeaflet({
    leaflet(us_tweets) %>% addTiles('http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png') %>% addCircles(~lon, ~lat, weight = 3, radius=40, 
                                                                                                                color="#ffa500", stroke = TRUE, fillOpacity = 0.8)
  })
}