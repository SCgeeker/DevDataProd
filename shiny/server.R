library(shiny)

# Define server logic required to draw a illusion
shinyServer(function(input, output, session) {
    
    Data <- reactive({
        subset(
            CoffData, Category == input$V1 & region == input$V2 &
                      Unit == input$V3 & variable == input$V4
            )   
    })    
    

    output$plot1 <-  renderPlot({
        plot( Data()[,c(2,4)] )
    })
    
    output$summary <- renderPrint({ summary(Data()) })
    
    output$view <- renderTable({ Data() })
    
    
})

