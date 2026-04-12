# Make predictions based on the fitted OHPL model

Make predictions on new data by an OHPL model object.

## Usage

``` r
# S3 method for class 'OHPL'
predict(object, newx, ncomp = NULL, type = "response", ...)
```

## Arguments

- object:

  Object of class `OHPL` fitted by
  [`OHPL()`](https://ohpl.io/doc/reference/OHPL.md).

- newx:

  Predictor matrix of the new data.

- ncomp:

  Optimal number of components. If is `NULL`, the optimal number of
  components stored in the model object will be used.

- type:

  Prediction type.

- ...:

  Additional parameters.

## Value

Numeric matrix of the predicted values.

## Examples

``` r
# generate simulation data
dat <- OHPL.sim(
  n = 100, p = 100, rho = 0.8,
  coef = rep(1, 10), snr = 3, p.train = 0.5,
  seed = 1010
)

# split training and test set
x <- dat$x.tr
y <- dat$y.tr
x.test <- dat$x.te
y.test <- dat$y.te

# fit the OHPL model
fit <- OHPL(x, y, maxcomp = 3, gamma = 0.5, G = 10, type = "max")
# make predictions
y.pred <- predict(fit, x.test)
y.pred
#>              [,1]
#>  [1,]  -1.4934986
#>  [2,]  -3.1985116
#>  [3,]  -3.9991944
#>  [4,]  -7.0397824
#>  [5,]  -8.4295953
#>  [6,]   2.2299174
#>  [7,]   1.1553114
#>  [8,]   1.9213972
#>  [9,]  -3.7234000
#> [10,]   2.3534563
#> [11,]  -6.0150089
#> [12,]  10.1426639
#> [13,]  -8.9355458
#> [14,]   2.1876354
#> [15,]  -1.4945804
#> [16,]  -5.3226173
#> [17,]   4.3945984
#> [18,]  -1.1679449
#> [19,]  -1.9954988
#> [20,] -12.8777276
#> [21,]   7.3833293
#> [22,]   6.2708949
#> [23,]   7.2140258
#> [24,]  -4.2743662
#> [25,]   1.0125648
#> [26,]   0.4475456
#> [27,]   2.0927234
#> [28,]   6.6396418
#> [29,] -11.4537155
#> [30,]   4.2973625
#> [31,]   6.5162231
#> [32,]  12.8164030
#> [33,]   1.0012365
#> [34,]   1.2443397
#> [35,]  -0.9012307
#> [36,]   8.1789392
#> [37,]  -1.3727632
#> [38,]  -6.5154226
#> [39,]  -1.0541956
#> [40,]   2.6830010
#> [41,]  -0.7592643
#> [42,]   4.2746329
#> [43,]   3.3917765
#> [44,]   4.2796405
#> [45,]  -0.4833004
#> [46,]   8.3971766
#> [47,]   2.0117400
#> [48,]  -9.1849344
#> [49,]   5.2380432
#> [50,]  -5.2196917
```
