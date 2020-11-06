#' Add Page Numbers
#'
#' Adds a \code{page} column to each of the elements of a \code{lsit}. Meant to
#'   be used after you read in \code{.pdf} PCMH reports.
#'
#' @param .pdf_data A \code{list} of \code{dataframes} read in with
#'   \code{\link[pdftools]{pdf_data}}.
#'
#' @return Returns \code{.pdf_data} with a \code{page} column added to each
#'   element.
#' @export
#'
#' @importFrom furrr future_map2
#'
#' @examples
#' \dontrun{
#' .add_page_numbers(list)
#' }
.add_page_numbers <- function(.pdf_data) {
  out <- furrr::future_map2(.pdf_data, 1:length(.pdf_data), cbind(.x, .y))
  return(out)
}
