#' Import metric_data
#'
#' This function is a wrapper around \code{\link[pcmh]{.read_metric_data}} and
#'   \code{\link[pcmh]{.clean_metric_data}}.
#'
#'
#' @param .path A \code{filepath} to the \code{.csv} metric data.
#' @param ... Extra parameters to be passed to \code{\link[pcmh]{.read_metric_data}}.
#'
#' @return Returns \code{.path} as a \code{tibble} of clean data.
#' @export
#'
#' @examples
#' \dontrun{
#' import_metric_data(.path)
#' }
import_metric_data <- function(.path, ...) {
  out <- pcmh::.read_metric_data(.path, ...)
  out <- pcmh::.clean_metric_data(out)
  return(tibble::as_tibble(out))
}
