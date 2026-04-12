# Generate simulation data for benchmarking sparse regressions (Gaussian response)

Generate simulation data (Gaussian case) following the settings in Xiao
and Xu (2015).

## Usage

``` r
OHPL.sim(
  n = 100,
  p = 100,
  rho = 0.8,
  coef = rep(1, 10),
  snr = 3,
  p.train = 0.5,
  seed = 1001
)
```

## Arguments

- n:

  Number of observations.

- p:

  Number of variables.

- rho:

  Correlation base for generating correlated variables.

- coef:

  Vector of non-zero coefficients.

- snr:

  Signal-to-noise ratio (SNR).

- p.train:

  Percentage of training set.

- seed:

  Random seed for reproducibility.

## Value

A list containing `x.tr`, `x.te`, `y.tr`, and `y.te`.

## References

Nan Xiao and Qing-Song Xu. (2015). Multi-step adaptive elastic-net:
reducing false positives in high-dimensional variable selection.
*Journal of Statistical Computation and Simulation* 85(18), 3755–3765.

## Examples

``` r
dat <- OHPL.sim(
  n = 100, p = 100, rho = 0.8,
  coef = rep(1, 10), snr = 3, p.train = 0.5,
  seed = 1010
)

dim(dat$x.tr)
#> [1]  50 100
dim(dat$x.te)
#> [1]  50 100
```
