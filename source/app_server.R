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
    return(chart(Collision_Data, input$graph))
  })
}