# server.R
library("dplyr")
library("plotly")
library("stringr")
library("leaflet")

source("DUI_chart.R")
source("CollisionsWithPedestrians.R")


# Start shinyServer
server <- function(input, output) { 
  output$map <- renderLeaflet({
    return(map_DUI(total_DUI_collisions, input$num))
  })
  output$graph <- renderPlot({
    if(input$graph == "Pedestrian") {
      return(ggplotly(chart))
    }
    else if (input$graph == "Cyclists") {
      return(ggplotly(chart2))
    }
  })
  
}