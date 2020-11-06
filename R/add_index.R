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
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .add_index(list)
#' }
.add_index <- function(.data_frame) {
  out <- cbind(.data_frame, index = 1:nrow(.data_frame))
  return(tibble::as_tibble(out))
}
