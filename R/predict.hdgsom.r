################################
# predict.hdgsom - HDGSOM
# Alex Hunziker - 2017
# Alejandro Blanco Martinez - 2018 (contribution)
################################


predict.hdgsom <- function(object, df, retaindata=FALSE, ...){
  
  if(is.null(object$nodes$predict)) stop("Wrong input, use trained hdgsom model for dependent values.")
  
  # Normalizing the training or testdata (mean/sd) in order to balance the impact
  # of the different properties of the dataframe
  mean <- object$norm_param$mean
  sd <- object$norm_param$sd
  dfs <- t(apply(df, 1, function(x){(x-mean)/ifelse(sd==0,1,sd)}))
  object$nodes$codes <- t(apply(object$nodes$codes, 1, function(x){(x-mean)/ifelse(sd==0,1,sd)}))
  meany <- object$norm_param_y$meany
  sdy <- object$norm_param_y$sdy

  bmn <- rep(0, times=nrow(df))
  ndist <- rep(0, times=nrow(df))
  freq <- rep(0, times=nrow(object$nodes$codes))
  
  # Call the mapping function
  outc = .C("map_data",
            plendf = as.integer(nrow(df)),
            lennd = as.integer(nrow(object$nodes$codes)),
            dim = as.integer(ncol(object$nodes$codes)),
            df = as.double(dfs),
            codes =as.double(as.matrix(object$nodes$codes)), 
            bmn = as.double(bmn),
            ndist = as.double(ndist),
            freq = as.double(freq),
            PACKAGE = "hdgsom"
  )
  
  dist <- outc$ndist
  bmn <- outc$bmn
  bmn = matrix(bmn, ncol= 1)
  
  # Calculate the predicted values
  predict = data.frame(matrix(ncol=ncol(object$nodes$predict), nrow=nrow(df)))
  colnames(predict) = colnames(object$nodes$predict)
  for(i in (1:nrow(df))){
    predict[i,] = object$nodes$predict[bmn[i,1],]
  }

  cy = ncol(object$nodes$predict)

  object$nodes$codes <- t(apply(object$nodes$codes, 1, function(x){(x*sd+mean)}))
  
  hdgsom_mapped = list();
  hdgsom_mapped[["nodes"]] = object$nodes
  hdgsom_mapped[["nodes"]]$distance = NULL
  hdgsom_mapped[["nodes"]]$freq = outc$freq
  hdgsom_mapped[["prediction"]] = data.frame(bmn=bmn, dist=dist, value=predict)
  hdgsom_mapped[["norm_param"]] = object$norm_param
  hdgsom_mapped[["norm_param_y"]] = object$norm_param_y
  if(retaindata) hdgsom_mapped[["data"]] = df;
  
  class(hdgsom_mapped) = "hdgsom"
  
  return(hdgsom_mapped)
  
}
