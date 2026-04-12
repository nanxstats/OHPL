# Cross-validation for Ordered Homogeneity Pursuit Lasso

Use cross-validation to help select the optimal number of variable
groups and the value of `gamma`.

## Usage

``` r
cv.OHPL(
  X.cal,
  y.cal,
  maxcomp,
  gamma = seq(0.1, 0.9, 0.1),
  X.test,
  y.test,
  cv.folds = 5L,
  G = 30L,
  type = c("max", "median"),
  scale = TRUE,
  pls.method = "simpls"
)
```

## Arguments

- X.cal:

  Predictor matrix (training).

- y.cal:

  Response matrix with one column (training).

- maxcomp:

  Maximum number of components for PLS.

- gamma:

  A vector of the gamma sequence between (0, 1).

- X.test:

  X.test Predictor matrix (test).

- y.test:

  y.test Response matrix with one column (test).

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

A list containing the optimal model, RMSEP, Q2, and other evaluation
metrics. Also the optimal number of groups to use in group lasso.

## Examples

``` r
data("wheat")

X <- wheat$x
y <- wheat$protein
n <- nrow(wheat$x)

set.seed(1001)
samp.idx <- sample(1L:n, round(n * 0.7))
X.cal <- X[samp.idx, ]
y.cal <- y[samp.idx]
X.test <- X[-samp.idx, ]
y.test <- y[-samp.idx]

# This could run for a while
if (FALSE) { # \dontrun{
cv.fit <- cv.OHPL(
  x, y,
  maxcomp = 6, gamma = seq(0.1, 0.9, 0.1),
  x.test, y.test, cv.folds = 5, G = 30, type = "max"
)
# the optimal G and gamma
cv.fit$opt.G
cv.fit$opt.gamma
} # }
```
