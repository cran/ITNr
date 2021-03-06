#' @title Mixing Matrix
#'
#' @description This function calculates the mixing matrix for an igraph object
#' @param gs igraph object.
#' @param attrname Attribute name (vertex attribute)
#' @export
#' @return Mixing matrix
#' @examples
#' require(igraph)
#' ##Create random International Trade Network (igraph object)
#' gs<-erdos.renyi.game(50,0.05,directed = TRUE)
#'
#' ##Add vertex attributes
#' V(gs)$LETTER<-rep(LETTERS[1:5],10)
#'
#' ##Add vertex names
#' V(gs)$name<-1:vcount(gs)
#'
#' ##Calculate mixing matrix
#' mixing_matrix<-mixing_matrix_igraph(gs,"LETTER")
mixing_matrix_igraph<-function(gs,attrname){
  H<-c("name",attrname)
  DF<-igraph::get.data.frame(gs,what="vertices")
  DF1<-DF[,H]
  colnames(DF1)<-c("name","attr")
  type<-igraph::is_directed(gs)

  if (is.null(igraph::E(gs)$weight)==TRUE){
    igraph::E(gs)$weight<-rep(igraph::ecount(gs),1)
  }else{igraph::E(gs)$weight<-igraph::E(gs)$weight}

  EL<-igraph::get.data.frame(gs,what="edges")
  PIC<-c("from","to","weight")
  EL<-dplyr::select(EL,PIC)
  EL2<-EL
  EL2$to <- DF1$attr[match(EL2$to, DF1$name)]
  EL2$from <- DF1$attr[match(EL2$from, DF1$name)]
  EL3<-EL2[,1:2]
  HR<-c("from","to")
  EL3a<-plyr::ddply(EL3,HR,nrow)
  colnames(EL3a)<-c("from","to","weight")


  if (type==TRUE){
    ga<-igraph::graph_from_data_frame(EL3a,directed = TRUE)
    igraph::E(ga)$weight<-EL3a$weight
    ma<-igraph::as_adjacency_matrix(ga,attr="weight")
    ma<-as.matrix(ma)
    return(ma)
  }
  else if (type==FALSE){
    ga<-igraph::graph_from_data_frame(EL3a,directed = FALSE)
    igraph::E(ga)$weight<-EL3a$weight
    ma<-igraph::as_adjacency_matrix(ga,attr="weight")
    ma<-as.matrix(ma)
    return(ma)
  }
  else{
    print("graph type needs to be directed or undirected")
  }
}
