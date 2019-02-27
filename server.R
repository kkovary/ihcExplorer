library(shiny)
library(shinyFiles)
library(fs)
library(magrittr)

shinyServer(function(input, output, session) {
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileChoose(input, "file", roots = volumes, session = session)
  
  
  rawData <- reactive({
    raw = brooks.matlab(parseFilePaths(volumes, input$file)$datapath)
  })
  
  ## print to console to see how the value of the shinyFiles 
  ## button changes after clicking and selection
  observe({
    cat("\ninput$file value:\n\n")
    print(input$file)
  })
  
  
  ## print to browser
  output$filepaths <- renderPrint({
    parseFilePaths(volumes, input$file)
    #head(rawData())
  })
  
  output$head <- renderPrint({
    
    if(parseFilePaths(volumes, input$file)$name %>% length() == 0)
      NULL
    else
    rawData()[1:5,1:8]
    
  })
  
})