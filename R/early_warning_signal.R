#' Early-Warning Signal Rule
#'
#' @param probability Posterior or predictive probability.
#' @param threshold Alert threshold.
#' @param consecutive Number of consecutive signals required.
#' @return Logical vector indicating alerts.
#' @export
early_warning_signal <- function(probability, threshold = 0.95,
                                 consecutive = 1) {
  stopifnot(all(probability >= 0 & probability <= 1))
  stopifnot(consecutive >= 1)

  signal <- probability >= threshold
  alert <- rep(FALSE, length(signal))

  for (i in seq_along(signal)) {
    if (i >= consecutive) {
      alert[i] <- all(signal[(i - consecutive + 1):i])
    }
  }

  alert
}
