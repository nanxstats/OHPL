# The wheat dataset

The wheat dataset contains 100 wheat samples with specified protein and
moisture content, published by J. Kalivas. Samples were measured by
diffuse reflectance as log (I/R) from 1100 to 2500 nm (701 data points)
in 2 nm intervals.

## Usage

``` r
data(wheat)
```

## References

Kalivas, J. H. (1997). Two data sets of near infrared spectra.
*Chemometrics and Intelligent Laboratory Systems*, 37(2), 255–259.

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
```
