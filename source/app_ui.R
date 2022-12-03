library(shinythemes)
# ui
#packages
library(shiny)

#intro tab
intro_panel <- tabPanel(
  #tab title
  "Introduction",
  
  # page title/heading
  titlePanel("Exploring Car Collisions in Seattle"),
  
  #intro paragraph: brief overview of your project: 
  #What major questions are you seeking to answer and what data will you use to answer those questions? 
  p("Our data exploration project focuses on traffic collision records in the Seattle Area. Our
    analysis involves investigating possible relationships between the various factors of a car 
    collision including weather, pedistrians, cyclists, location, and the time of the incident. Our 
    investigation is driven by key questions such as how weather conditions affect traffic, where the 
    highest frequencies of collisions occur, and what proportion of incidences involved a pedistrian and
    or cyclist."),
  
  # image to add detail
  img(src = "~/Documents/info201/project-cjp1221/source/seattle_image.png"),
  
  # link? to photo or other?
  p(a(href = "LINK HERE", "(source)")),

  #instruction to explore website
  p('Click on each tab to explore interative visualizations of the various 
    dimensions of car collisions in Seattle!')
)

#INTERACTIVE #1: weather 

#weather main content
weather_main <- mainPanel(
  # plot output?
  plotOutput("plot"),
  
  # written analysis 
  p(
    "TEXT HERE",
  )
)

#weather side content
weather_side <- sidebarPanel(
  # sliderInput? or other feature
  sliderInput(
    inputId = "",
    label = "", min = 0, max = 0, value = c(0, 0)
  )
)

  
#weather tab full structure  
weather_panel <- tabPanel(
  #title
  "Weather in Relation to Car Collisions",
  weather_main,
  weather_side
)

#INTERACTIVE #2: pedestrians/cyclists
#main panel
ped_cycle_main <- mainPanel(
  # plot output or other visualization
  plotOutput("plot"),
  
  # written analysis 
  p(
    "TEXT HERE",
  )
)
#side panel 
ped_cycle_side <- sidebarPanel(
  # sliderInput? or change
  sliderInput(
    inputId = "",
    label = "", min = 0, max = 0, value = c(0, 0)
  )
)

ped_cycle_panel <- tabPanel(
  #title
  "Pedestrian and Cyclist Incidents",
  ped_cycle_main,
  ped_cycle_side
)

#interactive #3: DUI
#main panel
dui_main <- mainPanel(
  # plot output or other visualization
  plotOutput("plot"),
  
  # written analysis 
  p(
    "TEXT HERE",
  )
)
  
#side panel
dui_side <- sidebarPanel(
  # sliderInput? or change
  sliderInput(
    inputId = "",
    label = "", min = 0, max = 0, value = c(0, 0)
  )
)

dui_panel <- tabPanel(
  #title
  "Records of Under the Influence Drivers",
  dui_main,
  dui_side
)
#summary/takeaways 
summary_takeaways_panel <- tabPanel(
  #tab title
  "Summary",
  
  # page title/heading
  titlePanel("Important Takeaways"),
  
  #3 major takeaways from the project (which should be related 
  #to a specific aspect of your analysis). Feel free to incorporate tables, 
  #graphics, or other elements to convey these conclusions. 
  p("WRITE HERE"),
  
  # image to add detail
  img(src = "IMAGE LINK HERE"),
  
  # link? to photo or other?
  p(a(href = "LINK HERE", "(source)"))
)


#report page
report_panel <- tabPanel(
  #tab title
  "Report",
  
  # page title/heading
  titlePanel("Final Report"),
  
  # Iterate on your P01 and P02 to present your final report
  #link markdown here
  p("WRITE HERE")
)



#finalized/simplified ui structure
ui <- navbarPage(
  "Car Collisions in Seattle",
  intro_panel,
  weather_panel,
  ped_cycle_panel,
  dui_panel,
  summary_takeaways_panel,
  report_panel,
  theme = shinytheme("slate")
)