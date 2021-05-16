
library(shiny)
library(leaflet)

#r_colors <- rgb(t(col2rgb(colors()) / 255))
#names(r_colors) <- colors()

lat <-c(19.304860093466836,19.299918733521913); lon <- c(-99.05948580235719,-99.04639662312582)
coordenadas <- data.frame(lat,lon) %>% mutate(Estacion = c("Nopalera","Olivos"))

# 
# ui <- fluidPage(
#   leafletOutput("mymap"),
#   selectInput("Cords","bla",choices = coordenadas)
# )
ui <- fluidPage(    
  leafletOutput("mymap"),
  # Give the page a title
  titlePanel("Estaciones del metro"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      
      checkboxGroupInput(inputId = "estacion",
                           label = "Estación:",
                         choices = c("Olivos" = coordenadas[1,3], 
                                     "Nopalera" = coordenadas[2,3]),
                                    
                         selected =  coordenadas[1,3]),
      hr(),
      helpText("Twitter: @san_alehandro.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("######")  
    )
    
  )
)

server <- function(input, output) {
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles("OpenStreetMap") %>% 
      addAwesomeMarkers(lat=coordenadas[which(coordenadas$Estacion%in%input$estacion),1],
                        lng=coordenadas[which(coordenadas$Estacion%in%input$estacion),2],
                        label = input$estacion
                       )
    
  })
}

shinyApp(ui, server)
