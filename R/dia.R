dia <- function(X, i, n) {
  sapply(
    (i + 1):n,
    function(x) {
      sum(apply(
        as.matrix(X[i:x, ]), 2, function(y) (sd(y))^2 * (x - i)
      ))
    }
  )
}

# dia <- function(X, i, j) { # correct only when data dimension is 1
#   X <- X[i:j, ]
#   X <- as.matrix(X)
#   mu <- colMeans(X)
#   d <- apply(X, 1, function(x) crossprod(x - mu))
#   sum(d)
# }
