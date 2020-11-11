#' Filter pdf_data
#'
#' This is a helper function to be used in conjunction with \code{\link[pdftools]{pdf_data}}
#'   and is used to extract the data from a \code{.pdf} file based on a certain
#'   \code{x} and \code{y} range input.
#'
#' @param .data_frame \code{Dataframe} read in with \code{\link[pdftools]{pdf_data}}
#'   that is to be filtered.
#' @param .page Page number.
#' @param x_min Lower bound of \code{x} range.
#' @param x_max Upper bound of \code{x} range.
#' @param y_min Lower bound of \code{y} range.
#' @param y_max Upper bound of \code{y} range.
#'
#' @return If text exists in the \code{x} and \code{y} range, returns the text
#'   as a \code{tibble}, else returns \code{-99} as a \code{tibble}.
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom dplyr if_else
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .filter_pdf_data(df, 0, 50, 0, 150)
#' }
.filter_pdf_data <- function(.data_frame, .page, x_min, x_max, y_min, y_max) {
  out <- dplyr::filter(.data_frame,
                       .data_frame["page"] == .page &
                       .data_frame["x"] %in% (x_min:x_max) &
                       .data_frame["y"] %in% (y_min:y_max))
  out <- tibble::tibble(text = ifelse(length(out[["text"]]) == 0,
                                              -99,
                                              out[["text"]]))
  return(tibble::as_tibble(out))
}
