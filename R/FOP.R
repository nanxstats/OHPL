#' Fisher Optimal Partition
#'
#' The Fisher optimal partition algorithm.
#'
#' @param X a set of samples
#' @param k number of classes
#' @param C statistic from the output of \code{\link{dlc}}
#'
#' @return index vector for each sample's classification
#'
#' @export FOP
#'
#' @references
#' W. D. Fisher (1958). On grouping for maximum homogeneity.
#' \emph{Journal of the American Statistical Association},
#' vol. 53, pp. 789--798.
#'
#' @examples
#' X <- matrix(c(
#'   9.3, 1.8, 1.9, 1.7, 1.5, 1.3,
#'   1.4, 2.0, 1.9, 2.3, 2.1
#' ))
#' C <- dlc(X, maxk = 8)$C
#' F <- FOP(X, 8, C)
FOP <- function(X, k, C) {
  n <- dim(X)[1]
  if (k == 1) {
    idx <- rep(1, n)
  } else {
    breaks <- rep(0, k)
    breaks[1] <- 1
    breaks[k] <- C[n - 1, k - 1]
    idx <- rep(1, n)
    idx[breaks[k]:n] <- k
    if (k > 2) {
      for (flag in (k - 1):2) {
        breaks[flag] <- C[breaks[flag + 1] - 2, flag - 1]
        idx[breaks[flag]:(breaks[flag + 1] - 1)] <- flag
      }
    }
  }

  idx
}
