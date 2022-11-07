#ifndef _HEADER_
#include "MinkowskiSum.h"
#endif

// [[Rcpp::export]]
bool test() {
  NT one(1);
  NT seven(7);
  NT zeroone(0.1);
  NT x = one - seven * zeroone;
  double y = CGAL::to_double<NT>(x);
  return y == 0.3;
}