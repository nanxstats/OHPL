# The beer dataset

The beer dataset contains 60 samples published by Norgaard et al.
Recorded with a 30mm quartz cell on the undiluted degassed beer and
measured from 1100 to 2250 nm (576 data points) in steps of 2 nm.

## Usage

``` r
data(beer)
```

## References

Norgaard, L., Saudland, A., Wagner, J., Nielsen, J. P., Munck, L., &
Engelsen, S. B. (2000). Interval partial least-squares regression
(iPLS): a comparative chemometric study with an example from
near-infrared spectroscopy. *Applied Spectroscopy*, 54(3), 413–419.

## Examples

``` r
data("beer")
x.cal <- beer$xtrain
dim(x.cal)
#> [1]  40 576
x.test <- beer$xtest
dim(x.test)
#> [1]  20 576
y.cal <- beer$ytrain
dim(y.cal)
#> [1] 40  1
y.test <- beer$ytest
dim(y.test)
#> [1] 20  1

X <- rbind(x.cal, x.test)
y <- rbind(y.cal, y.test)
n <- nrow(y)

set.seed(1001)
samp.idx <- sample(1L:n, round(n * 0.7))
X.cal <- X[samp.idx, ]
y.cal <- y[samp.idx]
X.test <- X[-samp.idx, ]
y.test <- y[-samp.idx]
```
