#######################################
# map.hdgsom - HDGSOM
# Alex Hunziker - 2017
# Alejandro Blanco Martinez - 2018 (contribution)
######################################

# This Function maps new data onto a trained hdgsom_object without adjusting 
# the hdgsom_object itself.
# Requires: trained hdgsom_object and testdata (DataFrame)
# Returns: mapped_data, which includes the nodes with position of nodes, frequency and average errors
#   as well as the error and winning node for each node of the testdata

map.hdgsom <- function(hdgsom_object, df, retaindata=FALSE, ...){
  
  # Normalizing the training or testdata (mean/sd) in order to balance the impact
  # of the different properties of the dataframe
  mean <- hdgsom_object$norm_param$mean
  sd <- hdgsom_object$norm_param$sd
  dfs <- t(apply(df, 1, function(x){(x-mean)/ifelse(sd==0,1,sd)}))
  hdgsom_object$nodes$codes <- t(apply(hdgsom_object$nodes$codes, 1, function(x){(x-mean)/ifelse(sd==0,1,sd)}))
  
  bmn <- rep(0, times=nrow(df))
  ndist <- rep(0, times=nrow(df))
  freq <- rep(0, times=nrow(hdgsom_object$nodes$codes))
  
  outc = .C("map_data",
            plendf = as.integer(nrow(df)),
            lennd = as.integer(nrow(hdgsom_object$nodes$codes)),
            dim = as.integer(ncol(hdgsom_object$nodes$codes)),
            df = as.double(dfs),
            codes =as.double(as.matrix(hdgsom_object$nodes$codes)), 
            bmn = as.double(bmn),
            ndist = as.double(ndist),
            freq = as.double(freq),
            PACKAGE = "GrowingSOM"
  )
  
  dist <- outc$ndist
  bmn <- outc$bmn

  hdgsom_mapped = list();
  hdgsom_mapped[["nodes"]] = hdgsom_object$nodes
  hdgsom_mapped[["nodes"]]$distance = NULL
  hdgsom_mapped[["nodes"]]$freq = outc$freq
  hdgsom_mapped[["mapped"]] = data.frame(bmn=bmn, dist=dist)
  hdgsom_mapped[["norm_param"]] = hdgsom_object$norm_param
  if(retaindata) hdgsom_mapped[["data"]] = df

  hdgsom_mapped$nodes$codes <- t(apply(hdgsom_mapped$nodes$codes, 1, function(x){(x*sd+mean)}))
  
  class(hdgsom_mapped) = "hdgsom"
  
  return(hdgsom_mapped)
  
}
