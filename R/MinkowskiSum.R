#' @title Minkowski sum of two meshes
#' @description Returns the mesh defined as the Minkowski sum of the
#'   two input meshes.
#'
#' @param mesh1,mesh2 two meshes, each one given either as a list containing
#'   (at least) the two fields \code{vertices} (numeric matrix with three columns)
#'   and \code{faces} (integer matrix or list of integer vectors), otherwise a
#'   \strong{rgl} mesh (i.e. a \code{mesh3d} object)
#' @param triangulate Boolean, whether to triangulate the output mesh (note
#'   that it is not necessarily triangle when the two input meshes are triangle)
#' @param normals Boolean, whether to return the vertex normals of the
#'   output mesh
#'
#' @return A mesh of class \code{cgalMesh} (list with \code{vertices}, 
#'   \code{faces}, and more; see \code{\link[PolygonSoup:Mesh]{Mesh}}).
#'
#' @export
#'
#' @importFrom data.table uniqueN
#'
#' @examples
#' # example 1: octahedron + icosahedron
#' library(MinkowskiSum)
#' library(rgl)
#' mesh1 <- octahedron3d()
#' mesh2 <- icosahedron3d()
#' mesh <- MinkowskiSum(mesh1, mesh2, normals = FALSE)
#' rglmesh <- toRGL(mesh)
#' open3d(windowRect = c(50, 50, 562, 562))
#' view3d(30, 30, zoom = 0.8)
#' shade3d(rglmesh, color = "maroon")
#' plotEdges(mesh[["vertices"]], mesh[["edges0"]], color = "darkred")
#'
#' # example2: truncated icosahedron + tetrahedron
#' \donttest{library(MinkowskiSum)
#' library(rgl)
#' # mesh 1
#' data(truncatedIcosahedron, package = "PolygonSoup")
#' mesh1 <- truncatedIcosahedron
#' # mesh 2: regular tetrahedron
#' a <- 1 / sqrt(3)
#' vertices <- rbind(
#' 		c( a, -a, -a),
#' 		c( a,  a,  a),
#' 		c(-a, -a,  a),
#' 		c(-a,  a, -a)
#' )
#' faces <- rbind(
#' 		c(1L, 2L, 3L),
#' 		c(3L, 2L, 4L),
#' 		c(4L, 2L, 1L),
#' 		c(1L, 3L, 4L)
#' )
#' mesh2 <- list(vertices = vertices, faces = faces)
#' # sum
#' mesh <- MinkowskiSum(mesh1, mesh2, normals = FALSE)
#' # plot
#' rglmesh <- toRGL(mesh)
#' open3d(windowRect = c(50, 50, 562, 562))
#' view3d(30, 30, zoom = 0.8)
#' shade3d(rglmesh, color = "navy")
#' plotEdges(mesh[["vertices"]], mesh[["edges0"]], color = "yellow")}
MinkowskiSum <- function(mesh1, mesh2, triangulate = TRUE, normals = FALSE){
  stopifnot(isBoolean(normals))
  vft1 <- getVFT(mesh1)
  triangulate1 <- !vft1[["isTriangle"]]
  vft2 <- getVFT(mesh2)
  triangulate2 <- !vft1[["isTriangle"]]
  mesh <- MinkowskiSumEK(
    vft1[["rmesh"]], vft2[["rmesh"]], triangulate, normals,
    triangulate1, triangulate2
  )
  mesh[["vertices"]] <- t(mesh[["vertices"]])
  toRGL <- FALSE
  faces <- mesh[["faces"]]
  sizes <- lengths(faces)
  usizes <- uniqueN(sizes)
  if(usizes == 1L){
    if(sizes[1L] %in% c(3L, 4L)){
      toRGL <- sizes[1L]
    }
    mesh[["faces"]] <- do.call(rbind, faces)
  }else if(usizes == 2L && all(sizes %in% c(3L, 4L))){
    toRGL <- 34L
  }
  edgesDF <- mesh[["edges"]]
  mesh[["edgesDF"]] <- edgesDF
  mesh[["edges"]] <- as.matrix(edgesDF[, c("i1", "i2")])
  exteriorEdges <- as.matrix(subset(edgesDF, exterior)[, c("i1", "i2")])
  mesh[["exteriorEdges"]] <- exteriorEdges
  mesh[["exteriorVertices"]] <- which(table(exteriorEdges) != 2L)
  if(normals){
    mesh[["normals"]] <- t(mesh[["normals"]])
  }
	if(triangulate){
	  edges0DF <- mesh[["edges0"]]
	  mesh[["edges0DF"]] <- edges0DF
	  mesh[["edges0"]] <- as.matrix(edges0DF[, c("i1", "i2")])
	}
  attr(mesh, "toRGL") <- toRGL
  class(mesh) <- "cgalMesh"
  mesh
}
