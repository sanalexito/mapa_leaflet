
library(shiny)
library(leaflet)

#r_colors <- rgb(t(col2rgb(colors()) / 255))
#names(r_colors) <- colors()
lat <-c(19.30652113783788,19.304313767904436); lon <- c(-99.06530588915952,-99.05964106404954)
coordenadas <- data.frame(lat,lon) %>% mutate(Estacion = c("Tezonco","Olivos"))

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
                         choices = c("Tezonco" = coordenadas[1,3], 
                                     "Olivos" = coordenadas[2,3]),
                                    
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
