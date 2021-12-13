#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(title = 'Projet Data Visualisation',
             tabPanel(title = 'Note des choix',   
                      fluidRow(
                        column(5, tags$img(src = 'logo.jpg'), offset = 8),
                        column(2, tags$strong(tags$ol('Hiba Aznag', 'Mohamed Sebti' , 'Chouaib Chaoun')))
                        
                        
                      )
             ),
             
             tabPanel( title = "GOT_1",
                       fixedRow(column(12, tags$p("Carte Game Of Thrones"), offset = 0)),
                       numericInput(inputId = 'season1', label = 'Season Number', 
                                   min = 1, max  = 8, value = 1),
                       
                       numericInput(inputId = 'episode1', label = 'Episode Number', 
                                   min = 1, max  = 10, value = 1),
                       plotOutput('plot1')
                       
                       
             ),
             tabPanel( title = "GOT_2",
                       fixedRow(column(12, tags$p("Who was killed ?"), offset = 0)),
                       numericInput(inputId = 'season2', label = 'Season Number', 
                                    min = 1, max  = 8, value = 1),
                       
                       numericInput(inputId = 'episode2', label = 'Episode Number', 
                                    min = 1, max  = 10, value = 1),
                       plotOutput('plot2')
             ),
             tabPanel( title = "GOT_3",
                       fixedRow(column(12, tags$p("Duration by episode"), offset = 0)),
                       numericInput(inputId = 'season3', label = 'Season Number', 
                                    min = 1, max  = 8, value = 1),
                       
                       numericInput(inputId = 'episode3', label = 'Episode Number', 
                                    min = 1, max  = 10, value = 1),
                       plotOutput('plot3')
             )
  )
)