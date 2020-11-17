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
  out <- dplyr::arrange(.data_frame, .data_frame$y)
  out <- pcmh::.filter_pdf_data(out, ...)
  out <- dplyr::filter(out, stringr::str_detect(out$text, "\\d+"))
  out <- tibble(dnmtr_num = readr::parse_number(out[[5, 1]]),
                nmrtr_num = readr::parse_number(out[[1, 1]]),
                rate = readr::parse_number(out[[3, 1]]),
                avg = readr::parse_number(out[[2, 1]]),
                state = readr::parse_number(out[[4, 1]]))
  return(tibble::as_tibble(out))
}
