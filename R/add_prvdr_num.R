#' Add prvdr_num
#'
#' This function adds a \code{prvdr_num} column to a \code{dataframe}. Helper
#'   function meant to be used to clean the \code{.pdf} PCMH reports.
#'
#' @param .data_frame A \code{dataframe}.
#'
#' @return Returns \code{.data_frame} as a \code{tibble} with an added
#'   \code{prvdr_num} column.
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .add_prvdr_num(.data_frame)
#' }
.add_prvdr_num <- function(.data_frame) {
  out <- pcmh::.filter_pdf_data(
    .data_frame,
    .page = 1,
    x_min = 1,
    x_max = 400,
    y_min = 0,
    y_max = 10
  )
  out <- out["text"]
  out <- stringr::str_subset(out, "\\d{9}")
  out <- cbind(as.numeric(out), .data_frame)
  return(tibble::as_tibble(out))
}
