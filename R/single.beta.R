single.beta <- function(X, y, maxcomp = NULL) {
  if (missing(X) | missing(y)) stop("Please specify both x and y")
  if (is.null(maxcomp)) maxcomp <- min(nrow(X) - 1L, ncol(X))

  plsdf <- as.data.frame(cbind(X, "y" = y))

  plsr.cvfit <- pls::plsr(
    y ~ X,
    data = plsdf, ncomp = maxcomp,
    scale = TRUE, method = "simpls", validation = "LOO"
  )

  # Select the best component number using adjusted CV
  opt.cv <- which.min(pls::RMSEP(plsr.cvfit)[["val"]][2L, 1L, -1L])
  rmse.cv <- min(pls::RMSEP(plsr.cvfit)[["val"]][2L, 1L, -1L])

  plsr.fit <- pls::plsr(
    y ~ X,
    data = plsdf, ncomp = opt.cv,
    scale = TRUE, method = "simpls", validation = "none"
  )

  beta1 <- matrix(coef(plsr.fit), ncol = 1L)

  simplsfit <- simpls.fit(X, y, opt.cv)
  beta <- coef(simplsfit, ncomp = opt.cv, intercept = FALSE)
  beta.simpls <- matrix(simplsfit$coefficients[, , opt.cv], ncol = 1L)

  obj <- list(
    "beta" = beta1,
    "opt.cv" = opt.cv,
    "rmse.cv" = rmse.cv,
    "beta.simpls" = beta.simpls
  )

  obj
}
