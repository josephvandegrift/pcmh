#' Clean metric_data
#'
#' This function takes the metric data read in by \code{\link[pcmh]{.read_metric_data}}
#'   and uses \code{\link[janitor]{clean_names}} to clean the variable names.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{.read_metric_data}}.
#'
#' @return Returns a \code{.data_frame} as a \code{tibble} with clean variable
#'   names.
#' @export
#'
#' @importFrom janitor clean_names
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate
#'
#' @examples
#' \dontrun{
#' .clean_metric_data(.data_frame)
#' }
.clean_metric_data <- function(.data_frame) {
  out <- janitor::clean_names(.data_frame)
  out["dnmtr_num"] <- round(out["dnmtr_num"], 1)
  return(tibble::as_tibble(out))
}
