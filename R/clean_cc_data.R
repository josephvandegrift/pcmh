#' Clean Care Category Data
#'
#' This function is part of \code{\link[pcmh]{import_cc_data}} and cleans and
#'   formats the data for comparison.
#'
#' @param data_frame A \code{dataframe} of care category data.
#' @param n A positive \code{intiger} to be passed to \code{\link[pcmh]{round_df}}.
#'
#' @return Returns a \code{tibble} of clean, formatted care category data.
#' @export
#'
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .clean_cc_data(data_frame)
#' }
.clean_cc_data <- function(data_frame, n = 0) {
  out <- pcmh::round_df(data_frame, n)
  return(tibble::as_tibble(out))
}
