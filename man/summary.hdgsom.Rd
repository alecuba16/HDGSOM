\name{summary.hdgsom}
\alias{summary.hdgsom}
\alias{print.hdgsom}

\title{
 Summary and print methods for hdgsom objects
}
\description{
Summary and print methods for hdgsom objects. The print method shows the dimensions and the topology of the map; if information on the training data is included, the summary method additionally prints information on the size of the data and the mean distance of an object to its closest node, which is an indication of the quality of the mapping.
}
\usage{
\method{summary}{hdgsom}(object, \dots)

\method{print}{hdgsom}(x, \dots)
}

\arguments{
  \item{x}{
  an object of class hdgsom.
}
  \item{object}{
  an object of class hdgsom.
}
\item{...}{
  not used.
}
}

\author{
  Alex Hunziker
}

\seealso{
  train.hdgsom, train_xy.hdgsom
}

\examples{
# load some data
data(iris)
iris <- iris[1:4]

#make a hdgsom map
hdgsom.iris <- train.hdgsom(iris)

#summarize
summary(hdgsom.iris)
}

\keyword{ GSOM }
\keyword{ GrowingSOM }
\keyword{ HDGSOM }
\keyword{ Summary }
\keyword{ Print }

