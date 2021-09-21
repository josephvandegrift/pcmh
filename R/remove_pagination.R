#' Remove Pagination
#'
#' This function removes pages with from a PCMH report with less than \code{.n}
#'   rows read in by \code{\link[pcmh]{read_pdf_data}} before it is cleaned.
#'
#' @param .report A \code{list} of \code{dataframes} read in by
#'   \code{\link[pcmh]{read_pdf_data}}.
#' @param .n A positive \code{intiger}.
#'
#' @return Returns a \code{list} of \code{dataframes}.
#' @export
#'
#' @examples
#' \dontrun{
#' .remove_pagination(.report)
#' }
.remove_pagination <- function(.report, .n) {
  Filter(function(x) nrow(x) > .n, .report)
}
