library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
    
    # Application title
    titlePanel("Explore India Coffee Production"),
    
    # Sidebar with a slider input for test the available variables
        
            sidebarPanel(                
                h4("Check which set of variables will be available",
                   "for the advanced analysis."),
                selectInput(
                    'V1', '1. Category of Coffee beans', 
                    choices = levels(CoffData$Category),
                    selected = levels(CoffData$Category)[1]
                ),
                selectInput(
                    'V2', '2. Region',
                    choices = levels(CoffData$region),
                    selected = "India"
                ),
                selectInput(
                    'V3', '3. Variable unit', 
                    choices = levels(CoffData$Unit),
                    selected = levels(CoffData$Unit)[1]
                ),
                selectInput(
                    'V4', '4. Avaiable variables', 
                    choices = levels(CoffData$variable),
                    selected = levels(CoffData$variable)[2]
                ),
                includeMarkdown("help.md"),
                br(),
                helpText("Note: when the set of variables access the available data,",
                         "the plot shows the values across years. The summary will ",
                         "show the descriptive statistics for each variable, and the",
                         "view will present the raw data set.")
                
            ),
    
        # mainpanel display the consequence of your selected
            mainPanel(
                tabsetPanel(type = "tabs", 
                            tabPanel("Plot", plotOutput("plot1")), 
                            tabPanel("Summary", verbatimTextOutput("summary")),
                            tabPanel("View", tableOutput("view"))
                )
            )        
))