# Fisher optimal partition

The Fisher optimal partition algorithm.

## Usage

``` r
FOP(X, k, C)
```

## Arguments

- X:

  A set of samples.

- k:

  Number of classes.

- C:

  Statistic from the output of
  [`dlc()`](https://ohpl.io/doc/reference/dlc.md).

## Value

Index vector for each sample's classification.

## References

W. D. Fisher (1958). On grouping for maximum homogeneity. *Journal of
the American Statistical Association*, vol. 53, pp. 789–798.

## Examples

``` r
X <- matrix(c(
  9.3, 1.8, 1.9, 1.7, 1.5, 1.3,
  1.4, 2.0, 1.9, 2.3, 2.1
))
C <- dlc(X, maxk = 8)$C
F <- FOP(X, 8, C)
```
