\name{map.hdgsom}
\alias{map.hdgsom}
\title{
  Map data to a supervised or unsupervised hdgsom object
}
\description{
  Map a data matrix onto a trained hdgsom object.
}
\usage{
  ## S3 method for class 'hdgsom'
  map.hdgsom(hdgsom_object, df, retaindata = FALSE, ...)
}

\arguments{
  \item{hdgsom_object}{
    a trained hdgsom map (either unsupervised, as obtained by train.hdgsom, or supervised, as returned by train_xy.hdgsom).
  }
  \item{df}{
    Data matrix, with rows corresponding to objects, and columns to the dimensions the hdgsom object was trained with
  }
  \item{retaindata}{
    if set to TRUE a copy of the mapped data (unscaled) will be added to the returned object.
  }
  \item{...}{
    not used.
  }
}

\value{
  Returns a S3 object of type "hdgsom" containing:
  \item{nodes$position}{
    the location of the nodes on the map.
  }
  \item{nodes$codes}{
    codes that were established during the training for each node and dimension of the data.
  }
  \item{nodes$freq}{
    how many times each node was the best matching node for the mapped matrix.
  }
  \item{mapped$bmn}{
    contains the best matching node for each of the data that was mapped.
  }
  \item{mapped$dist}{
    distance from best matching node for each row of the mapped data-matrix.
  }
  \item{data}{
    Unscaled copy of the data that was mapped. 
  }
}

\author{
  Alex Hunziker
  Alejandro Blanco Martinez
}

\seealso{
  train.hdgsom, predict.hdgsom
}
\examples{
  #Get some data
  data(iris)
  s = sample(1:150, 100)
  train_set = iris[s,1:4]
  test_set = iris[-s,1:4]

  # Create a GSOM Model
  hdgsom_iris <- train.hdgsom(train_set, spreadfactor=0.75)

  # Mapping
  mapped_iris <- map.hdgsom(hdgsom_iris, test_set)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ GSOM }
\keyword{ GrowingSOM }
\keyword{ HDGSOM }
\keyword{ Map }
