#' Checks
#'
#' This function is used to check a specific metric value from the \code{.pdf}
#'   PCMH report agains the same metric value in the oracle data.
#'
#' @param .metrics Output from \code{\link[pcmh]{extract_metrics}}.
#' @param .metric_data Output from \code{\link[pcmh]{import_metric_data}}.
#' @param .prvdr_num Specific provider number.
#' @param .metric Specific metric to be checked.
#'
#' @return Returns a \code{tibble} of \code{TRUE} if the value matched the data
#'   from oracle or a \code{FALSE} if it did not.
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .checks(.metrics, .metric_data, .prvdr_num, .page, .metric)
#' }
.checks <- function(.metrics, .metric_data, .prvdr_num, .metric) {
  df1 <- dplyr::filter(.metrics,
                       .metrics$prvdr_num == .prvdr_num,
                       .metrics$metric_var == .metric)
  df2 <- dplyr::filter(.metric_data,
                       .metric_data$prvdr_num == .prvdr_num,
                       .metric_data$mtrc_cd == .metric)
  out <- df1[c("dnmtr_num", "nmrtr_num")] == df2[c("dnmtr_num", "nmrtr_num")]
  return(tibble::as_tibble(out))
}
