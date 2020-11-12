#' Get Metric
#'
#' This function is a wrapper around \code{\link[pcmh]{.filter_pdf_data}} and
#'   extracts the specific \code{.metric} input.
#'
#' @param .data_frame A \code{dataframe} you wish to extract data from.
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
.get_metric <- function(.data_frame, .metric) {
  .params <- list(
    .data_frame = .data_frame,
    .page = 4,
    x_min = 1,
    x_max = 10,
    y_min = 1,
    y_max = 10
  )
  out <- do.call(pcmh::.filter_pdf_data, .params)
  return(tibble::as_tibble(out))
}
