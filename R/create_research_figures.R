#' Create Research-Quality Surveillance Figures
#'
#' Saves high-resolution example figures to `man/figures`.
#'
#' @param output_dir Directory where figures are saved.
#' @return Invisibly returns saved file paths.
#' @export
create_research_figures <- function(output_dir = "man/figures") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required.")
  }

  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  set.seed(123)

  dat <- simulate_surveillance_data(
    n_time = 60,
    patients_per_time = 120,
    baseline_risk = 0.05,
    change_point = 35,
    risk_multiplier = 2
  )

  bb <- beta_binomial_monitor(
    y = dat$events,
    n = dat$patients,
    threshold = 0.95
  )

  expected <- dat$patients * 0.05

  cus <- bayesian_cusum(
    observed = dat$events,
    expected = expected,
    threshold = 10
  )

  ew <- bayesian_ewma(
    observed = dat$events,
    expected = expected,
    lambda = 0.25,
    threshold = 3
  )

  base_theme <- ggplot2::theme_minimal(base_size = 14) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 18),
      plot.subtitle = ggplot2::element_text(size = 12),
      axis.title = ggplot2::element_text(face = "bold"),
      legend.position = "bottom",
      panel.grid.minor = ggplot2::element_blank()
    )

  fig1 <- ggplot2::ggplot(
    bb,
    ggplot2::aes(x = .data$time, y = .data$posterior_mean)
  ) +
    ggplot2::geom_area(fill = "#D6EAF8", alpha = 0.55) +
    ggplot2::geom_line(linewidth = 1.3, colour = "#1F77B4") +
    ggplot2::geom_point(ggplot2::aes(colour = .data$alert), size = 2.8) +
    ggplot2::scale_colour_manual(
      values = c("FALSE" = "#2CA02C", "TRUE" = "#D62728")
    ) +
    ggplot2::labs(
      title = "Bayesian Beta-Binomial Surveillance",
      subtitle = "Posterior event probability over time",
      x = "Time",
      y = "Posterior mean event probability",
      colour = "Alert"
    ) +
    base_theme

  fig2 <- ggplot2::ggplot(
    cus,
    ggplot2::aes(x = .data$time, y = .data$cusum)
  ) +
    ggplot2::geom_area(fill = "#E8DAEF", alpha = 0.55) +
    ggplot2::geom_line(linewidth = 1.3, colour = "#9467BD") +
    ggplot2::geom_hline(
      yintercept = 10,
      linetype = "dashed",
      colour = "#D62728",
      linewidth = 1
    ) +
    ggplot2::geom_point(ggplot2::aes(colour = .data$alert), size = 2.8) +
    ggplot2::scale_colour_manual(
      values = c("FALSE" = "#1F77B4", "TRUE" = "#D62728")
    ) +
    ggplot2::labs(
      title = "Bayesian CUSUM Early-Warning Chart",
      subtitle = "Cumulative deviation from expected outcomes",
      x = "Time",
      y = "CUSUM statistic",
      colour = "Alert"
    ) +
    base_theme

  fig3 <- ggplot2::ggplot(
    ew,
    ggplot2::aes(x = .data$time, y = .data$ewma)
  ) +
    ggplot2::geom_area(fill = "#FAD7A0", alpha = 0.50) +
    ggplot2::geom_line(linewidth = 1.3, colour = "#FF7F0E") +
    ggplot2::geom_hline(
      yintercept = c(-3, 3),
      linetype = "dashed",
      colour = "#D62728",
      linewidth = 1
    ) +
    ggplot2::geom_point(ggplot2::aes(colour = .data$alert), size = 2.8) +
    ggplot2::scale_colour_manual(
      values = c("FALSE" = "#2CA02C", "TRUE" = "#D62728")
    ) +
    ggplot2::labs(
      title = "Bayesian EWMA Surveillance Chart",
      subtitle = "Smoothed early-warning signal for healthcare monitoring",
      x = "Time",
      y = "EWMA statistic",
      colour = "Alert"
    ) +
    base_theme

  files <- file.path(
    output_dir,
    c(
      "figure1_beta_binomial_surveillance.png",
      "figure2_bayesian_cusum.png",
      "figure3_bayesian_ewma.png"
    )
  )

  ggplot2::ggsave(files[1], fig1, width = 8, height = 5, dpi = 600)
  ggplot2::ggsave(files[2], fig2, width = 8, height = 5, dpi = 600)
  ggplot2::ggsave(files[3], fig3, width = 8, height = 5, dpi = 600)

  invisible(files)
}
