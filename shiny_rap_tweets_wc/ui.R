library(shiny)

fluidPage(
  # Application title
  titlePanel("What are rappers tweeting about?"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a Rapper:",
                  choices = rappers),
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 1),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 150)
    ),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)
