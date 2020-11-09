#' Filter pdf_data
#'
#' This is a helper function to be used in conjunction with \code{\link[pdftools]{pdf_data}}
#'   and is used to extract the data from a \code{.pdf} file based on a certain
#'   \code{x} and \code{y} range input.
#'
#' @param .data_frame \code{Dataframe} read in with \code{\link[pdftools]{pdf_data}}
#'   that is to be filtered.
#' @param x_min Lower bound of \code{x} range.
#' @param x_max Upper bound of \code{x} range.
#' @param y_min Lower bound of \code{y} range.
#' @param y_max Upper bound of \code{y} range.
#'
#' @return Returns a subset of the input \code{dataframe} as a \code{tibble.}
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .filter_pdf_data(df, 0, 50, 0, 150)
#' }
.filter_pdf_data <- function(.data_frame, x_min, x_max, y_min, y_max) {
  out <- dplyr::filter(.data_frame,
                       .data_frame["x"] %in% (x_min:x_max) &
                       .data_frame["y"] %in% (y_min:y_max))
  return(tibble::as_tibble(out))
}
