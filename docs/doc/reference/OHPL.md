# Ordered Homogeneity Pursuit Lasso

Fits the ordered homogeneity pursuit lasso (OHPL) model.

## Usage

``` r
OHPL(
  x,
  y,
  maxcomp,
  gamma,
  cv.folds = 5L,
  G = 30L,
  type = c("max", "median"),
  scale = TRUE,
  pls.method = "simpls"
)
```

## Arguments

- x:

  Predictor matrix.

- y:

  Response matrix with one column.

- maxcomp:

  Maximum number of components for PLS.

- gamma:

  A number between (0, 1) for generating the gamma sequence. An usual
  choice for gamma could be `n * 0.05`, where `n` is a number in 2, 3,
  ..., 19.

- cv.folds:

  Number of cross-validation folds.

- G:

  Maximum number of variable groups.

- type:

  Find the maximum absolute correlation (`"max"`) or find the median of
  absolute correlation (`"median"`). Default is `"max"`.

- scale:

  Should the predictor matrix be scaled? Default is `TRUE`.

- pls.method:

  Method for fitting the PLS model. Default is `"simpls"`. See the
  details section in
  [`pls::plsr()`](https://khliland.github.io/pls/reference/mvr.html) for
  all possible options.

## Value

A list of fitted OHPL model object with performance metrics.

## References

You-Wu Lin, Nan Xiao, Li-Li Wang, Chuan-Quan Li, and Qing-Song Xu
(2017). Ordered homogeneity pursuit lasso for group variable selection
with applications to spectroscopic data. *Chemometrics and Intelligent
Laboratory Systems* 168, 62–71.

## Examples

``` r
# Generate simulation data
dat <- OHPL.sim(
  n = 100, p = 100, rho = 0.8,
  coef = rep(1, 10), snr = 3, p.train = 0.5,
  seed = 1010
)

# Split training and test set
x <- dat$x.tr
y <- dat$y.tr
x.test <- dat$x.te
y.test <- dat$y.te

# Fit the OHPL model
fit <- OHPL(x, y, maxcomp = 3, gamma = 0.5, G = 10, type = "max")

# Selected variables
fit$Vsel
#>  [1]  1  2  3  4  5  6  7  8  9 10 11

# Make predictions
y.pred <- predict(fit, x.test)

# Compute evaluation metric RMSEP, Q2 and MAE for the test set
perf <- OHPL.RMSEP(fit, x.test, y.test)
perf$RMSEP
#> [1] 4.87666
perf$Q2
#> [1] 0.6026672
perf$MAE
#> [1] 3.930114
```
