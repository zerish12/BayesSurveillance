#' Observed Minus Expected Statistic
#'
#' @param observed Observed outcomes.
#' @param expected Expected outcomes.
#' @return Data frame with O-E statistics.
#' @export
o_minus_e <- function(observed, expected) {
  stopifnot(length(observed) == length(expected))
  stopifnot(all(expected >= 0))

  oe <- observed - expected

  data.frame(
    time = seq_along(observed),
    observed = observed,
    expected = expected,
    oe = oe,
    cumulative_oe = cumsum(oe)
  )
}
