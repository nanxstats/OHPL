# Ordered Homogeneity Pursuit Lasso <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/nanxstats/OHPL/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nanxstats/OHPL/actions/workflows/R-CMD-check.yaml)
[![CRAN Version](https://www.r-pkg.org/badges/version/OHPL)](https://cran.r-project.org/package=OHPL)
[![Downloads from the RStudio CRAN mirror](https://cranlogs.r-pkg.org/badges/OHPL)](https://cran.r-project.org/package=OHPL)
<!-- badges: end -->

## Introduction

Implements the ordered homogeneity pursuit lasso (OHPL) algorithm for group variable selection proposed in Lin et al. (2017) <[DOI:10.1016/j.chemolab.2017.07.004](https://doi.org/10.1016/j.chemolab.2017.07.004)> ([PDF](https://nanx.me/papers/OHPL.pdf)). The OHPL method exploits the homogeneity structure in high-dimensional data and enjoys the grouping effect to select groups of important variables automatically. This feature makes it particularly useful for high-dimensional datasets with strongly correlated variables, such as spectroscopic data.

## Paper citation

Formatted citation:

You-Wu Lin, Nan Xiao, Li-Li Wang, Chuan-Quan Li, and Qing-Song Xu (2017). Ordered homogeneity pursuit lasso for group variable selection with applications to spectroscopic data. _Chemometrics and Intelligent Laboratory Systems_ 168, 62-71.

BibTeX entry:

```
@article{lin2017ordered,
  title   = {Ordered homogeneity pursuit lasso for group variable selection with applications to spectroscopic data},
  author  = {You-Wu Lin and Nan Xiao and Li-Li Wang and Chuan-Quan Li and Qing-Song Xu},
  journal = {Chemometrics and Intelligent Laboratory Systems},
  year    = {2017},
  volume  = {168},
  pages   = {62--71},
  doi     = {10.1016/j.chemolab.2017.07.004}
}
```

## Installation

You can install OHPL from CRAN:

```r
install.packages("OHPL")
```

Or try the development version on GitHub:

```r
# install.packages("remotes")
remotes::install_github("nanxstats/OHPL")
```

To get started, try the examples in `OHPL()`:

```r
library("OHPL")
?OHPL
```

[Browse the package documentation](https://ohpl.io/doc/) for more information.

## Contribute

To contribute to this project, please take a look at the [Contributing Guidelines](https://ohpl.io/doc/CONTRIBUTING.html) first.
Please note that the OHPL project is released with a
[Contributor Code of Conduct](https://ohpl.io/doc/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
