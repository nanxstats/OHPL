#' beer dataset
#'
#' beer dataset
#'
#' @docType data
#' @name beer
#' @usage data(beer)
#'
#' @examples
#' data("beer")
#' x.cal = beer$xtrain
#' dim(x.cal)
#' x.test = beer$xtest
#' dim(x.test)
#' y.cal = beer$ytrain
#' dim(y.cal)
#' y.test = beer$ytest
#' dim(y.test)
#'
#' X = rbind(x.cal, x.test)
#' y = rbind(y.cal, y.test)
#' n = nrow(y)
#'
#' set.seed(1001)
#' samp.idx = sample(1L:n, round(n * 0.7))
#' X.cal = X[samp.idx, ]
#' y.cal = y[samp.idx]
#' X.test = X[-samp.idx, ]
#' y.test = y[-samp.idx]
NULL

#' wheat dataset
#'
#' wheat dataset
#'
#' @docType data
#' @name wheat
#' @usage data(wheat)
#'
#' @examples
#' data("wheat")
#'
#' X = wheat$x
#' y = wheat$protein
#' n = nrow(wheat$x)
#'
#' set.seed(1001)
#' samp.idx = sample(1L:n, round(n * 0.7))
#' X.cal = X[samp.idx, ]
#' y.cal = y[samp.idx]
#' X.test = X[-samp.idx, ]
#' y.test = y[-samp.idx]
NULL

#' soil dataset
#'
#' soil dataset
#'
#' @docType data
#' @name soil
#' @usage data(soil)
#'
#' @examples
#' data("soil")
#'
#' X = soil$x
#' y = soil$som
#' n = nrow(soil$x)
#'
#' set.seed(1001)
#' samp.idx = sample(1L:n, round(n * 0.7))
#' X.cal = X[samp.idx, ]
#' y.cal = y[samp.idx]
#' X.test = X[-samp.idx, ]
#' y.test = y[-samp.idx]
NULL
