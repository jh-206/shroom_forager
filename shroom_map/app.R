library(shiny)

fire_sf <- sf::st_read('data/Washington_Large_Fires_19732018/Washington_Large_Fires_19732017.shp')

source('setup.R', local = T)



# Define UI for application that draws a histogram
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  
  leafletOutput("mymap", width = "100%", height = "100%"),
  
  absolutePanel(top = 10, right = 10,
                selectInput("shroom", "Mushroom Variety",
                            shrooms_v
                )
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Reactive expression for the data subsetted to what the user selected
  filtered_data <- reactive({
    fire_sf[input$shroom != fire_sf$OBJECTID,]
  })
  
  output$mymap <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(fire_sf) %>% 
      addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
      setView( lng = as.numeric(cen['X']), 
               lat = as.numeric(cen['Y']), 
               zoom = 7 )
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    
    
    leafletProxy("mymap", data = filtered_data()) %>%
      clearShapes() %>%
      addPolygons(
        color = ~yearPal(YEAR),
        popup = ~popup,
        weight = 2,
        fillOpacity = .4
      )
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

