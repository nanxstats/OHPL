#' Make Predictions Based on the Fitted OHPL Model
#'
#' Make predictions on new data by an OHPL model object.
#'
#' @param object An object of class \code{OHPL}
#' fitted by \code{\link{OHPL}}.
#' @param newx Predictor matrix of the new data.
#' @param ncomp Optimal number of components.
#' If is \code{NULL}, the optimal number of components
#' stored in the model object will be used.
#' @param type Prediction type.
#' @param ... Additional parameters.
#'
#' @return Numeric matrix of the predicted values.
#'
#' @method predict OHPL
#'
#' @importFrom stats predict
#'
#' @export
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
#' # make predictions
#' y.pred = predict(fit, x.test)
#' y.pred
predict.OHPL = function(object, newx, ncomp = NULL, type = "response", ...) {

  if (!("OHPL" %in% class(object)))
    stop('object class must be "OHPL"')

  ncomp = ifelse(is.null(ncomp), object$"opt.K", ncomp)

  y.pred = predict(
    object$"model", newdata = newx[, object$"Vsel"],
    ncomp = ncomp, type = type)
  y.pred = as.matrix(y.pred, ncol = 1L)

  y.pred

}
