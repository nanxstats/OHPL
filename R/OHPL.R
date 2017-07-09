#' Ordered Homogeneity Pursuit Lasso (OHPL)
#'
#' This function fits the ordered homogeneity pursuit lasso (OHPL) model.
#' It streamlines parameter tuning with cross-validation, model fitting,
#' and making predictions on the new data.
#'
#' @param X.cal Predictor matrix (training)
#' @param y.cal Response matrix with one column (training)
#' @param maxcomp Maximum number of components for PLS
#' @param gamma A number between (0, 1) for generating
#' the gamma sequence. An usual choice for gamma could be
#' \code{n * 0.05}, where \code{n} is a number in 2, 3, ..., 19.
#' @param X.test X.test Predictor matrix (test)
#' @param y.test y.test Response matrix with one column (test)
#' @param cv.folds Number of cross-validation folds
#' @param G Maximum number of variable groups
#' @param type Find the maximum absolute correlation (\code{"max"})
#' or find the median of absolute correlation (\code{"median"}).
#' Default is \code{"max"}.
#' @param scale Should the predictor matrix be scaled?
#' Default is \code{TRUE}.
#' @param pls.method Method for fitting the PLS model.
#' Default is \code{"simpls"}. See the details section
#' in \code{\link[pls]{plsr}} for all possible options.
#'
#' @return model list
#'
#' @importFrom glmnet cv.glmnet
#' @export ohpl
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
#'
#' # needs to run for a while
#' \dontrun{
#' fit = ohpl(
#'   X.cal, y.cal, maxcomp = 10, gamma = 0.8,
#'   X.test, y.test, G = 30, type = "max")
#'
#' fit$RMSEP}

ohpl = function(
  X.cal, y.cal, maxcomp, gamma,
  X.test, y.test, cv.folds = 5L,
  G = 30L, type = c("max", "median"),
  scale = TRUE, pls.method = "simpls") {

  type = match.arg(type)

  X = X.cal
  y = y.cal
  n.cal = length(y.cal)

  # compute beta
  beta = single.beta(X = X.cal, y = y.cal, maxcomp = maxcomp)$beta

  # cluster variables with Fisher optimal partitions algorithm
  C = dlc(beta, maxk = G)$C
  groups = fop(beta, G, C)

  # extract the prototypes from each group
  prototype = proto(X.cal, y.cal, groups, type = type)

  # X here should be the original X, not the normalized X
  X.pro = X.cal[, prototype]

  # lasso with glmnet (with default lambdas)
  lasso.cv = suppressWarnings(cv.glmnet(X.pro, y, nfolds = cv.folds))

  # optnum - select the model with minimal cv error
  lasso.optnum = which.min(lasso.cv$cvm)[1]
  lasso.cv_min = sqrt(min(lasso.cv$cvm))  # cv_min
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

  for (i in 1:length(index.nozero)) {
    Vseli = which(groups == index.nozero[i])
    Vsel = c(Vsel, Vseli)
  }

  # Vsel.idx[[j]] = Vsel
  # use the selected variables to build the PLS model
  # note that the X and y here are the original ones (not centered)
  Xsel = X.cal[, Vsel]

  if (dim(Xsel)[2] == 0) {
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

  # store Q2_CV
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

  # make predictions based on the fitted PLS model
  pls.pred.res = pred.rmsep(
    plsr.fit, opt.K, newx = X.test[, Vsel], newy = y.test)

  pls.RMSEP = pls.pred.res$"RMSEP"
  pls.Q2_test = pls.pred.res$"Q2_test"

  # output
  res = list(
    "opt.K" = opt.K, "RMSECV" = RMSECV, "nVar" = nVar,
    "variables" = variables, "Q2.cv" = Q2.cv, "Vsel" = Vsel,
    "plsr.fit" = plsr.fit, "RMSEC" = RMSEC, "Q2.c" = Q2.c,
    "RMSEP" = pls.RMSEP, "Q2.test" = pls.Q2_test, "groups" = groups)

  res

}
