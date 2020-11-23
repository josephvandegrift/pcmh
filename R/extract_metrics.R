#' Extract Metrics
#'
#' This function uses \code{\link[pcmh]{.get_metric}} function to extract each
#'   metric from a \code{.pdf} PCMH report and arrange them into a \code{tibble}.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.
#' @param .met_desc A \code{dataframe} containing the metric descriptions read in
#'   using \code{\link[pcmh]{.read_metric_data}}.
#'
#' @return Returns a \code{tibble} of metric data.
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom stringr str_detect
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' extract_metrics(.data_frame)
#' }
extract_metrics <- function(.data_frame, .met_desc) {
  .params <- dplyr::filter(.data_frame,
                           stringr::str_detect(.data_frame$text, "\\b_{5,9}\\b"))
  .params <- list(.params$page, .params$x, .params$y)
  out <- furrr::future_pmap_dfr(.l = .params,
                                .f = ~ pcmh::.get_metric(.data_frame,
                                                          ..1,
                                                          ..2,
                                                          ..3))
  out <- cbind(prvdr_num = .data_frame$prvdr_num[1], .met_desc, out)
  return(tibble::as_tibble(out))
}
