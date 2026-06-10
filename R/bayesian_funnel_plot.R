#' Bayesian Funnel Plot Data
#'
#' @param observed Observed events.
#' @param expected Expected events.
#' @param level Credible interval level.
#' @return A data frame for funnel plot construction.
#' @export
bayesian_funnel_plot <- function(observed, expected, level = 0.95) {
  stopifnot(length(observed) == length(expected))
  stopifnot(all(expected > 0))
  stopifnot(level > 0 && level < 1)

  ratio <- observed / expected
  alpha <- 1 - level
  lower <- qchisq(alpha / 2, 2 * observed) / (2 * expected)
  upper <- qchisq(1 - alpha / 2, 2 * (observed + 1)) / (2 * expected)

  out <- data.frame(
    unit = seq_along(observed),
    observed = observed,
    expected = expected,
    ratio = ratio,
    lower = lower,
    upper = upper,
    outlier = ratio < lower | ratio > upper
  )

  class(out) <- c("BayesSurveillance", class(out))
  out
}
