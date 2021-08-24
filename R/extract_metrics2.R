#' Extract Metrics2
#'
#' This function is an updated version of \code{\link[pcmh]{extract_metrics}} that
#'   is compatible with the 2021 \code{PCMH} reports.
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
#' extract_metrics2(.data_frame)
#' }
extract_metrics2 <- function(.data_frame, .met_desc) {
  # Extract metrics without bar graphs
  .params <- dplyr::filter(.data_frame,
                           stringr::str_detect(.data_frame$text, "\\b_{5,9}\\b"),
                           .data_frame$page < 10)
  .params <- list(.params$page, .params$x, .params$y)
  out1 <- furrr::future_pmap_dfr(.l = .params,
                                .f = ~ pcmh::.get_metric2(.data_frame,
                                                         ..1,
                                                         ..2,
                                                         ..3))
  # Extract metrics containing bar graphs
  .params <- dplyr::filter(.data_frame,
                           stringr::str_detect(.data_frame$text, "\\b_{5,9}\\b"),
                           .data_frame$page > 9)
  .params <- list(.params$page, .params$x, .params$y)
  out2 <- furrr::future_pmap_dfr(.l = .params,
                                .f = ~ pcmh::.get_metric(.data_frame,
                                                          ..1,
                                                          ..2,
                                                          ..3))
  # Piece together output
  out <- rbind(out1, out2)
  out <- cbind(prvdr_num = .data_frame$prvdr_num[1], .met_desc, out)
  return(tibble::as_tibble(out))
}
