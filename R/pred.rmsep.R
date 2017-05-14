pred.rmsep = function(object, opt.com, newx, newy) {

  y.pred = predict(object, ncomp = opt.com, newdata = newx, type = "response")
  y.pred = as.matrix(y.pred, ncol = 1L)

  # compute RMSEP and Q2_test
  # newy = y.test.tilde
  residual = y.pred - newy
  RMSEP = sqrt(mean((residual)^2, na.rm = TRUE))
  MAE = mean(abs(residual), na.rm = TRUE)
  Q2_test = 1L - (sum((residual)^2, na.rm = TRUE)/sum((newy - mean(newy))^2))

  res = list(
    "RMSEP" = RMSEP,
    "MAE" = MAE,
    "Q2_test" = Q2_test,
    "y.pred" = y.pred,
    "residual" = residual)

  res

}
