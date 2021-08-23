#' Get metric2
#'
#' This function is an alternate of \code{\link[pcmh]{.get_metric}} used to
#'   extract metrics without a bar graph from a \code{PCMH} report.
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
#' \dontrun{
#' .get_mettic(.data_frame, .page, .x, .y)
#' }
.get_metric2 <- function(.data_frame, .page, .x, .y) {
  .num <-
    pcmh::.filter_pdf_data(.data_frame,
                           .page,
                           .x - 10,
                           .x + 50,
                           .y - 25,
                           .y - 1)
  .den <-
    pcmh::.filter_pdf_data(.data_frame,
                           .page,
                           .x - 10,
                           .x + 50,
                           .y + 1,
                           .y + 25)
  .rate <-
    pcmh::.filter_pdf_data(.data_frame,
                           .page,
                           .x + 70,
                           .x + 125,
                           .y - 10,
                           .y + 10)
  .avg <-
    .rate
  .state <-
    .rate

  out <- tibble(
    dnmtr_num = readr::parse_number(.den$text),
    nmrtr_num = readr::parse_number(.num$text),
    rate = readr::parse_number(.rate$text),
    avg = readr::parse_number(.avg$text),
    state = readr::parse_number(.state$text)
  )
  return(tibble::as_tibble(out))
}
