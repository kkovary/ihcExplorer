library(shiny)
library(shinyFiles)

source('functions.R')

shinyUI(pageWithSidebar(
  headerPanel(
    "scExplorer"
  ),
  sidebarPanel(
    img(src = 'logo.png', style = "float: left; width: 75px; margin-right: 10px; margin-top: 5px"),
    
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
    tags$hr(),
    tags$h4("The output of a folder selection"),
    tags$p(HTML("When a folder is selected the position of the folder is sent to \n
                the server and can be formatted with <code>parseDirPath()</code> to reflect a\n
                standard path string as returned by e.g. <code>choose.dir()</code> on windows\n
                systems.")),
    verbatimTextOutput("directorypath"),
    tags$hr(),
    tags$h4("The output of a file save"),
    tags$p(HTML('When a file is "saved" the name, path, and type are sent back to
                the server and formatted with <code>parseSavePath()</code>. The 
                format after parsing is very similar to a file choice, except
                size information is omitted (often the file doesn\'t exist yet)
                and type is now available (provided that filetype information has
                been sent from the server).')),
    verbatimTextOutput("savefile")
                )
    ))