#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("app.R", local = TRUE)



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  output$plot1 <- renderPlot({
    plot1(input$season1, input$episode1)
  })
  output$plot2 <- renderPlot({
    plot2(input$season2, input$episode2)
  })
  output$plot3 <- renderPlot({
    plot3(input$season3, input$episode3)
  })
}
)
