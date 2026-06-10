#' ROC Evaluation for Surveillance Alerts
#'
#' @param truth Binary true outcome.
#' @param score Numeric risk or alert score.
#' @return A list containing ROC object and AUC.
#' @export
roc_surveillance <- function(truth, score) {
  if (!requireNamespace("pROC", quietly = TRUE)) {
    stop("Package 'pROC' is required.")
  }

  stopifnot(length(truth) == length(score))

  roc_obj <- pROC::roc(truth, score, quiet = TRUE)

  list(
    roc = roc_obj,
    auc = as.numeric(pROC::auc(roc_obj))
  )
}
