#' Check Report
#'
#' This function generates the output for the QA for either PCMH or Shared Savings
#'   reports.
#'
#' @param .path_pdf A \code{filepath} to the directory of the \code{.pdf} PCMH
#'   reports.
#' @param .path_metric A \code{filepath} to the directory of the metric data and
#'   descriptions pulled from oracle.
#' @param .report_type A \code{character string}; either "PCMH" or "Shared".
#'
#' @return Returns a \code{tibble} of metric checks for either the PCMH or
#'   Shared Savings reports.
#' @export
#'
#' @importFrom furrr future_pmap_dfr
#'
#' @examples
#' \dontrun{
#' check_report(..path_pdf, .path_metric, .report_type = "PCMH")
#' }
check_report <- function(.path_pdf, .path_metric, .report_type = "PCMH") {
    reports <-
      pcmh::import_pdf_data(.path_pdf, regexp = .report_type)
    metric_data <-
      pcmh::import_metric_data(.path_metric, regexp = paste0("\\/", .report_type, "_", "metrics"))
    # desc_path <- fs::dir_ls(.path_metric, regexp = paste0("\\/", .report_type, "_", "desc"))
    metric_descriptions <- .read_metric_data(.path_metric, regexp = paste0("\\/", .report_type, "_", "desc"))
    metrics <-
      furrr::future_pmap_dfr(list(reports),
                             ~ extract_metrics(..1, metric_descriptions))
    out <-
      pcmh::check_metrics(metrics, metric_data)
    return(tibble::as_tibble(out))
}
