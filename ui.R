library(shiny)
library(shinyFiles)

## ui.R ##
shinyUI(fluidPage(
  shinyFilesButton('files', label='Browse', title='Select an AllData.R File', multiple=FALSE)
))