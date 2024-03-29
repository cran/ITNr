% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ITNcluster_function.R
\name{ITNcluster}
\alias{ITNcluster}
\title{ITN Cluster}
\usage{
ITNcluster(gs)
}
\arguments{
\item{gs}{International Trade Network - igraph object (with region attribute)}
}
\value{
Cluster object containing various cluster membership results
}
\description{
This function calculates cluster membership for ITN
}
\examples{
\donttest{
##Load ITN
data(ELEnet16)

##Cluster Analysis
CLU<-ITNcluster(ELEnet16)
}
}
