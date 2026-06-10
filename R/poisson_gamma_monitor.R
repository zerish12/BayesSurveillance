#' Bayesian Gamma-Poisson Monitoring for Count Outcomes
#'
#' @param y Observed counts.
#' @param exposure Exposure or expected counts.
#' @param shape_prior Prior gamma shape.
#' @param rate_prior Prior gamma rate.
#' @param threshold Alert threshold.
#' @return A data frame with posterior rate estimates and alerts.
#' @export
poisson_gamma_monitor <- function(y, exposure, shape_prior = 1,
                                  rate_prior = 1, threshold = 0.95) {
  stopifnot(length(y) == length(exposure))
  stopifnot(all(y >= 0), all(exposure > 0))

  cum_y <- cumsum(y)
  cum_exposure <- cumsum(exposure)

  shape_post <- shape_prior + cum_y
  rate_post <- rate_prior + cum_exposure

  posterior_rate <- shape_post / rate_post
  posterior_prob <- 1 - pgamma(posterior_rate, shape = shape_post, rate = rate_post)

  data.frame(
    time = seq_along(y),
    observed = y,
    exposure = exposure,
    cumulative_events = cum_y,
    cumulative_exposure = cum_exposure,
    posterior_rate = posterior_rate,
    posterior_probability = posterior_prob,
    alert = posterior_prob >= threshold
  )
}
