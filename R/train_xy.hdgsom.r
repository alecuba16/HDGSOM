#######################################
# train_xy.hdgsom - HDGSOM
# Alex Hunziker - 2017
# Alejandro Blanco Martinez - 2018 (contribution)
#######################################

# Returns a trained supervised HDGSOM object.

train_xy.hdgsom <- function(data, y, spreadFactor=0.8, keepdata=FALSE, iterations=50, alpha=0.9, beta=0.5, gridsize = FALSE, nhood= "rect", initrad = NULL, ...){
  
  # Normalizing the training or testdata (mean/sd) in order to balance the impact
  # of the different properties of the dataframe
  meanx <- apply(data, 2, function(x){mean(x)})
  sdx <- apply(data, 2, function(x){sd(x)})
  df <- t(apply(data, 1, function(x){(x-meanx)/ifelse(sdx==0,1,sdx)}))
  
  if(is.vector(y)) cy = 1
  else cy = ncol(y)
  y <- as.matrix(y, ncol = cy)
  meany <- apply(y, 2, function(x){mean(x)})
  sdy <- apply(y, 2, function(x){sd(x)})
  if(cy > 1) y <- t(apply(y, 1, function(x){(x-meany)/ifelse(sdy==0,1,sdy)}))
  else y <- matrix(apply(y, 1, function(x){(x-meany)/ifelse(sdy==0,1,sdy)}), ncol=1)
  
  if(gridsize==FALSE) grow=1
  else grow=2
  
  if(gridsize == FALSE) gridsize=2
  else if(!is.numeric(gridsize)){
    stop("Grid size must be nummeric (for classical kohonen map) or FALSE (for Growing SOM).")
  }
  
  # Call grow_xy.hdgsom()
  hdgsom_object <- grow_xy.hdgsom(y, df, iterations, spreadFactor, alpha, beta, gridsize, nhood, grow, initrad = initrad)

	hdgsom_object$nodes$codes <- t(apply(hdgsom_object$nodes$codes, 1, function(x){(x*sdx+meanx)}))
 
	#convert data types if only one variable to be predicted.
	if(cy==1) {
	  hdgsom_object$nodes$predict <- data.frame(hdgsom_object$nodes$predict)
	  hdgsom_object$nodes$predict <- data.frame(apply(hdgsom_object$nodes$predict, 1, function(x){(x*sdy+meany)}))
	}
	else hdgsom_object$nodes$predict <- t(apply(hdgsom_object$nodes$predict, 1, function(x){(x*sdy+meany)}))
  colnames(hdgsom_object$nodes$predict) = colnames(y)
	
  norm_param <- data.frame(mean = meanx, sd = sdx)
  norm_param_y <- data.frame(meany = meany, sd = sdy)
  hdgsom_object[["norm_param"]] <- norm_param
  hdgsom_object[["norm_param_y"]] <- norm_param_y
  
  if(keepdata==TRUE){
    hdgsom_object[["data"]] = data
  }
  
  class(hdgsom_object) = "hdgsom"
  
  return(hdgsom_object)
  
}
