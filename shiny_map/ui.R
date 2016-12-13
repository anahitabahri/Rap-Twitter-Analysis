library(shiny)
library(leaflet)

sidebarLayout(
  # Sidebar with a slider and selection inputs
  sidebarPanel(sliderInput("followers_count",
                           "Follower Count:",
                           min = 1,  max = 1000, value = 500)),
  
  # Show Word Cloud
  mainPanel(
    leafletOutput(outputId="map")
  )
)