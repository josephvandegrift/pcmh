#' Check Metrics
#'
#' This function is a wrapper around \code{\link[pcmh]{.checks}}.
#'   This function uses \code{\link[furrr]{furure_pmap_dfr}} to map the
#'   \code{\link[pcmh]{.checks}} function to each of the 26 metrics extraced
#'   from \code{\link[pcmh]{extract_metrics}}.
#'
#' @param .metrics Output from \code{\link[pcmh]{extract_metrics}}.
#' @param .metric_data Output from \code{\link[pcmh]{import_metric_data}}.
#'
#' @return Returns a \code{tibble} of \code{TRUE} and \code{FALSE} for each
#'   metric check.
#' @export
#'
#' @importFrom tibble as_tibble
#' @importFrom furrr future_pmap_dfr
#'
#' @examples
#' \dontrun{
#' check_metrics(.metrics, .metric_data)
#' }
check_metrics <- function(.metrics, .metric_data) {
  .params <- list(.metrics$prvdr_num,
                  .metrics$metric_var,
                  .metrics$page)
  out <- furrr::future_pmap_dfr(.params,
                                ~ pcmh::.checks(.metrics,
                                                .metric_data,
                                                ..1,
                                                ..2,
                                                ..3))
  return(tibble::as_tibble(out))
}
