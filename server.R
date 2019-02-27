library(shiny)
library(shinyFiles)
library(fs)
library(dplyr)
library(tidyr)

shinyServer(function(input, output, session) {
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileChoose(input, "file", roots = volumes, session = session)
  
  
  rawData <- reactive({
    raw = brooks.matlab(parseFilePaths(volumes, input$file)$datapath)
  })
  
  splitConds <- reactive({
    input$delim_sub
    isolate({
      conds = input$Conds %>% strsplit(' ') %>% unlist()
      rawData() %>% separate(col = Condition, into = conds, sep = input$delim, remove = F) 
    })
  })
  
  
  ## print to browser
  output$filepaths <- renderPrint({
    parseFilePaths(volumes, input$file)
  })
  
  output$head <- renderPrint({
    if(parseFilePaths(volumes, input$file)$name %>% length() == 0){
      NULL 
    } else if(parseFilePaths(volumes, input$file)$name %>% length() > 0 & input$delim_sub == 0){
      rawData()[1:5,1:5] 
    } else{
      input$delim_sub
      isolate({splitConds()[1:5,1:5]})
    }
    
    
  })
  
})




