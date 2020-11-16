#' Get Metric
#'
#' This function is a wrapper around \code{\link[pcmh]{.filter_pdf_data}} and
#'   extracts the specific \code{.metric} input.
#'
#' @param .data_frame A \code{dataframe} you wish to extract data from.
#' @param ... Extra parameters to be passed to \code{\link[pcmh]{.filter_pdf_data}}.
#'
#' @return Returns a \code{tibble} of the a specific metric.
#' @export
#'
#' @importFrom stringr str_detect
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @importFrom dplyr filter
#' @importFrom readr parse_number
#'
#' @examples
#' \dontrun{
#' .get_metric(.metric)
#' }
.get_metric <- function(.data_frame, ...) {
  out <- pcmh::.filter_pdf_data(.data_frame, ...)
  out <- dplyr::filter(out, stringr::str_detect(out$text, "\\d+"))
  out <- tibble(dnmtr_num = as.numeric(out[[3, 1]]),
                nmrtr_num = as.numeric(out[[1, 1]]),
                rate = readr::parse_number(out[[2, 1]]))
  return(tibble::as_tibble(out))
}
