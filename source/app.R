# app
library("shiny")
library("datasets")
library("shinythemes")

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)


