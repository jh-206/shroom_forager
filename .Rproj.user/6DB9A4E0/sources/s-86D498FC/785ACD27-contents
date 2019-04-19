
# Setup -------------------------------------------------------------------

  if(!require(pacman)) install.packages('pacman')
  pacman::p_load(sf, tidyverse, leaflet, scales)


# Read --------------------------------------------------------------------

  fire_sf <- sf::st_read(file.path(getwd(), 'data/Washington_Large_Fires_19732018/Washington_Large_Fires_19732017.shp'),
                         stringsAsFactors = F)
  

# Transform ---------------------------------------------------------------

  fire_sf <- fire_sf %>% 
    dplyr::mutate(STARTDATE = as.Date(STARTDATE),
                  PERIMDATE = as.Date(PERIMDATE))
  
  
# Filter ------------------------------------------------------------------

  fire_sf <- fire_sf %>% 
    dplyr::filter(YEAR >= 2015)
  

# Helper Functions --------------------------------------------------------



# Leaflet Map -------------------------------------------------------------

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
  leaflet(fire_sf) %>%
    addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
    addPolygons(
      color = ~yearPal(YEAR),
      popup = ~popup
    )
  