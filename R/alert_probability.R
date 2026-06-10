#' Bayesian Alert Probability
#'
#' @param posterior_probability Numeric vector of posterior probabilities.
#' @param threshold Alert threshold.
#' @return Logical vector indicating alerts.
#' @export
alert_probability <- function(posterior_probability, threshold = 0.95) {
  stopifnot(is.numeric(posterior_probability))
  stopifnot(all(posterior_probability >= 0 & posterior_probability <= 1, na.rm = TRUE))
  stopifnot(threshold > 0 && threshold < 1)

  posterior_probability >= threshold
}
