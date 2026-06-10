#' Risk-Adjusted Observed Minus Expected Monitoring
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @param threshold Alert threshold for cumulative O-E statistic.
#' @return A data frame with O-E statistics and alerts.
#' @export
risk_adjusted_monitor <- function(observed, expected, threshold = 3) {
  stopifnot(length(observed) == length(expected))
  stopifnot(all(expected >= 0))

  oe <- observed - expected
  cum_oe <- cumsum(oe)

  data.frame(
    time = seq_along(observed),
    observed = observed,
    expected = expected,
    oe = oe,
    cumulative_oe = cum_oe,
    alert = abs(cum_oe) >= threshold
  )
}
