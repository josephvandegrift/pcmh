#' All True
#'
#' Helper function for \code{\link[pcmh]{.generate_summary_page}}.
#'
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{check_report}}.
#' @param .prvdr_num A Provider Number as a \code{numeric} value.
#'
#' @return Returns a tibble of \code{.prvdr_num} and either \code{TRUE} or
#'   \code{FALSE}.
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
.all_true <- function(.data_frame, .prvdr_num) {
  out <- .data_frame[.data_frame$prvdr_num == .prvdr_num, 6:9]
  out <- all(out == TRUE)
  out <- cbind(prvdr_num = .prvdr_num,
               check = out)
  return(tibble::as_tibble(out))
}
