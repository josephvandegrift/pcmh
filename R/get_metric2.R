#' Get metric2
#'
#' This is an updated version of \code{\link[pcmh]{.get_metric}} that uses logic
#'   to seach for the fraction line in each metric then extracts the \code{dnmtr_num},
#'    \code{nmrtr_num}, \code{rate}, \code{avg}, and \code{state} values.
#'   Also works when
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.
#' @param .page Page number of fraction line of metric.
#' @param .x X value of fraction line of metric.
#' @param .y Y value of fraction line of metric.
#'
#' @return Returns a 1 x 5 \code{tibble} of the metric data.
#' @export
#'
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @importFrom readr parse_number
#'
#' @examples
.get_metric2 <- function(.data_frame, .page, .x, .y) {
  .num <- pcmh::.filter_pdf_data(.data_frame,
                                 .page,
                                 .x + 1,
                                 .x + 50,
                                 .y - 25,
                                 .y)
  .den <- pcmh::.filter_pdf_data(.data_frame,
                                 .page,
                                 .x + 1,
                                 .x + 50,
                                 .y,
                                 .y + 25)
  .rate <- pcmh::.filter_pdf_data(.data_frame,
                                  .page,
                                  .x + 65,
                                  .x + 100,
                                  .y - 10,
                                  .y + 10)
  .avg <- pcmh::.filter_pdf_data(.data_frame,
                                 .page,
                                 .x + 100,
                                 max(.data_frame$x),
                                 .y - 22,
                                 .y)
  .state <- pcmh::.filter_pdf_data(.data_frame,
                                   .page,
                                   .x + 100,
                                   max(.data_frame$x),
                                   .y,
                                   .y + 20)
  out <- tibble(
    dnmtr_num = readr::parse_number(.num$text),
    nmrtr_num = readr::parse_number(.den$text),
    rate = readr::parse_number(.rate$text),
    avg = readr::parse_number(.avg$text),
    state = readr::parse_number(.state$text)
  )
  return(tibble::as_tibble(out))
}
