#' Risk-Adjusted EWMA
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @param lambda EWMA smoothing parameter.
#' @param threshold Alert threshold.
#' @return Risk-adjusted EWMA results.
#' @export
risk_adjusted_ewma <- function(observed, expected, lambda = 0.2, threshold = 3) {
  bayesian_ewma(
    observed = observed,
    expected = expected,
    lambda = lambda,
    threshold = threshold
  )
}
