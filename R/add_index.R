#' Add Index
#'
#' Adds an \code{index} column to each of the elements of a \code{lsit}. Meant to
#'   be used after you read in \code{.pdf} PCMH reports.
#'
#' @param .pdf_data A \code{list} of \code{dataframes} read in with
#'   \code{\link[pdftools]{pdf_data}}.
#'
#' @return Returns \code{.pdf_data} with an \code{index} column added to each
#'   element.
#' @export
#'
#' @importFrom furrr future_map
#'
#' @examples
#' \dontrun{
#' .add_index(list)
#' }
.add_index <- function(.pdf_data) {
  out <- furrr::future_map(.x = .pdf_data, cbind(.x, 1:nrow(.x)))
  return(out)
}
