#' Ordered Homogeneity Pursuit Lasso
#'
#' This function fits the ordered homogeneity pursuit lasso (OHPL) model.
#'
#' @param x Predictor matrix.
#' @param y Response matrix with one column.
#' @param maxcomp Maximum number of components for PLS.
#' @param gamma A number between (0, 1) for generating
#' the gamma sequence. An usual choice for gamma could be
#' \code{n * 0.05}, where \code{n} is a number in 2, 3, ..., 19.
#' @param cv.folds Number of cross-validation folds.
#' @param G Maximum number of variable groups.
#' @param type Find the maximum absolute correlation (\code{"max"})
#' or find the median of absolute correlation (\code{"median"}).
#' Default is \code{"max"}.
#' @param scale Should the predictor matrix be scaled?
#' Default is \code{TRUE}.
#' @param pls.method Method for fitting the PLS model.
#' Default is \code{"simpls"}. See section "Details"
#' in \code{\link[pls]{plsr}} for all possible options.
#'
#' @return A list of fitted OHPL model object with performance metrics.
#'
#' @importFrom glmnet cv.glmnet
#' @export OHPL
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
#' # selected variables
#' fit$Vsel
#' # make predictions
#' y.pred = predict(fit, x.test)
#' # compute evaluation metric RMSEP, Q2 and MAE for the test set
#' perf = OHPL.RMSEP(fit, x.test, y.test)
#' perf$RMSEP
#' perf$Q2
#' perf$MAE
OHPL = function(
  x, y, maxcomp, gamma, cv.folds = 5L,
  G = 30L, type = c("max", "median"),
  scale = TRUE, pls.method = "simpls") {

  type = match.arg(type)

  X = x
  y = y
  n.cal = length(y)

  # compute beta
  beta = single.beta(X = x, y = y, maxcomp = maxcomp)$"beta"

  # cluster variables with Fisher optimal partitions algorithm
  C = dlc(beta, maxk = G)$"C"
  groups = FOP(beta, G, C)

  # extract the prototypes from each group
  prototype = proto(x, y, groups, type = type)

  # X here should be the original X, not the normalized X
  X.pro = x[, prototype]

  # lasso with glmnet (with default lambdas)
  lasso.cv = suppressWarnings(cv.glmnet(X.pro, y, nfolds = cv.folds))

  # optnum: select the model with minimal cv error
  lasso.optnum = which.min(lasso.cv$cvm)[1]
  lasso.cv.min = sqrt(min(lasso.cv$cvm))  # cv.min
  lasso.optlambda = lasso.cv$lambda.min   # optlambda
  lasso.optbeta = lasso.cv$glmnet.fit$beta[, lasso.optnum]
  max.beta = max(abs(lasso.optbeta))

  # edge case: when there are less groups, lasso tends to
  # generate many near-zero coefficients (false positives)
  # filter out variables here with hard thresholding
  index.beta = (abs(lasso.optbeta)/max.beta) < gamma
  lasso.optbeta[index.beta] = 0

  # build PLS model with the selected prototype
  # and the variable grouping information
  index.nozero = which(lasso.optbeta != 0)
  Vsel = NULL

  for (i in 1L:length(index.nozero)) {
    Vseli = which(groups == index.nozero[i])
    Vsel = c(Vsel, Vseli)
  }

  # Vsel.idx[[j]] = Vsel
  # use the selected variables to build the PLS model
  # note that the X and y here are the original ones (not centered)
  Xsel = x[, Vsel]

  if (dim(Xsel)[2L] == 0L) {
    Vsel = c(Vsel, prototype)
    Xsel = X.pro
    print("The length of selected variables is zero")
  }

  temp.ncomp = min((dim(Xsel)[1] - 1), dim(Xsel)[2])
  # Xsel.idx[[j]] = Xsel.temp
  # create a new data frame based on the selected
  # varaibles (Xsel) and the original response (y)
  plsdf = as.data.frame(cbind(Xsel, y = y))

  Vsel.maxcomp = min(length(Vsel), maxcomp, temp.ncomp)

  plsr.cvfit = plsr(
    y ~ ., data = plsdf, ncomp = Vsel.maxcomp, scale = scale,
    method = pls.method, validation = "LOO")

  # select best component number using adjusted CV
  opt.K = which.min(pls::RMSEP(plsr.cvfit)[['val']][2L, 1L, -1L])

  # store the minimal RMSE from CV
  RMSECV = min(pls::RMSEP(plsr.cvfit)[['val']][2L, 1L, -1L])

  # store Q2.CV
  Q2.cv = R2(plsr.cvfit, estimate = "CV")[["val"]][, , opt.K + 1]

  nVar = length(Vsel)
  variables = matrix(0, nrow = ncol(X), ncol = 1)
  variables[Vsel, ] = 1

  # build an optimal PLS model
  plsdf = as.data.frame(cbind(Xsel, y = y))

  plsr.fit = plsr(
    y ~ Xsel, data = plsdf, ncomp = Vsel.maxcomp, scale = scale,
    method = pls.method, validation = "none")

  RMSEC = min(pls::RMSEP(plsr.fit, estimate = "train")[["val"]][, , opt.K + 1])
  Q2.c = pls::R2(plsr.fit, estimate = "train")[["val"]][, , opt.K + 1]

  res = list(
    "model" = plsr.fit, "opt.K" = opt.K,
    "RMSECV" = RMSECV, "Q2.cv" = Q2.cv,
    "RMSEC" = RMSEC, "Q2.c" = Q2.c,
    "nVar" = nVar, "variables" = variables, "Vsel" = Vsel,
    "groups" = groups)
  class(res) = c("OHPL")

  res

}
