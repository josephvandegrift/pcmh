#' Extract Metrics
#'
#' This function uses \code{\link[pcmh]{.get_metric}} function to extract each
#'   metric from a \code{.pdf} PCMH report and arrange them into a \code{tibble}.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.
#'
#' @return Returns a \code{tibble} or metric data.
#' @export
#'
#' @examples
#' \dontrun{
#' extract_metrics(.data_frame)
#' }
extract_metrics <- function(.data_frame) {
  out <-
  return(tibble::as_tibble(out))
}
