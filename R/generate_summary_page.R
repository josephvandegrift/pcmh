#' Generate Summary Page
#'
#' This function generates the summary page for the PCMH Report QA output file.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{check_report}}.
#'
#' @return Returns an n x 2 \code{tibble} of \code{prvdr_num} and \code{TRUE} if
#'   all the metrics are correct and \code{FALSE} if 1 or more are missing/incorrect.
#' @export
#'
#' @importFrom tibble as_tibble
#' @importFrom furrr future_pmap_dfr
#'
#' @examples
#' \dontrun{
#' .generate_summary_page(.data_frame)
#' }
.generate_summary_page <- function(.data_frame) {
  .prvdr_num <- unique(.data_frame$prvdr_num)
  out <- furrr::future_pmap_dfr(list(.prvdr_num),
                                ~ pcmh::.all_true(.data_frame, ..1))
  out <- cbind(.prvdr_num, out)
  names(out) <- c("prvdr_num", "check")
  return(tibble::as_tibble(out))
}
