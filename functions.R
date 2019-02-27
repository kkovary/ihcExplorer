### Additional functions ###

brooks.matlab = function(y){
  require(dplyr)
  require(tibble)
  require(R.matlab)
  matlab = readMat(y)
  conds = matlab$AllData.conditions %>% unlist() %>% as.array()
  fields = matlab$AllData.fields %>% unlist() %>% as.vector()
  converted = as.data.frame(matlab$AllData.mat)
  colnames(converted) = fields
  
  converted$Condition = lapply(converted$Condition, function(x) conds[x]) %>% unlist()
  return(as.tibble(converted))
}

