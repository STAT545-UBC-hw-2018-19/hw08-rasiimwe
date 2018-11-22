library(dplyr)
library(data.table) #helps to get data from the web. An alternative is library(RCurl) --> getURL('')
library(DT)#working with data table 
library(colourpicker)
library(shinyWidgets)
library(shinythemes)
library(shinydashboard)
library(ggplot2)


bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
bcl <- na.omit(bcl)
#bcl <- fread('https://deanattali.com/files/bcl-data.csv', stringsAsFactors = FALSE)
#write.csv(bcl, 'app/bcl-data.csv')

#user interface
ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = tags$b("BC Liquor Store Prices"), #app title
                                    titleWidth = '20%',#defining width for title
                                    dropdownMenu(type = "messages", #messages to app users
                                                 messageItem(
                                                   from = "Support",
                                                   message = "The full app will be deployed on 2018/12/15",
                                                   icon = icon("life-ring"),
                                                   time = "2018-11-18")),
                                    
                                    dropdownMenu(type = "notifications",#notification 1
                                                 notificationItem(
                                                   text = "50 new users today",
                                                   icon("users")
                                                 )
                                    )
                    ),
                    
                    dashboardSidebar(
                      
                      width = '20%', #defining sidebar width
                      icon("calendar"),#including calender icon to go with time
                      textOutput("currentTime", container = span),
                      # textOutput given a span container to make it appear
                      
                      h1(style="color:#EBF5FB", 
                         "Find your drink!"
                      ),
                      
                      hr(),
                      sliderInput("priceInput", "Select price range", min=0, max=100, value=c(10, 90), pre = "$"),#slider init with min and max slider values 10 and 90 respectively
                      radioButtons("typeInput", "Select product type",
                                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                                   selected = "WINE"),
                      uiOutput("countryOutput"),
                      
                      br(),#tag for break
                      h5("This app shows all the products sold by BC Liquor Store. Select the country, your prefered drink and price range to see your options. Please navigate the provided data table for more details on the available products "),#including helpful text to user
                      br(),
                      
                      img(src="sig-BCL.png", height = 100, width = '100%', align="center"),#image render
                      
                      hr(),#tag for horizontal rule
                      
                      span("Data source:", 
                           tags$a("OpenDataBC",
                                  href = "https://deanattali.com/files/bcl-data.csv")),
                      
                      br(),
                      
                      em( #em renders emphasized text
                        span("Created by Rebecca Asiimwe")),
                      span("Source Code at", a(href = "https://github.com/STAT545-UBC-students/hw08-rasiimwe", "GitHub"))
                      
                    ),
                    dashboardBody( #main app body
                      width = '80%', #defining body width
                      #height='100%',#defining body height
                      tags$head(
                        #including styles defined in css file
                        tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
                      
                      fluidRow(
                        tabBox(
                          title = "Alcohol Content",
                          # id lets us use input$tabset1 on the server to find the current tab
                          id = "tabset1", 
                          tabPanel("View - Distribution",plotOutput("plot3"),colourInput("col3", "Select plot colour", "#E5E7E9")),##", ##922B21, DC7633
                          tabPanel("View - Correlation",plotOutput("plot4"),colourInput("col4", "Select plot colour", "#08243B"))
                        ),
                        tabBox(
                          title = "Sweetness",
                          # id lets us use input$tabset1 on the server to find the current tab
                          id = "tabset2",
                          tabPanel("View - Distribution",plotOutput("plot6"),colourInput("col6", "Select plot colour", "#E5E7E9")),##", ##922B21, DC7633
                          tabPanel("View - Correlation",plotOutput("plot5"),colourInput("col5", "Select plot colour", "#08243B"))
                        ),
                        
                        box(title = "Distribution of Alcohol Content", status = "primary", solidHeader = TRUE,
                            collapsible = TRUE, collapsed=TRUE,plotOutput("plot1"), colourInput("colb", "Select plot colour", "#E5E7E9")),##E67E22  #", ##922B21, DC7633 #8E44AD
                        #box(title = "Inputs",status = "primary", solidHeader = TRUE,
                        #  collapsible = TRUE,background = "navy", plotOutput("coolplot2"),colourInput("col", "Select plot colour", "#EBE6E6")),
                        
                        box(title = "Alcohol Content Vs Price",status = "primary", solidHeader = TRUE,
                            collapsible = TRUE,collapsed=TRUE,plotOutput("plot2"),colourInput("col", "Select plot colour", "#08243B")),#background = "navy", 17202A
                        
                        
                        #box(shinythemes::themeSelector()),
                        downloadButton("download", "Download results")),
                      fluidRow(
                        box(title = "Data Table", width = '70%',DT::dataTableOutput("results"))
                      )
                    )
)
#server end code /implementations
server <- function(input, output) {
  
  output$currentTime <- renderText({ #render time
    # invalidateLater causes this output to automatically
    # become invalidated when input$interval milliseconds
    # have elapsed
    #invalidateLater(as.integer(input$interval))
    
    format(Sys.time())
  })
  
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  #option for country select
  output$countryOutput <- renderUI({ 
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })  
  
  #density plot created by ggplot
  output$plot1 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_density(bg = input$colb, pch = 21) +
      theme_bw()
  })
  
  
  #scatter plot created using ggplot
  output$plot2 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content, Price)) +
      geom_point(col = input$col, pch = 21) +
      theme_bw()
  })
  
  #histogram
  output$plot3 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram(col = "black", fill=input$col3,pch = 21, bins = 40) +
      theme_bw()
  })
  
  #density sweetness plot created by ggplot
  output$plot4 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content, Price)) +
      geom_point(col = input$col4, pch = 21) +
      theme_bw()
  })
  
  
  #scatter sweetness plot created using ggplot
  output$plot5 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Sweetness, Price)) +
      geom_point(col = input$col5, pch = 21) +
      theme_bw()
  })
  
  #histogram sweetness
  output$plot6 <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Sweetness)) +
      geom_histogram(col = "black", fill=input$col6,pch = 21,bins = 40) +
      theme_bw()
  })
  
  
  #code to render table with specified formats
  output$results <- DT::renderDataTable(
    filtered(), class = 'cell-border stripe',
    options = list(pageLength = 5, initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#E5E7E9', 'color': '#1A5276'});",
      "}")),
    caption = htmltools::tags$caption(
      style = 'caption-side: bottom; text-align: center;',
      'Table 1: ', htmltools::em('BC Liquor prices'))
  )
  
  #option to download dataset
  output$download <- downloadHandler(
    filename = function() {
      "bcl-results.csv"
    },
    content = function(con) {
      write.csv(filtered(), con)
    }
  )
  
}

shinyApp(ui = ui, server = server)
