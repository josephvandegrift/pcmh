#' Read Oracle Data
#'
#' This function reads in the \code{.csv} oracle data to be checked against the
#'   \code{.pdf} PCMH report data.
#'
#' @param .path Filepath to the oracle data.
#' @param ... Extra parameters to be passed to \code{\link[vroom]{vroom}}.
#'
#' @return
#' @export
#'
#' @importFrom vroom vroom
#' @importFrom tibble as_tibble
#'
#' @examples
.read_oracle_data <- function(.path, ...) {
  out <- vroom::vroom(.path, ...)
  return(tibble::as_tibble(out))
}
