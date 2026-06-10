#' Simulate Healthcare Surveillance Data
#'
#' @param n_time Number of time points.
#' @param patients_per_time Number of patients per time point.
#' @param baseline_risk Baseline event probability.
#' @param change_point Time point where risk changes.
#' @param risk_multiplier Risk multiplier after change point.
#' @return A simulated surveillance data frame.
#' @export
simulate_surveillance_data <- function(n_time = 50,
                                       patients_per_time = 100,
                                       baseline_risk = 0.05,
                                       change_point = NULL,
                                       risk_multiplier = 1.5) {
  if (is.null(change_point)) {
    change_point <- Inf
  }

  risk <- rep(baseline_risk, n_time)
  risk[seq_len(n_time) >= change_point] <- baseline_risk * risk_multiplier
  risk <- pmin(risk, 1)

  events <- rbinom(n_time, size = patients_per_time, prob = risk)

  data.frame(
    time = seq_len(n_time),
    patients = patients_per_time,
    risk = risk,
    events = events
  )
}
