# Ordered Homogeneity Pursuit Lasso (OHPL)  <a href="https://ohpl.io"><img src="https://i.imgur.com/V8QU7dz.png" align="right" alt="logo" height="180" width="180" /></a>

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/road2stat/ohpl.svg?branch=master)](https://travis-ci.org/road2stat/ohpl)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/road2stat/ohpl?branch=master&svg=true)](https://ci.appveyor.com/project/road2stat/ohpl)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

This R package implements the ordered homogeneity pursuit lasso (OHPL)
algorithm for group variable selection. This method takes the homogeneity
structure in high-dimensional data into account and is particularly useful
in datasets with strongly correlated variables.

## Installation

To download and install the `ohpl` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("road2stat/ohpl")
```

To get started, try the examples in `ohpl()`:

```r
library("ohpl")
?ohpl
```

[Browse the package documentation](https://ohpl.io/doc/) for more information.
