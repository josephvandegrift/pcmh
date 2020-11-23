#' Checks
#'
#' This function is used to check a specific metric value from the \code{.pdf}
#'   PCMH report agains the same metric value in the oracle data.
#'
#' @param .metrics Output from \code{\link[pcmh]{extract_metrics}}.
#' @param .metric_data Output from \code{\link[pcmh]{import_metric_data}}.
#' @param .prvdr_num Specific provider number.
#' @param .metric Specific metric to be checked.
#' @param .page Specific page number the metric is on.
#'
#' @return Returns a \code{tibble} of \code{TRUE} if the value matched the data
#'   from oracle or a \code{FALSE} if it did not.
#' @export
#'
#' @importFrom dplyr near
#' @importFrom dplyr filter
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .checks(.metrics, .metric_data, .prvdr_num, .page, .metric)
#' }
.checks <-
  function(.metrics,
           .metric_data,
           .prvdr_num,
           .metric,
           .page) {
    df1 <- dplyr::filter(
      .metrics,
      .metrics$prvdr_num == .prvdr_num,
      .metrics$metric_var == .metric,
      .metrics$page == .page
    )
    df2 <- dplyr::filter(
      .metric_data,
      .metric_data$prvdr_num == .prvdr_num,
      .metric_data$mtrc_cd == .metric
    )
    out <- dplyr::near(df1[c("dnmtr_num",
                             "nmrtr_num",
                             "rate",
                             "avg")], df2[c("dnmtr_num",
                                            "nmrtr_num",
                                            "rate",
                                            "rate")])
    out <- cbind(df1[1:5], out)
    return(tibble::as_tibble(out))
  }
