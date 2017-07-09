# Ordered Homogeneity Pursuit Lasso (OHPL)  <a href="https://ohpl.io"><img src="https://i.imgur.com/V8QU7dz.png" align="right" alt="logo" height="180" width="180" /></a>

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/road2stat/OHPL.svg?branch=master)](https://travis-ci.org/road2stat/OHPL)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/gly6tao7yu6vfq85?svg=true)](https://ci.appveyor.com/project/road2stat/ohpl-8jvmx)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

The R package `OHPL` implements the ordered homogeneity pursuit lasso (OHPL)
algorithm for group variable selection. This method takes the homogeneity
structure in high-dimensional data into account and is particularly useful
in datasets with strongly correlated variables.

## Installation

To download and install the `OHPL` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("road2stat/OHPL")
```

To get started, try the examples in `OHPL()`:

```r
library("OHPL")
?OHPL
```

[Browse the package documentation](https://ohpl.io/doc/) for more information.
