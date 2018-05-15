#######################################
# train.hdgsom - HDGSOM
# Alex Hunziker - 2017
# Alejandro Blanco Martinez - 2018 (contribution)
#######################################

# The Functions in this File are required in order to train the hdgsom model.

train.hdgsom <- function(data, spreadFactor=0.8, keepdata=FALSE, iterations=50, alpha=0.9, beta=0.5, gridsize = FALSE, nhood= "rect", initrad = NULL, ...){
  
  # Normalizing the training or testdata (mean/sd) in order to balance the impact
  # of the different properties of the dataframe
  mean <- apply(data, 2, function(x){mean(x)})
  sd <- apply(data, 2, function(x){sd(x)})
  df <- t(apply(data, 1, function(x){(x-mean)/ifelse(sd==0,1,sd)}))
  
  if(gridsize==FALSE) grow=1
  else grow=2
  
  if(gridsize == FALSE) gridsize=2
  else if(!is.numeric(gridsize)){
    stop("Grid size must be nummeric (for classical kohonen map) or FALSE (for Growing SOM).")
  }

  # Call Function grow.hdgsom
  hdgsom_object <- grow.hdgsom(hdgsom_object, df, iterations, spreadFactor, alpha, beta, gridsize = gridsize, nhood=nhood, grow=grow, initrad = initrad)

  hdgsom_object$nodes$codes <- t(apply(hdgsom_object$nodes$codes, 1, function(x){(x*sd+mean)}))
  
  norm_param <- data.frame(mean = mean, sd = sd)
  hdgsom_object[["norm_param"]] <- norm_param
  
  if(keepdata==TRUE){
    hdgsom_object[["data"]] = data
  }
  
  class(hdgsom_object) = "hdgsom"
  
  return(hdgsom_object)
  
}
