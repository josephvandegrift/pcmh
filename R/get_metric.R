#' Get Metric
#'
#' This function is a wrapper around \code{\link[pcmh]{.filter_pdf_data}} and
#'   extracts the specific \code{.metric} input.
#'
#' @param .metric Input for which metric to extract.
#'
#' @return Returns a \code{tibble} of the specified \code{.metric}.
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .get_metric(.metric)
#' }
.get_metric <- function(.metric) {
  .params <- c(1, 2, 3, 4)
  out <- pcmh::.filter_pdf_data(.params)
  return(tibble::as_tibble(out))
}
