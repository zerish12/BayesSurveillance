#' Approximate Bayes Factor Alert
#'
#' @param posterior_prob Posterior probability of deterioration.
#' @param prior_prob Prior probability of deterioration.
#' @param threshold Bayes factor threshold.
#' @return Data frame with Bayes factor and alert.
#' @export
bayes_factor_alert <- function(posterior_prob, prior_prob = 0.5, threshold = 3) {
  stopifnot(all(posterior_prob > 0 & posterior_prob < 1, na.rm = TRUE))
  stopifnot(prior_prob > 0 && prior_prob < 1)

  posterior_odds <- posterior_prob / (1 - posterior_prob)
  prior_odds <- prior_prob / (1 - prior_prob)
  bf <- posterior_odds / prior_odds

  data.frame(
    posterior_prob = posterior_prob,
    prior_prob = prior_prob,
    bayes_factor = bf,
    alert = bf >= threshold
  )
}
