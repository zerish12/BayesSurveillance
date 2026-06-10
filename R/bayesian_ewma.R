#' Bayesian EWMA Surveillance
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @param lambda EWMA smoothing parameter.
#' @param threshold Alert threshold.
#' @return A data frame with EWMA statistics.
#' @export
bayesian_ewma <- function(observed, expected, lambda = 0.2, threshold = 3) {
  stopifnot(length(observed) == length(expected))
  stopifnot(lambda > 0 && lambda <= 1)
  stopifnot(all(expected >= 0))

  residual <- observed - expected
  ewma <- numeric(length(residual))

  ewma[1] <- lambda * residual[1]

  if (length(residual) > 1) {
    for (i in 2:length(residual)) {
      ewma[i] <- lambda * residual[i] + (1 - lambda) * ewma[i - 1]
    }
  }

  out <- data.frame(
    time = seq_along(observed),
    observed = observed,
    expected = expected,
    residual = residual,
    ewma = ewma,
    alert = abs(ewma) >= threshold
  )

  class(out) <- c("BayesSurveillance", class(out))
  out
}
