#' Compute D, L, and C in the Fisher Optimal Partitions Algorithm
#'
#' @param X a set of samples
#' @param maxk maximum number of k
#'
#' @return The D, L, and C statistics in the
#' Fisher optimal partitions algorithm
#'
#' @export dlc

dlc <- function(X, maxk) {
  n <- dim(X)[1]
  D <- matrix(0, n, n)
  rownames(D) <- 1:n
  colnames(D) <- 1:n

  result <- sapply(1:(n - 1), function(x) dia(X, x, n))
  result <- do.call("c", result)
  D[lower.tri(D)] <- result
  D <- t(D)
  D[lower.tri(D)] <- result

  L <- matrix(0, n - 1, maxk - 1)
  rownames(L) <- 2:n
  colnames(L) <- 2:maxk

  C <- matrix(0, n - 1, maxk - 1)
  rownames(C) <- 2:n
  colnames(C) <- 2:maxk
  diag(C) <- 2:maxk

  lc <- sapply(
    3:n,
    function(x) {
      c(
        min(D[1, 1:(x - 1)] + D[2:x, x]),
        which.min(D[1, 1:(x - 1)] + D[2:x, x])[1] + 1
      )
    }
  )

  L[as.character(3:n), "2"] <- lc[1, ]
  C[as.character(3:n), "2"] <- lc[2, ]

  for (j in 3:maxk) {
    lc <- sapply(
      (j + 1):n,
      function(x) {
        c(
          min(L[(j:x) - 2, j - 2] + D[j:x, x]),
          which.min(L[(j:x) - 2, j - 2] + D[j:x, x])[1] + j - 1
        )
      }
    )
    L[as.character((j + 1):n), as.character(j)] <- lc[1, ]
    C[as.character((j + 1):n), as.character(j)] <- lc[2, ]
    # cat("class", j, "of L, C of", type, "finished in dlc", "\n")
  }

  list("D" = D, "L" = L, "C" = C)
}
