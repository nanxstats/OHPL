#' Ordered Homogeneity Pursuit Lasso for Group Variable Selection
#'
#' OHPL implements the ordered homogeneity pursuit lasso (OHPL)
#' algorithm for group variable selection proposed in Lin et al. (2017)
#' <\href{https://doi.org/10.1016/j.chemolab.2017.07.004}{DOI:10.1016/j.chemolab.2017.07.004}>.
#' The OHPL method takes the homogeneity structure in high-dimensional data
#' into account and enjoys the grouping effect to select groups of
#' important variables automatically. This feature makes it particularly
#' useful for high-dimensional datasets with strongly correlated variables,
#' such as spectroscopic data.
#'
#' \tabular{ll}{Package: \tab OHPL\cr
#' Type: \tab Package\cr
#' License: \tab GPL-3\cr }
#'
#' @name OHPL-package
#' @docType package
#'
#' @import pls
#' @importFrom stats coef median predict sd
NULL
