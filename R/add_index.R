#' Add Index
#'
#' Adds an \code{index} column to a \code{dataframe}. Helper function to be used
#'   to clean the \code{.pdf} PCMH reports data.
#'
#' @param .data_frame A \code{dataframe}.
#'
#' @return Returns \code{.data_frame} as a \code{tibble} with an \code{index}
#'   column added.
#' @export
#'
#' @importFrom furrr future_map
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .add_index(dataframe)
#' }
.add_index <- function(.data_frame) {
  out <- cbind(.data_frame, index = 1:nrow(.data_frame))
  return(tibble::as_tibble(out))
}
