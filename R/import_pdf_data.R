#' Import pdf_data
#'
#' This function is a wrapper around \code{\link[pcmh]{read_pdf_data}} and
#'   \code{\link[pcmh]{clean_pdf_data}}.
#'   This function reads in the \code{.pdf} PCMH reports and cleans the data
#'   for future analysis.
#'
#' @param .directory A path to a directory containing the \code{.pdf} PCMH
#'   reports.
#'
#' @return Returns a \code{list} of \code{dataframes}. One for each \code{.pdf}
#'   PCMH report in the directory.
#' @export
#'
#' @importFrom furrr future_map
#'
#' @examples
#' \dontrun{
#' import_pdf_data(~Documents)
#' }
import_pdf_data <- function(.directory) {
  out <- pcmh::read_pdf_data(.directory)
  out <- furrr::future_map(out, pcmh::clean_pdf_data)
  return(out)
}
