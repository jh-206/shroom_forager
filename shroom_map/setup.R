
# Setup -------------------------------------------------------------------

  if(!require(pacman)) install.packages('pacman')
  pacman::p_load(sf, tidyverse, leaflet, scales)


# Test Data ---------------------------------------------------------------

  shrooms_v <- c('Oyster', 'Morel', 'Chanterelle')

# Transform ---------------------------------------------------------------

  fire_sf <- fire_sf %>% 
    dplyr::mutate(STARTDATE = as.Date(STARTDATE),
                  PERIMDATE = as.Date(PERIMDATE))
  
  
# Filter ------------------------------------------------------------------

  fire_sf <- fire_sf %>% 
    dplyr::filter(YEAR >= 2015)
  

# Helper Functions --------------------------------------------------------



# Leaflet Map -------------------------------------------------------------

  ## Center
  cen <- st_coordinates(fire_sf$geometry)
  cen <- colMeans(cen[, 1:2])
  
  ## Popup
  fire_sf <- fire_sf %>% 
    dplyr::mutate(popup = paste(sep = "<br/>", 
                                paste0('<b>', FIRENAME, '</b>'), 
                                paste0('Fire Date: ', format(PERIMDATE, format = '%B %d, %Y')),
                                paste0('Acreage: ', scales::comma(round(ACRES, 0)))
                                )
                  )
  
  ## Color Pallette
  yearPal <- leaflet::colorFactor('Reds', domain = fire_sf$YEAR)
  
  ## Map
  # leaflet(fire_sf) %>%
  #   addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  #   addPolygons(
  #     color = ~yearPal(YEAR),
  #     popup = ~popup,
  #     weight = 2,
  #     fillOpacity = .4
  #   )

  # leaflet(fire_sf) %>%
  #   addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
  #   setView( lng = as.numeric(cen['X']), 
  #            lat = as.numeric(cen['Y']), 
  #            zoom = 6 )
  
  
  
  
  