library(shiny)
library(shinyFiles)
library(fs)

shinyServer(function(input, output, session) {
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileChoose(input, "file", roots = volumes, session = session)
  
  ## print to console to see how the value of the shinyFiles 
  ## button changes after clicking and selection
  observe({
    cat("\ninput$file value:\n\n")
    print(input$file)
  })
  
  
  ## print to browser
  output$filepaths <- renderPrint({
    parseFilePaths(volumes, input$file)
  })
  
  
})