#' Add Page Number
#'
#' Adds a \code{page} column to a \code{dataframe}. Helper function to be used
#'   to clean the \code{.pdf} PCMH reports data.
#'
#' @param .data_frame A \code{dataframe}.
#' @param .page An \code{integer}.
#'
#' @return Returns \code{.data_frame} as a \code{tibble} with a \code{page}
#'   column added.
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .add_page_numbers(dataframe)
#' }
.add_page_numbers <- function(.data_frame, .page) {
  out <- cbind(page = .page, .data_frame)
  return(tibble::as_tibble(out))
}
