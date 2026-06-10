#' Risk-Adjusted CUSUM
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @param threshold Alert threshold.
#' @return Risk-adjusted CUSUM results.
#' @export
risk_adjusted_cusum <- function(observed, expected, threshold = 5) {
  bayesian_cusum(
    observed = observed,
    expected = expected,
    threshold = threshold,
    reset = TRUE
  )
}
