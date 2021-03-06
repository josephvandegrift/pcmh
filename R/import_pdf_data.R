#' Import pdf_data
#'
#' This function is a wrapper around \code{\link[pcmh]{read_pdf_data}} and
#'   \code{\link[pcmh]{clean_pdf_data}}.
#'   This function reads in the \code{.pdf} PCMH reports and cleans the data
#'   for future analysis.
#'
#' @param .directory A path to a directory containing the \code{.pdf} PCMH
#'   reports.
#' @param ... Extra parameters to be passed to \code{\link[pcmh]{read_pdf_data}}.
#'
#' @return Returns a \code{list} of \code{dataframes}. One for each \code{.pdf}
#'   PCMH report in the directory.
#' @export
#'
#' @importFrom furrr future_map
#' @importFrom furrr future_map2
#' @importFrom tibble tibble
#'
#' @examples
#' \dontrun{
#' import_pdf_data(~Documents)
#' }
import_pdf_data <- function(.directory, ...) {
  # Read in reports
  .reports <-
    pcmh::read_pdf_data(.directory, ...)
  # Remove paginations
  # .reports <-
  #   furrr::future_map(.reports,
  #          ~ pcmh::.remove_pagination(., .n = 35))
  # Clean report data
  .reports <-
    furrr::future_map(.reports, pcmh::clean_pdf_data)
  # Extract provider numbers from filenames
  .prvdr_num <-
    regmatches(names(.reports), regexpr("\\d{9}", names(.reports)))
  # Map provider numbers to respective report
  out <-
    furrr::future_map2(.prvdr_num,
                       .reports,
                       ~ tibble::tibble(prvdr_num = .x,
                               .y))

  return(out)
}
