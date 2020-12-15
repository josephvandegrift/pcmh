#' Clean Care Category Data
#'
#' This function is part of \code{\link[pcmh]{import_cc_data}} and cleans and
#'   formats the data for comparison.
#'
#' @param data_frame A \code{dataframe} of care category data.
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
.clean_cc_data <- function(data_frame) {
  out <- pcmh::round_df(data_frame, 2)
  return(tibble::as_tibble(out))
}
