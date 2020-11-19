#' PCMH QA
#'
#' This function is a wrapper around \code{\link[pcmh]{import_pdf_data}} and
#'   \code{\link[pcmh]{import_metric_data}}.
#'   You call this function to generate output for the PCMH report QA.
#'
#' @param .path_pdf Path to the \code{directory} containing the \code{.pdf} PCMH
#'   reports to be passed to \code{\link[pcmh]{import_pdf_data}}.
#' @param .path_metric Path to the \code{.csv} metric data to be passed to
#'   \code{\link[pcmh]{import_metric_data}}.
#' @param .path_out Path to the location the output will be saved.
#'
#' @return Retrurns the character string "You completed PCMH QA!"
#' @export
#'
#' @examples
#' \dontrun{
#' pcmh_qa(.path_pdf, .path_metric, .path_out)
#' }
pcmh_qa <- function(.path_pdf, .path_metric, .path_out) {
  pdf_data <- pcmh::import_pdf_data(.path_pdf)
  metric_data <- pcmh::import_metric_data(.path_metric, regexp = "metric.csv")
  metric_descriptions <- pcmh::import_metric_data(.path_metric, regexp = "mets_desc.csv")
  metrics <- pcmh::extract_metrics(pdf_data[[2]], metric_descriptions)
  return(paste0("You completed PCMH QA!"))
}
