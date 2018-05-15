#############################
# print.hdgsom - HDGSOM
# Alex Hunziker - 2017
# Alejandro Blanco Martinez - 2018 (contribution)
#############################


print.hdgsom <- function(x, ...){
  
  if(!is.null(x$mapped)){
    observations = length(x$mapped$bmn)
    return(cat("HDGSOM object.", observations, "observations are mapped onto an existing HDGSOM map.\n"))
  }
  
  if(!is.null(x$prediction)){
    observations = length(x$prediction$bmn)
    return(cat("HDGSOM object. For", observations, "observations Y values were predicted according to an existing hdgsom object.\n"))
  }
  
  if(x$nhood == "rect") topology = "rectangular"
  else topology = "hexagonal"
  
  cat("HDGSOM (hdgsom) map with", nrow(x$nodes$position), "nodes and a", topology, "topology.\n")
  
  if(!is.null(x$nodes$predict)) cat("Model contains predictions for dependent variables.\n")
  
  if(!exists("x$data")) included = "is not included.\n"
  else included = "is included.\n"
  
  cat("Training data", included)
}
