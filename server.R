## server.R ##
shinyServer(function(input, output) {
  shinyFileChoose(input, 'files', root=c(root='/'), filetypes=c('', 'txt'))
})