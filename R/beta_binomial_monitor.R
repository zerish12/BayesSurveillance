#' Bayesian Beta-Binomial Monitoring for Binary Outcomes
#'
#' @param y Number of observed events at each time point.
#' @param n Number of patients/cases at each time point.
#' @param alpha_prior Prior alpha parameter.
#' @param beta_prior Prior beta parameter.
#' @param threshold Alert threshold for posterior probability.
#' @return A data frame with posterior estimates and alert status.
#' @export
beta_binomial_monitor <- function(y, n, alpha_prior = 1, beta_prior = 1,
                                  threshold = 0.95) {
  stopifnot(length(y) == length(n))
  stopifnot(all(y >= 0), all(n > 0), all(y <= n))

  cum_y <- cumsum(y)
  cum_n <- cumsum(n)

  alpha_post <- alpha_prior + cum_y
  beta_post <- beta_prior + cum_n - cum_y

  posterior_mean <- alpha_post / (alpha_post + beta_post)
  posterior_prob <- 1 - pbeta(posterior_mean, alpha_post, beta_post)

  data.frame(
    time = seq_along(y),
    observed = y,
    total = n,
    cumulative_events = cum_y,
    cumulative_total = cum_n,
    posterior_mean = posterior_mean,
    posterior_probability = posterior_prob,
    alert = posterior_prob >= threshold
  )
}
