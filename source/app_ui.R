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
  h5(strong("- How do wet weather conditions affect traffic?")),
  h5(strong("- When Seattle drivers are getting in collisions how are they happening and 
            who is being harmed?")),
  h5(strong("- Where did the highest frequencies of collisions occur?")),
  
  
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
  plotOutput("scatter"),
  p(),
  # written analysis 
  p(
    "These charts show the correlation between car collisions and wet weather 
    conditions. The factors we are analyzing are the total number of accidents, 
    accidents involving fatalities, accidents involving injuries, and the amount 
    of precipitation measured at the time of the accident. We also compare the 
    number of accidents with and without wet weather conditions to see the if 
    there is a correlation between car collisions and the weather. Policy makers 
    and city planners can utilize these data visualizations and make decisions 
    while considering the safety of Seattle commuters during the raining seasons, 
    but without losing focus on the dry weather / slight raining conditions."
  )
)

#weather side content
weather_side <- sidebarPanel(
  # sliderInput? or other feature
  sliderInput("precipitation", "Amount of Precipitation (in):", 
              min = 0, max = 4, value = c(0, 4), step = 0.5),
  checkboxInput("checkbox", 
                label = "Show Incidents Without Precipitation (disables slider)", 
                value = FALSE),
  radioButtons("incident_type", "Type of Car Collisions",
               choices = list("Accidents" = "total_accidents", 
                              "Fatalities" = "total_fatalities",
                              "Injuries" = "total_injuries"))
)

#weather tab full structure  
weather_panel <- tabPanel(
  #title
  "Car Collisions in Relation to Weather",
  weather_side,
  weather_main
)

#INTERACTIVE #2: pedestrians/cyclists
#main panel
ped_cycle_main <- mainPanel(
  # plot output or other visualization
  plotOutput("graph"),
  p(),
  # written analysis 
  p(
    "These two graphs represent Seattle Collisions during certain road conditions. 
    Tallying numbers from decades worth of Seattle collisions. We can see that dry road 
    conditions has significantly more collisions than wet road conditions and icy road conditions 
    are not within reach of either. This trend is both in collisions that involve pedestrians and 
    collisions that involve cyclists. The lack of ice condition collisions can attested to the 
    average lows in winter months being higher that 32 degrees fahrenheit, resulting in very few 
    icy days. The Seattle community can hopefully learn how dangerous driving can be for pedestrians
    and cyclists even in fair weather and to always be vigilant despite weather conditions.",
  )
)
#side panel 
ped_cycle_side <- sidebarPanel(
  # sliderInput? or change
  radioButtons("graph", "Collision Type",
               choices = list("Pedestrian", "Cyclists")
  )
)

ped_cycle_panel <- tabPanel(
  #title
  "Pedestrian and Cyclist Incidents",
  ped_cycle_side,
  ped_cycle_main
)

#INTERACTIVE #3: DUI
#main panel
dui_main <- mainPanel(
  # plot output or other visualization
  leafletOutput("map"),
  p(),
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
  dui_side,
  dui_main
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
  h5(strong("- One major takeaway about data in general is it always surprises you. I would have never 
     guessed that a city like Seattle would have a higher number of dry accidents than wet ones. 
    This disparity is the exact reason why data wrangling and data visualization exist, to uncover trends 
     that we never thought would be there. Yet we also can confirm some of our theories including that 
     Seattle's climate doesn't allow for many accidents in weather other than dry or wet.")),
  h5(strong("- main takeway here")),
  h5(strong("- main takeway here")),
  
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
  titlePanel("Exploring Car Collisions in Seattle:Report"),
  #code name 
  h3("Code Name"),
  p("Crash Course"),
  
  #authors
  h3("Authors"),
  p("Christopher Peterson cjp1221@uw.edu"),
  p("Ethan Side eside@uw.edu"),
  p("Nessa Choi nessaa@uw.edu"),
  p("Olivia Grillo ogrillo@uw.edu"),
  
  #affiliation
  h3("Affiliation"),
  p("INFO-201: Technical Foundations of Informatics - 
    The Information School - University of Washington"),
  
  #date
  h3("Date"),
  p("December 8, 2022"),
  
  #abstract
  h3("Abstract"),
  p("Our main question is asking what are some of the main factors of
  traffic collisions in the Seattle area. This question is important
  because it identifies what issues correlate with the prominence of
  traffic collisions and what to do in order to decrease the chances.
  To address the question, we will analyze data regarding collisions,
  weather, and location to view the relationships between these factors
  and the data regarding traffic collisions."),
  
  #keywords 
  h3("Keywords"),
  p("Traffic, Car-Collisions, Weather, Transportation, Seattle"),
  
  #introduction
  h3("Introduction"),
  p("Our project focuses on analyzing traffic collision data in the Seattle
area. Our analysis includes investigating if and what possible
correlations exist between traffic and location, weather, DUI
collisions, and pedestrian/cyclist collisions. Our data sets include
variables such as speed average, location, time stamp, injuries,
fatalities, collision type, and other factors of car collisions.
Investigating our datasets could raise questions about
traffic-collisions in Seattle such as how certain weather conditions
affect traffic, where the highest frequencies of collisions occur, and
what type of crash is the most common."),
  
  #problem domain
  h2("Problem Domain"),
  h3("Framing"),
  p("In a perfect world, traffic collisions would be a thing of the past, but
they aren't, and thousands of people still lose their lives every year.
According to the World Health Organization, \"Road traffic injuries are
the leading cause of death for children and young adults aged 5-29
years.\" We can take tangible steps in our local community to reduce
traffic collisions, but first these steps rely on working with reliable
data. Traffic collisions are an issue that affects everyone, knowing
when and how they occur can help us make predictions and design
decisions for a safer and more efficient future. The way Seattle is
designed makes some roads and neighborhoods more prone to accidents,
leading to unnecessary property damage, injuries, and even fatalities.
This is an issue that has not only an economic burden but also a burden
on human life. Socially and culturally we rely heavily on cars
-especially on the west coast- and you can't get to many places easily
without a car. A reliance on car culture mixed with poor road design
leads to more traffic collisions, burdening society with unnecessary
economic and social damage. Government has a crucial role in lightening
the burden of car centric infrastructure. Having precise data on traffic
collisions allows government representatives, city planners, engineers,
and designers to make more informed decisions about road layouts,
traffic signals, and sign placement. It could also allow more careful
policing of certain areas to predict and prevent accidents from occuring
as well as allow quick reaction by first responders when they do. The
data also makes a strong case for the development of better public
transportation options which would reduce the economic burden of car
ownership, the land requirements that car-culture necessitates, and the
toll of life caused by traffic collisions."),
  
  #direct/indirect stakeholders
  h3("Direct/Indirect Stakeholders"),
  p("Direct stakeholders include Engineers, city planners, policy makers, 
  politicians, and first responders who deal with car accidents on a daily
  basis. The key indirect stakeholders are pedestrians and bikers who suffer
  the most from dangerous road design. Other indirect stakeholders include
  government officials and designers from other cities hoping to improve
  their transportation infrastructure."),
  
  #human values
  h3("Human Values"),
  p("The domain of this project primarily encompases two key values: Safety 
  and community. Safety is one of the most important values for all people. 
  When people have to risk their lives every day just to travel locally, their 
  safety is at risk. By making decisions based on traffic data people’s safety 
  could be greatly increased. We also want to look at how specific communities 
  and neighborhoods are affected by heightened rates of traffic collisions on 
  specific streets and intersections. We aim to investigate how the need for 
  community is impeded by traffic collisions and how communities can be made 
  closer with better road safety."),
  
  #potential benefits and harms
  h3("Potential Benefits and Harms"),

  #possible benefits
  p(strong("Possible Benefits")),
  p("Safer roads, more efficient traffic, decreased fatalities and injuries from 
  traffic collisions, enforcement of good driving habits, government transparency 
  on traffic issues, increased public knowledge on the issue, push for better 
  driving education."),
  
  #possible harms 
  p(strong("Possible Harms")),
  p("Over-policing of certain areas, economic implications for companies related 
    to car manufacturing and oil, priorities placed in certain neighborhoods where 
    others are neglected, the data excludes car crashes that were not reported."),
  
  #research questions 
  h3("Research Questions"),
  p(strong("1. "), "How does data about the weather conditions within the Greater
Seattle Area correlate with the number of traffic collisions?"),
  p(strong("2. "), "Is there a correlation between where pedestrians and cyclists
are involved in accidents?"),
  p(strong("3. "), "What areas had the highest rates of accidents where the driver
was under the influence? Are there certain roads with significantly
higher rates of DUI accidents?"),
  
  #data set
  h3("Data Sets"),
  p("Having the information on every traffic collision in the metro area paired 
  with the Seattle weather patterns allows us to create datasets to reveal patterns 
  in the traffic that can answer where, when, and why collisions are happening."),
  p("Sdot Collisions - All years: City of seattle open data portal. Seattle Open 
    Data. (2022, August 20). Retrieved October 30, 2022, from 
    https://data.seattle.gov/dataset/SDOT-Collisions-All-Years/9jdj-3h57"),
  p("Tatman, R. (2017, December 20). Did it rain in Seattle? (1948-2017). Kaggle. 
  Retrieved October 28, 2022, from 
  https://www.kaggle.com/datasets/rtatman/did-it-rain-in-seattle-19482017?resource=download"),
  
  #expected implications
  h3("Expected Implications"),
  p("If our research finds relationships between the listed causes and
traffic collisions, officials should expect stronger laws and
enforcement of speeding on roads, especially during hazardous weather.
Alternatively, policymakers can try to emphasize the use of public
transportation options, like the light rail in Seattle and bus routes in
order to decrease the number of drivers on the roads. Traffic designers
may examine the status of our roads and concerns in order to create more
effective and safer roads, utilizing better materials and designs to
enhance traffic safety and, as a result, reduce congestion and traffic
collisions. Innovating new technologies that can assist drivers with
safety alerts and weather advisories would be beneficial, as long as
innovators are focused on safety or the people rather than an economic
interest. Overall, we can expect that experts of all fields would take a
look at our research and make decisions that would benefit the people
and their safety in regards to traffic collisions."),
  
  #limitations
  h3("Limitations"),
  p("Some limitations we want to focus on is staying within the Seattle area.
If we were to focus on a larger/smaller location, then we might be
overwhelmed or underwhelmed with the amount of data we find. Another
limitation would be the mystery of whether the drivers involved with the
collision data are Seattle residents or tourists. Some other limitations
would include knowing whether the collision includes multiple cars, road
closures during certain days/weeks, weather conditions from past weather
data, and causes for collisions."),
  
  #findings
  h3("Findings"),
  p("writing here"),
  
  #discussions
  h3("Discussions"),
  p("writing here"),
  
  #conclusion
  h3("Conclusion"),
  p("writing here"),
  
  #acknowledgements
  h3("Acknowledgments"),
  p("A big thank you Raina, for answering our questions during section and being a
great resource for us when we need assistance. We also thank you for being so understanding 
    and valuing the importance of selfcare within learning!"),
  
  #References
  h3("References"),
  p("System, S. (2021, March 24). 5 cost-effective ways to reduce traffic
crashes. Fleet Safety Training Blog. Retrieved October 31, 2022, from
<https://blog.drivedifferent.com/blog/5-cost-effective-ways-to-reduce-traffic-crashes>"),
  p("Quarterly Vehicle Speed Report. WSDOT. (2022, July 29). Retrieved
October 31, 2022, from
<https://wsdot.wa.gov/about/transportation-data/travel-data/traffic-count-data/quarterly-vehicle-speed-report>"),
  p("Sdot Collisions - All years: City of seattle open data portal. Seattle
Open Data. (2022, August 20). Retrieved October 30, 2022, from
<https://data.seattle.gov/dataset/SDOT-Collisions-All-Years/9jdj-3h57>"),
  p("SeaTac, WA Weather History. Weather Underground. (2014-2022). TWC
Product and Technology. Retrieved October 31, 2022, from
<https://www.wunderground.com/history/monthly/us/wa/seatac/KSEA/date/2022-01>"),
  p("Steinger, M. (2022, June 3). The 12 Most Common Causes of Car Accidents.
Personal Injury Attorneys: Steinger, Greene and Feiner. Retrieved
October 31, 2022, from
<https://www.injurylawyers.com/blog/common-causes-car-accidents/>"),
  p("Tatman, R. (2017, December 20). Did it rain in Seattle? (1948-2017).
Kaggle. Retrieved October 28, 2022, from
<https://www.kaggle.com/datasets/rtatman/did-it-rain-in-seattle-19482017?resource=download>"),
  p("WSDOT. (n.d.). Seattle, Seattle-Tacoma International Airport: Current
Weather. Washington State Department of Transportation. Retrieved
October 31, 2022, from <https://wsdot.com/travel/real-time/weather/1879>"),
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