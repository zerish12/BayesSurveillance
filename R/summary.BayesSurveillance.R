#' Summarise BayesSurveillance Results
#'
#' @param object A surveillance result data frame.
#' @param ... Additional arguments.
#' @return Summary information.
#' @export
summary.BayesSurveillance <- function(object, ...) {
  if (!is.data.frame(object)) {
    stop("object must be a data frame.")
  }

  alert_count <- if ("alert" %in% names(object)) sum(object$alert, na.rm = TRUE) else NA

  list(
    n_time_points = nrow(object),
    variables = names(object),
    number_of_alerts = alert_count,
    first_alert_time = if ("alert" %in% names(object) && any(object$alert)) {
      object$time[which(object$alert)[1]]
    } else {
      NA
    }
  )
}
