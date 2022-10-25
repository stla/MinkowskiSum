# MinkowskiSum

Minkowski addition of two meshes.

<!-- badges: start -->
[![R-CMD-check](https://github.com/stla/MinkowskiSum/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/stla/MinkowskiSum/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

- Octahedron + sphere:

![](https://raw.githubusercontent.com/stla/MeshesOperations/master/inst/screenshots/OctahedronPlusSphere.gif)

- Tetrahedron + truncated icosahedron:

![](https://raw.githubusercontent.com/stla/MeshesOperations/master/inst/screenshots/TetrahedronPlusTruncatedIcosahedron.gif)

- Septuaginta + great stellated dodecahedron:

![](https://raw.githubusercontent.com/stla/MinkowskiSum/main/inst/screenshots/septuaginta_gsdodecahedron.gif)

- Stanford bunny + sphere

![](https://raw.githubusercontent.com/stla/MinkowskiSum/main/inst/screenshots/bunny.png)



## License

This package is provided under the GPL-3 license but it uses the C++ library 
CGAL. If you wish to use CGAL for commercial purposes, you must obtain a 
license from the [GeometryFactory](https://geometryfactory.com).


## Blog post

I wrote a 
[blog post](https://laustep.github.io/stlahblog/posts/MinkowskiSumLeonardo.html) 
showing an example of the Minkowski addition (using **RCGAL**, an 
[ancestor](https://laustep.github.io/stlahblog/posts/splittingRCGAL.html) 
of **MinkowskiSum**).
