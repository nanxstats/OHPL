#' Compute RMSEP, MAE, and Q2 for a Test Set
#'
#' This function makes predictions on new data and computes the
#' performance evaluation metrics RMSEP, MAE, and Q2.
#'
#' @param object An An object of class \code{OHPL}
#' fitted by \code{\link{OHPL}}.
#' @param newx Predictor matrix of the new data.
#' @param newy Response matrix of the new data (matrix with one column).
#'
#' @return A list of the performance metrics.
#'
#' @export OHPL.RMSEP
#'
#' @examples
#' # generate simulation data
#' dat = OHPL.sim(
#'   n = 100, p = 100, rho = 0.8,
#'   coef = rep(1, 10), snr = 3, p.train = 0.5,
#'   seed = 1010)
#'
#' # split training and test set
#' x = dat$x.tr
#' y = dat$y.tr
#' x.test = dat$x.te
#' y.test = dat$y.te
#'
#' # fit the OHPL model
#' fit = OHPL(x, y, maxcomp = 3, gamma = 0.5, G = 10, type = "max")
#' # compute evaluation metric RMSEP, Q2 and MAE for the test set
#' perf = OHPL.RMSEP(fit, x.test, y.test)
#' perf$RMSEP
#' perf$Q2
#' perf$MAE
OHPL.RMSEP = function(object, newx, newy) {

  # make predictions based on the fitted OHPL model
  y.pred = predict(
    object, newx = newx,
    ncomp = object$"opt.K", type = "response")
  y.pred = as.matrix(y.pred, ncol = 1L)

  # compute RMSEP and Q2.test
  newy = as.matrix(newy, ncol = 1L)
  residual = y.pred - newy
  RMSEP = sqrt(mean((residual)^2, na.rm = TRUE))
  MAE = mean(abs(residual), na.rm = TRUE)
  Q2.test = 1L - (sum((residual)^2, na.rm = TRUE)/sum((newy - mean(newy))^2))

  res = list(
    "RMSEP"    = RMSEP,
    "MAE"      = MAE,
    "Q2.test"  = Q2.test,
    "y.pred"   = y.pred,
    "residual" = residual)

  res

}
