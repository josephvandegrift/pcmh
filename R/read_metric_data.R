#' Read Metrics Data
#'
#' This function uses \code{\link[vroom]{vroom}} to read in the \code{.csv}
#'   oracle data to be checked against the \code{.pdf} PCMH report data.
#'
#' @param .path Filepath to the oracle data.
#' @param ... Extra parameters to be passed to \code{\link[vroom]{vroom}}.
#'
#' @return Returns a \code{tibble} of the \code{.csv} oracle data
#' @export
#'
#' @importFrom vroom vroom
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .read_oracle_data(.path)
#' }
.read_metric_data <- function(.path, ...) {
  out <- vroom::vroom(.path, ...)
  return(tibble::as_tibble(out))
}
