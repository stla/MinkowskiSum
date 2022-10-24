#ifndef _HEADER_
#include "MinkowskiSum.h"
#endif

// [[Rcpp::export]]
Rcpp::List MinkowskiSumEK(const Rcpp::List rmesh1,
                          const Rcpp::List rmesh2,
                          const bool triangulate,
                          const bool normals,
                          const bool triangulate1,
                          const bool triangulate2) {
  Message("\u2014 Processing mesh n\u00b01...");
  EMesh3 mesh1 = 
    makeSurfMesh<EMesh3, EPoint3>(rmesh1, true, triangulate1, false);
  Message("... done.\n");
  Message("\u2014 Processing mesh n\u00b02...");
  EMesh3 mesh2 = 
    makeSurfMesh<EMesh3, EPoint3>(rmesh2, true, triangulate2, false);
  Message("... done.\n");
  ENef3 nef1(mesh1);
  ENef3 nef2(mesh2);
  ENef3 nef = CGAL::minkowski_sum_3(nef1, nef2);
  Rcpp::DataFrame Edges0;
  if(triangulate) {
    EMesh3 mesh0;
    CGAL::convert_nef_polyhedron_to_polygon_mesh(nef, mesh0, false);
    Edges0 = getEdges<EK, EMesh3, EPoint3>(mesh0);
  }
  EMesh3 mesh;
  CGAL::convert_nef_polyhedron_to_polygon_mesh(nef, mesh, triangulate);
  Rcpp::List rmesh = RSurfEKMesh(mesh, normals);
  if(triangulate) {
    rmesh["edges0"] = Edges0;
  }
  return rmesh;
}
