# server.R
library("dplyr")
library("plotly")
library("stringr")
library("leaflet")

source("DUI_chart.R")

map_DUI <- function(total_DUI_collisions, num) {
  num_DUIs <- total_DUI_collisions %>%
    filter(n >= num)
  
  pal <- colorNumeric(
    palette = c("orange", "red", "red4", "#400000"),
    domain = c(1:24)) 
  
  
  DUI_map <- leaflet(data = num_DUIs) %>%
    addProviderTiles("CartoDB.Positron") %>% 
    setView(lng = -122.33, lat = 47.60, zoom = 10) %>%
    addCircles(
      lat = ~Latitude,
      lng = ~Longitude,
      label = ~Location,
      radius = 200,
      color = ~pal(n),
      opacity = 0.3,
      stroke = FALSE
    )  %>%
    addLegend(
      position = "bottomright",
      title = "DUI Collisions",
      pal = pal,
      values = c(num:24),
      opacity = 0.75
    )
}



# Start shinyServer
server <- function(input, output) { 
  output$map <- renderLeaflet({
    return(map_DUI(total_DUI_collisions, input$num))
  })
}