library(MinkowskiSum)
data(bunny, package = "onion")
bunnymesh <- SurfaceReconstruction::PoissonReconstruction(bunny, spacing = 0.003)
spheremesh <- MeshesTools::sphereMesh(r= 0.01, iterations = 3L)

mesh <- MinkowskiSum(bunnymesh, spheremesh)

rglmesh <- addNormals(toRGL(mesh))

rgl::shade3d(rglmesh, color = "brown")

library(rgl)
open3d(windowRect = c(50, 50, 950, 500))
mfrow3d(1L, 2L)
view3d(zoom = 0.8)
shade3d(bunnymesh, color = "brown")
next3d()
view3d(zoom = 0.8)
shade3d(rglmesh, color = "brown")

snapshot3d("bunny.png", webshot = FALSE)