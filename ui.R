library(shiny)
library(shinyFiles)

source('functions.R')

shinyUI(
  navbarPage('scExplorer',
             tabPanel('Data Import',
                      sidebarPanel(
                        #img(src = 'logo.png', style = "float: left; width: 75px; margin-right: 10px; margin-top: 5px"),
                        
                        tags$p("To plot MACKtrack output data, locate the AllData_R.mat file\n
                               and input the character used to separate the experimental\n
                               conditions"),
                        tags$p("The conditions must be in the format shown in the documentation\n
                               to the right."),
                        shinyFilesButton("file", "File select", "Please select a file", multiple = TRUE),
                        tags$hr(),
                        tags$p(),
                        
                        textInput("Conds", "Names of conditions (separated by spaces):"),
                        textInput("delim", "Character to separate conditions:"),
                        actionButton('delim_sub','Submit'),
                        tags$p(),
                        tags$p('After submitting, the table to the right should show new columns
                               that correspond to the desired variables.'),
                        tags$hr()
                      ),
                      mainPanel(
                        tags$h4("The output of a file selection"),
                        tags$p(HTML("When one or several files are chosen the result is made \n
                                    available to the shinyServer instance. In order for it to get the\n
                                    formatting expected of a filepath it must first be fed into\n
                                    <code>parseFilePaths()</code> after which the output matches the formatting of\n
                                    that returned by shiny's own fileInput widget.")),
                        verbatimTextOutput("filepaths"),
                        verbatimTextOutput("head"),
                        tags$hr()
                        )
                      ),
             tabPanel('Plot Histograms',
                      sidebarPanel(
                        tags$p('To plot histogram grid, select which variables you would like to use for color
                               and data separation.'),
                        selectInput('hisVar', 'Value to Plot', c(NA), selected = NA),
                        selectInput('hisHoriz', 'Horizontal Variable', c(NA), selected = NA),
                        selectInput('hisVert', 'Vertical Variable', c(NA), selected = NA),
                        selectInput('hisCol', 'Color Variable', c(NA), selected = NA),
                        actionButton('hist_plot','Plot')
                      ),
                      mainPanel(
                        plotOutput("hist")
                      ))
             )
    )