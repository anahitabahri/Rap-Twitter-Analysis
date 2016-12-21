library(shiny)
library(leaflet)

sidebarLayout(
  # slider and selection inputs
  sliderInput(inputId = "fc","Follower Count:",
              min = 1,  max = 1000, value = 500),
  
  # show map
  mainPanel(
    leafletOutput(outputId="map")
  )
)