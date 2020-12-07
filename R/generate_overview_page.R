#' Generate Overview Page
#'
#' This function generates the overview statistics page of the output for the
#'   PCMH QA.
#'
#' @param .data_frame Output of \code{\link[pcmh]{.generate_summary_page}}.
#' @param .report_type A \code{Character} string of either "PCMH" or "Shared Savings".
#'
#' @return Returns a 1 x 6 \code{tibble} of the overview statistics.
#' @export
#'
#' @importFrom scales percent
#' @importFrom tibble tribble
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .generate_overview_page(.data_frame, .report_type = "PCMH")
#' }
.generate_overview_page <- function(.data_frame, .report_type = "PCMH") {
  report_type = .report_type
  pass_number = sum(.data_frame$check == TRUE)
  fail_number = sum(.data_frame$check == FALSE)
  total = pass_number + fail_number
  pass_freq = pass_number / total
  fail_freq = fail_number / total
  out <- tibble::tribble(
    ~ report_type,
    ~ pass_number,
    ~ fail_number,
    ~ total,
    ~ pass_freq,
    ~ fail_freq,
    report_type,
    pass_number,
    fail_number,
    total,
    scales::percent(pass_freq, scale = 100),
    scales::percent(fail_freq, scale = 100)
  )
  return(tibble::as_tibble(out))
}
