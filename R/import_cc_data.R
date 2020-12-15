#' Import Care Category Data
#'
#' Reads and cleans the Care Category data.
#'
#' @param path \code{Filepath} to directory containing care category \code{.xlsx}.
#' @param ... Extra parameters to be passed to \code{\link[pcmh]{.read_metric_data}}.
#'
#' @return Returns a \code{tibble}
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .import_cc_data(path, ...)
#' }
import_cc_data <- function(path, ...) {
  out <- pcmh::.read_metric_data(path, ...)
  out <- pcmh::.clean_cc_data(out)
  return(tibble::as_tibble(out))
}
