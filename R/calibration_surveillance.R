#' Calibration Summary for Surveillance Predictions
#'
#' @param observed Binary observed outcomes.
#' @param predicted Predicted risks.
#' @param groups Number of calibration groups.
#' @return Calibration table.
#' @export
calibration_surveillance <- function(observed, predicted, groups = 10) {
  stopifnot(length(observed) == length(predicted))
  stopifnot(all(predicted >= 0 & predicted <= 1, na.rm = TRUE))

  group <- cut(
    predicted,
    breaks = stats::quantile(predicted, probs = seq(0, 1, length.out = groups + 1),
                             na.rm = TRUE),
    include.lowest = TRUE,
    duplicates = "drop"
  )

  data.frame(
    group = levels(group),
    observed_rate = as.numeric(tapply(observed, group, mean, na.rm = TRUE)),
    predicted_rate = as.numeric(tapply(predicted, group, mean, na.rm = TRUE)),
    n = as.numeric(tapply(observed, group, length))
  )
}
