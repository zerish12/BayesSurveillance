#' Calculate Expected Events
#'
#' @param risk Predicted patient-level risks.
#' @param group Optional grouping variable.
#' @return Expected event totals.
#' @export
expected_events <- function(risk, group = NULL) {
  stopifnot(is.numeric(risk))
  stopifnot(all(risk >= 0 & risk <= 1, na.rm = TRUE))

  if (is.null(group)) {
    return(sum(risk, na.rm = TRUE))
  }

  stats::aggregate(risk, by = list(group = group), FUN = sum, na.rm = TRUE)
}
