library(shiny)
library(shinyFiles)
library(fs)
library(dplyr)
library(tidyr)
library(ggplot2)

shinyServer(function(input, output, session) {
  
  # File Browser
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileChoose(input, "file", roots = volumes, session = session)
  
  # Data Input and Transforming
  rawData <- reactive({
    if(parseFilePaths(volumes, input$file)$name %>% length() > 0 & input$delim_sub > 0){
      conds = input$Conds %>% strsplit(' ') %>% unlist()
      
      brooks.matlab(parseFilePaths(volumes, input$file)$datapath) %>% 
        separate(col = Condition, into = conds, sep = input$delim, remove = F) 
      
    } else{
      brooks.matlab(parseFilePaths(volumes, input$file)$datapath)
    }
  })
  
  
  # Data Import Tab
  output$filepaths <- renderPrint({
    NULL
  })
  
  output$head <- renderPrint({
    if(parseFilePaths(volumes, input$file)$name %>% length() == 0){
      NULL 
    } else if(parseFilePaths(volumes, input$file)$name %>% length() > 0 & input$delim_sub == 0){
      rawData()[1:5,1:5] 
    } else{
      input$delim_sub
      isolate({rawData()[1:5,1:5]})
    }
    
  
  })
  
  ### Histogram Tab
  
  # Update variables that can be choosen to plot the histogram
  observe({
    if(parseFilePaths(volumes, input$file)$name %>% length() > 0 & input$delim_sub > 0){
      updateSelectInput(session = session, inputId = "hisVar", choices = c(NA, colnames(rawData())))
    } else{
      updateSelectInput(session = session, inputId = "hisVar", choices = c(NA))
    }
  })
  
  # Update histogram variable options with user defined conditions
  observe({
    input$delim_sub
    vars = input$Conds %>% strsplit(' ') %>% unlist()

    updateSelectInput(session = session, inputId = "hisHoriz", choices = c(NA,vars))
    updateSelectInput(session = session, inputId = "hisVert", choices = c(NA,vars))
    updateSelectInput(session = session, inputId = "hisCol", choices = c(NA,vars))
  })
  
  #hist_plot
  output$hist <- renderPlot({
    data = rawData()
    input$hist_plot
    isolate({
      ggplot(data, aes_string(x = input$hisVar, colour = input$hisCol)) + geom_freqpoly() + theme_bw()
    })
    
    
  })
  
})




