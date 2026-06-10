#' Plot Surveillance Results
#'
#' @param data Data frame returned by a surveillance function.
#' @param y Column name to plot.
#' @return A ggplot object.
#' @export
plot_surveillance <- function(data, y = "posterior_mean") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required.")
  }

  stopifnot("time" %in% names(data))
  stopifnot(y %in% names(data))

  ggplot2::ggplot(data, ggplot2::aes(x = .data$time, y = .data[[y]])) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::labs(
      x = "Time",
      y = y,
      title = "Bayesian Surveillance Monitoring"
    ) +
    ggplot2::theme_minimal()
}
