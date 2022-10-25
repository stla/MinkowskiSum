library(MinkowskiSum)
library(rgl)

data(greatStellatedDodecahedron, package = "MeshesTools")

mesh <- MinkowskiSum(septuaginta, greatStellatedDodecahedron)

open3d(windowRect = c(50, 50, 562, 562), zoom = 0.7)
shade3d(toRGL(mesh), color = "turquoise")
plotEdges(mesh$vertices, mesh$exteriorEdges)

movie3d(spin3d(axis = c(1, 1, 1), rpm = 10),
        duration = 6, fps = 20,
        movie = "zzpic", dir = ".",
        convert = FALSE, webshot = FALSE,
        startTime = 1/20)

library(gifski)
gifski(
  png_files = Sys.glob("zzpic*.png"),
  gif_file = "septuaginta_gsdodecahedron.gif",
  width = 512,
  height = 512,
  delay = 1/11
)

####################################

mesh <- MinkowskiSum(septuaginta, Rvcg::vcgSphere())
shade3d(toRGL(mesh), color = "cyan")
plotEdges(mesh$vertices, mesh$edges0)

mesh <- MinkowskiSum(septuaginta, cube3d())
shade3d(toRGL(mesh), color = "cyan")
plotEdges(mesh$vertices, mesh$edges0)
