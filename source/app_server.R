# server.R
library("dplyr")
library("plotly")
library("stringr")
library("leaflet")

source("weather_chart.R")
source("DUI_chart.R")
source("CollisionsWithPedestrians.R")


# Start shinyServer
server <- function(input, output) { 
  output$scatter <- renderPlot({
    return(create_scatterplot(weather_vs_collisions, 
                              input$precipitation[1],
                              input$precipitation[2],
                              input$checkbox,
                              input$incident_type))
  })
  
  output$map <- renderLeaflet({
    return(map_DUI(total_DUI_collisions, input$num))
  })
  output$graph <- renderPlot({
    return(chart(Collision_Data, input$graph))
  })
}
