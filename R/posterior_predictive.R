#' Posterior Predictive Probability
#'
#' @param observed Observed value.
#' @param predicted Predicted or expected value.
#' @param sd_pred Predictive standard deviation.
#' @param direction Direction of concern: "higher" or "lower".
#' @return Posterior predictive tail probability.
#' @export
posterior_predictive <- function(observed, predicted, sd_pred,
                                 direction = c("higher", "lower")) {
  direction <- match.arg(direction)
  stopifnot(length(observed) == length(predicted))
  stopifnot(length(predicted) == length(sd_pred))
  stopifnot(all(sd_pred > 0))

  if (direction == "higher") {
    prob <- 1 - pnorm(observed, mean = predicted, sd = sd_pred)
  } else {
    prob <- pnorm(observed, mean = predicted, sd = sd_pred)
  }

  data.frame(
    observed = observed,
    predicted = predicted,
    sd_pred = sd_pred,
    posterior_predictive_probability = prob
  )
}
