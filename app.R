# Shiny App Interface

library(shiny)
library(shinyFiles)


# Define UI ----
shinyUI(
  shinyFilesButton('files', label='Browse', title='Select an AllData.R File', multiple=FALSE)
)

# Define server logic ----
server <- function(input, output){
  shinyFileChoose(input, 'files', root=c(root='/'), filetypes=c('', 'txt'))
}



# Run the app ----
shinyApp(ui = ui, server = server)
