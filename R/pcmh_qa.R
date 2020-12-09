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
#' @param .report_type A \code{character} string of \code{"PCMH"} or \code{"Shared"}.
#'
#' @return Retrurns the character string "You completed PCMH QA!"
#' @export
#'
#' @importFrom openxlsx write.xlsx
#'
#' @examples
#' \dontrun{
#' pcmh_qa(.path_pdf, .path_metric, .path_out)
#' }
pcmh_qa <- function(.path_pdf, .path_metric, .path_out, .report_type = "PCMH") {
  pcmh_out <- pcmh::qa_report(.path_pdf, .path_metric, .report_type)
  openxlsx::write.xlsx(pcmh_out, file = .path_out)
  return(paste0("You completed PCMH Qa!"))
}
