#' Read Metric Data
#'
#' This function uses \code{\link[vroom]{vroom}} to read in the \code{.csv}
#'   oracle data to be checked against the \code{.pdf} PCMH report data.
#'
#' @param .path Filepath to the directory of metric data.
#' @param ... Extra parameters to be passed to \code{\link[fs]{dir_ls}}.
#'
#' @return Returns a \code{tibble} of the \code{.csv} oracle data
#' @export
#'
#' @importFrom vroom vroom
#' @importFrom fs dir_ls
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .read_metric_data(.path)
#' }
.read_metric_data <- function(.path, ...) {
  .file <- fs::dir_ls(.path, ...)
  out <- vroom::vroom(.file)
  return(tibble::as_tibble(out))
}
