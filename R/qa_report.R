#' Qa Report
#'
#' This function generates the output for PCMH/Shared Savings report QA.
#'
#' @param .path_pdf \code{Filepath} to the directory for reports.
#' @param .path_metric \code{Filepath} to the directory of metric data/descriptions.
#' @param .report_type A \code{character} string of either "PCMH" or "Shared".
#'
#' @return Returns a \code{list} of sheets for writing to excel.
#' @export
#'
#' @examples
#' \dontrun{
#' qa_report(.path_pdf, .path_metric, .report_type = "PCMH")
#' }
qa_report <- function(.path_pdf, .path_metric, .report_type = "PCMH") {
  detail <- pcmh::check_report(.path_pdf, .path_metric, .report_type)
  summary <- pcmh::.generate_summary_page(detail)
  overview <- pcmh::.generate_overview_page(summary, .report_type)
  out <- list("Overview Statistics" = overview,
              "Summary" = summary,
              "Detail" = detail)
  return(out)
}
