#' Cross-Validation for Ordered Homogeneity Pursuit Lasso
#'
#' This function uses cross-validation to help select the
#' optimal number of variable groups and the value of gamma.
#'
#' @param X.cal Predictor matrix (training)
#' @param y.cal Response matrix with one column (training)
#' @param maxcomp Maximum number of components for PLS
#' @param gamma A vector of the gamma sequence between (0, 1).
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
#' @return A list containing the optimal model, RMSEP, Q2,
#' and other evaluation metrics. Also the optimal number
#' of groups to use in group lasso.
#'
#' @export cv.OHPL
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
#' # This needs to run for a while
#' \dontrun{
#' cv.fit = cv.OHPL(
#'   x, y, maxcomp = 6, gamma = seq(0.1, 0.9, 0.1),
#'   x.test, y.test, cv.folds = 5, G = 30, type = "max")
#' # the optimal G and gamma
#' cv.fit$opt.G
#' cv.fit$opt.gamma}

cv.OHPL = function(
  X.cal, y.cal, maxcomp, gamma = seq(0.1, 0.9, 0.1),
  X.test, y.test, cv.folds = 5L,
  G = 30L, type = c("max", "median"),
  scale = TRUE, pls.method = "simpls") {

  type = match.arg(type)

  RMSEP.mat = matrix(NA, length(3:G),length(gamma))
  Q2.mat = matrix(NA, length(3:G),length(gamma))
  # alpha.idx = vector("list", length(gamma))
  # alpha.RMSEP = NULL
  # gamma.idx = vector("list", length(gamma))
  # K.idx = vector("list", length(3:K))
  # K.RMSEP = NULL
  L = list()

  # select the optimal gamma and the optimal number of groups

  for (i in 3L:G) {
    for (j in 1L:length(gamma)) {
      ohpl.model = OHPL(
        X.cal, y.cal, maxcomp, gamma = gamma[j],
        cv.folds = cv.folds,
        G = i, type = type,
        scale = scale, pls.method = pls.method)

      ohpl.rmsep.res = OHPL.RMSEP(ohpl.model, X.test, y.test)

      RMSEP.mat[i - 2, j] = ohpl.rmsep.res$"RMSEP"
      Q2.mat[i - 2, j] = ohpl.rmsep.res$"Q2.test"

      # each component in the list stores a model
      L[[(i - 3) * length(gamma) + j]] = ohpl.model
      cat("gamma =", gamma[j], "\n")
      # alpha.idx[[j]] = ohpl.model
      # alpha.RMSEP = c(alpha.RMSEP, ohpl.model$RMSEP)
    }
    cat("# of clusters =", i, "\n")
    # alpha.RMSEP.ind = which.min(alpha.RMSEP)
    # K.idx[[i-2]] = alpha.idx[[alpha.RMSEP.ind]]
    # K.RMSEP = c(K.RMSEP, alpha.RMSEP[alpha.RMSEP.ind])
  }

  minn = min(RMSEP.mat)
  # for each column in X, index of the rows which equal to mmin
  a = apply(RMSEP.mat, 2, function(x) which(x == minn))
  # get the column where the minimum value is
  b = sapply(a, function(x) length(x))
  # for each column in X, the number of rows which equals to minn
  # largest value in the index, which has the largest gamma, the sparser model
  gamma.num = max(which(b > 0L))
  # select the row with the largest value that corresponds to
  # the column with the largest value
  # to have fewer variables in each block, more concentrated
  opt.G = max(a[[gamma.num]])  # optimal number of groups
  opt.gamma = gamma[gamma.num]
  Q2 = max(Q2.mat)

  # select the optimal model
  # store one model in each component in the list
  result = L[[(opt.G - 1) * length(gamma) + gamma.num]]

  res = list("model" = result, "opt.G" = opt.G, "opt.gamma" = opt.gamma)
  res

}
