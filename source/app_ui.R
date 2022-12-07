library("shinythemes")
# ui
# packages
library("shiny")
library("leaflet")

#intro tab
intro_panel <- tabPanel(
  #tab title
  "Introduction",
  
  # page title/heading
  titlePanel("Exploring Car Collisions in Seattle"),
  
  #intro paragraph: brief overview of your project: 
  #What major questions are you seeking to answer and what data will you use to answer those questions? 
  h4("Our data exploration project focuses on traffic collision records in the Seattle Area. Our
    analysis involves investigating possible relationships between the various factors of a car 
    collision including weather, pedistrians, cyclists, location, and the time of the incident. Our 
    investigation is driven by key questions such as: "),
  
  #main questions:
  h5(strong("- How do weather conditions affect traffic?")),
  h5(strong("- Where did the highest frequencies of collisions occur?")),
  h5(strong("- What proportion of incidences involved a pedistrian and
    or cyclist?")),
  
  #instruction to explore website
  p(em('*Click on each tab to explore interative visualizations of the various 
    dimensions of car collisions in Seattle!'), style = "color:yellow"),
  
  # image to add detail
  img(src = "https://i.etsystatic.com/20392596/r/il/44fb36/4276108273/il_1588xN.4276108273_j9ke.jpg", 
      height = "80%", width = "95%"),
  
  # link? to photo or other?
  p(em("image source: https://i.etsystatic.com/20392596/r/il/44fb36/4276108273/il_1588xN.4276108273_j9ke.jpg"))
  
  
)

#INTERACTIVE #1: weather 
#weather main content
weather_main <- mainPanel(
  # plot output?
  plotOutput("precipitation_chart"),
  
  # written analysis 
  p(
    "TEXT HERE",
  )
)

#weather side content
weather_side <- sidebarPanel(
  # sliderInput? or other feature
  headerPanel('Precipitation vs. Car Collisions'),
  sliderInput("precipitation", "Amount of Precipitation (in):", 
              min = 1, max = 4, value = 4, step = 0.1),
  checkboxGroupInput("car_collision_", "Type of Car Collisions",
                     c("Accidents" = "total_accidents",
                       "Fatalities" = "total_fatalities",
                       "Injuries" = "total_injuries"))
)

#weather tab full structure  
weather_panel <- tabPanel(
  #title
  "Car Collisions in Relation to Weather",
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

#INTERACTIVE #3: DUI
#main panel
dui_main <- mainPanel(
  # plot output or other visualization
  leafletOutput("map"),
  
  # written analysis 
  p(
    "This map was made to investigate rates of DUI colissions in the
    Seattle area. Through examining the map, locations with high rates of DUIs
    become easily identifiable. Policy makers and city planners can utilize this 
    information to better predict, prevent, police, and respond to drivers 
    under the influence. Community members could also use this map to spread
    awareness of the issue and take steps to stay safe in higher risk areas",
  )
)

#side panel
dui_side <- sidebarPanel(
  # sliderInput
  sliderInput(
    inputId = "num",
    label = "Minimum Number of DUI collisions at Location:",
    min = 1, max = 24, value = 1
  )
)

dui_panel <- tabPanel(
  "Collisions by Drivers Under the Influence",
  dui_main,
  dui_side
)
#SUMMARY/TAKEAWAYS
summary_takeaways_panel <- tabPanel(
  #tab title
  "Summary",
  
  # page title/heading
  titlePanel("Important Takeaways"),
  
  #3 major takeaways from the project (which should be related 
  #to a specific aspect of your analysis). Feel free to incorporate tables, 
  #graphics, or other elements to convey these conclusions. 
  h4("In exploring the entirety of our report, the amount of information in various data 
  representations we present can become daunting. Therefore, it is important to establish 
  key takeaways in order to ensure that you, the reader, undertstand the patterns in our 
  report in the way that we intended. The most important conclusions we have made from 
    our data exploration of traffic collisions in the Seattle area are: "),
  
  h5(strong("- main")),
  h5(strong("- takeways")),
  h5(strong("- here")),
  
  # image to add detail
  img(src = "https://www.pentaxforums.com/gallery/images/3274/1_Freeway_lights_6x9small.JPEGjpg.jpg", height = "80%", width = "95%"),
  
  # link? to photo or other?
  p(em("image source: https://www.pentaxforums.com/gallery/images/3274/1_Freeway_lights_6x9small.JPEGjpg.jpg"))
)


#REPORT HERE
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