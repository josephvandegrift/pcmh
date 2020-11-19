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
#' @importFrom furrr future_map_dfr
#'
#' @examples
#' \dontrun{
#' pcmh_qa(.path_pdf, .path_metric, .path_out)
#' }
pcmh_qa <- function(.path_pdf, .path_metric, .path_out) {
  pcmh_reports <- pcmh::import_pdf_data(.path_pdf, regexp = "PCMH")
  ss_reports <- pcmh::import_pdf_data(.path_pdf, regexp = "Shared")
  metric_data <- pcmh::import_metric_data(.path_metric, regexp = "metrics.csv")
  metric_descriptions <- pcmh::.read_metric_data(.path_metric, regexp = "mets_desc.csv")
  pcmh_metrics <- furrr::future_map_dfr(pcmh_reports,
                                       pcmh::extract_metrics(.x, metric_descriptions))
  out <- pcmh::check_metrics(pcmh_metrics, metric_data)
  return(out)
  return(paste0("You completed PCMH QA!"))
}
