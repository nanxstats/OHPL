#' The beer dataset
#'
#' The beer dataset contains 60 samples published by Norgaard et al.
#' Recorded with a 30mm quartz cell on the undiluted degassed beer
#' and measured from 1100 to 2250 nm (576 data points) in steps of 2 nm.
#'
#' @docType data
#' @name beer
#' @usage data(beer)
#'
#' @references
#' Norgaard, L., Saudland, A., Wagner, J., Nielsen, J. P., Munck, L., &
#' Engelsen, S. B. (2000). Interval partial least-squares regression (iPLS):
#' a comparative chemometric study with an example from near-infrared
#' spectroscopy. \emph{Applied Spectroscopy}, 54(3), 413--419.
#'
#' @examples
#' data("beer")
#' x.cal <- beer$xtrain
#' dim(x.cal)
#' x.test <- beer$xtest
#' dim(x.test)
#' y.cal <- beer$ytrain
#' dim(y.cal)
#' y.test <- beer$ytest
#' dim(y.test)
#'
#' X <- rbind(x.cal, x.test)
#' y <- rbind(y.cal, y.test)
#' n <- nrow(y)
#'
#' set.seed(1001)
#' samp.idx <- sample(1L:n, round(n * 0.7))
#' X.cal <- X[samp.idx, ]
#' y.cal <- y[samp.idx]
#' X.test <- X[-samp.idx, ]
#' y.test <- y[-samp.idx]
NULL

#' The wheat dataset
#'
#' The wheat dataset contains 100 wheat samples with specified
#' protein and moisture content, published by J. Kalivas.
#' Samples were measured by diffuse reflectance as log (I/R)
#' from 1100 to 2500 nm (701 data points) in 2 nm intervals.
#'
#' @docType data
#' @name wheat
#' @usage data(wheat)
#'
#' @references
#' Kalivas, J. H. (1997). Two data sets of near infrared spectra.
#' \emph{Chemometrics and Intelligent Laboratory Systems}, 37(2), 255--259.
#'
#' @examples
#' data("wheat")
#'
#' X <- wheat$x
#' y <- wheat$protein
#' n <- nrow(wheat$x)
#'
#' set.seed(1001)
#' samp.idx <- sample(1L:n, round(n * 0.7))
#' X.cal <- X[samp.idx, ]
#' y.cal <- y[samp.idx]
#' X.test <- X[-samp.idx, ]
#' y.test <- y[-samp.idx]
NULL

#' The soil dataset
#'
#' The soil dataset contains 108 sample measurements from the
#' wavelength range of 400–2500 nm (visible and near infrared spectrum)
#' published by Rinnan et al.
#'
#' @docType data
#' @name soil
#' @usage data(soil)
#'
#' @references
#' Rinnan, R., & Rinnan, A. (2007). Application of near infrared
#' reflectance (NIR) and fluorescence spectroscopy to analysis of
#' microbiological and chemical properties of arctic soil.
#' \emph{Soil biology and Biochemistry}, 39(7), 1664--1673.
#'
#' @examples
#' data("soil")
#'
#' X <- soil$x
#' y <- soil$som
#' n <- nrow(soil$x)
#'
#' set.seed(1001)
#' samp.idx <- sample(1L:n, round(n * 0.7))
#' X.cal <- X[samp.idx, ]
#' y.cal <- y[samp.idx]
#' X.test <- X[-samp.idx, ]
#' y.test <- y[-samp.idx]
NULL
