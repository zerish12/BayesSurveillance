#' Bayesian CUSUM Surveillance
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @param threshold CUSUM alert threshold.
#' @param reset Logical; reset CUSUM at zero.
#' @return A data frame with Bayesian CUSUM statistics.
#' @export
bayesian_cusum <- function(observed, expected, threshold = 5, reset = TRUE) {
  stopifnot(length(observed) == length(expected))
  stopifnot(all(expected >= 0))

  score <- observed - expected
  cusum <- numeric(length(score))

  for (i in seq_along(score)) {
    if (i == 1) {
      cusum[i] <- score[i]
    } else {
      cusum[i] <- cusum[i - 1] + score[i]
    }

    if (reset) {
      cusum[i] <- max(0, cusum[i])
    }
  }

  out <- data.frame(
    time = seq_along(observed),
    observed = observed,
    expected = expected,
    score = score,
    cusum = cusum,
    alert = cusum >= threshold
  )

  class(out) <- c("BayesSurveillance", class(out))
  out
}
