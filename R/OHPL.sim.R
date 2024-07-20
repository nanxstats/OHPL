#' Generate simulation data for benchmarking sparse regressions
#' (Gaussian response)
#'
#' Generate simulation data (Gaussian case) following the
#' settings in Xiao and Xu (2015).
#'
#' @param n Number of observations.
#' @param p Number of variables.
#' @param rho Correlation base for generating correlated variables.
#' @param coef Vector of non-zero coefficients.
#' @param snr Signal-to-noise ratio (SNR).
#' @param p.train Percentage of training set.
#' @param seed Random seed for reproducibility.
#'
#' @return A list containing `x.tr`, `x.te`, `y.tr`, and `y.te`.
#'
#' @author Nan Xiao <\url{https://nanx.me}>
#'
#' @references
#' Nan Xiao and Qing-Song Xu. (2015). Multi-step adaptive elastic-net:
#' reducing false positives in high-dimensional variable selection.
#' _Journal of Statistical Computation and Simulation_ 85(18), 3755--3765.
#'
#' @importFrom mvtnorm rmvnorm
#' @importFrom stats rnorm
#'
#' @export OHPL.sim
#'
#' @examples
#' dat <- OHPL.sim(
#'   n = 100, p = 100, rho = 0.8,
#'   coef = rep(1, 10), snr = 3, p.train = 0.5,
#'   seed = 1010
#' )
#'
#' dim(dat$x.tr)
#' dim(dat$x.te)
OHPL.sim <- function(
    n = 100, p = 100,
    rho = 0.8, coef = rep(1, 10), snr = 3,
    p.train = 0.5, seed = 1001) {
  call <- match.call()

  set.seed(seed)

  sigma <- matrix(0, p, p)
  corvec <- function(i, p, rho) rho^(abs(i - 1L:p))
  for (i in 1:p) sigma[i, ] <- corvec(i, p, rho)

  X <- rmvnorm(n, rep(0, p), sigma)

  # non-zero coefficients
  beta0 <- matrix(c(coef, rep(0, (p - length(coef)))))

  snr.numerator <- as.vector(t(beta0) %*% sigma %*% beta0)
  snr.denominator <- snr.numerator / snr
  sd <- sqrt(snr.denominator)
  eps <- matrix(rnorm(n, 0, sd))

  y <- as.matrix((X %*% beta0) + eps)

  # training / test set splitting
  tr.row <- sample(1L:n, round(n * p.train), replace = FALSE)

  x.tr <- X[tr.row, , drop = FALSE]
  y.tr <- y[tr.row, , drop = FALSE]
  x.te <- X[-tr.row, , drop = FALSE]
  y.te <- y[-tr.row, , drop = FALSE]

  list(
    "x.tr" = x.tr, "y.tr" = y.tr,
    "x.te" = x.te, "y.te" = y.te,
    "call" = call
  )
}
