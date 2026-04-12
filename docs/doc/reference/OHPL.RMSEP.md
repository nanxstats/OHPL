# Compute RMSEP, MAE, and Q2 for a test set

Makes predictions on new data and computes the performance evaluation
metrics RMSEP, MAE, and Q2.

## Usage

``` r
OHPL.RMSEP(object, newx, newy)
```

## Arguments

- object:

  Object of class `OHPL` fitted by
  [`OHPL()`](https://ohpl.io/doc/reference/OHPL.md).

- newx:

  Predictor matrix of the new data.

- newy:

  Response matrix of the new data (matrix with one column).

## Value

A list of the performance metrics.

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

# Compute evaluation metric RMSEP, Q2 and MAE for the test set
perf <- OHPL.RMSEP(fit, x.test, y.test)
perf$RMSEP
#> [1] 4.87666
perf$Q2
#> [1] 0.6026672
perf$MAE
#> [1] 3.930114
```
