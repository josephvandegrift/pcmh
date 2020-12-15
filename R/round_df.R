#' Round Data Frame
#'
#' This function uses \code{\link{pcmh}{round2}} to round each of the \code{numeric}
#'   columns in a dataframe.
#'
#' @param data_frame A \code{dataframe} with \code{numeric} columns.
#' @param n A positive \code{intiger} to round to.
#'
#' @return Returns a \code{tibble} of with rounded \code{numeric} columns.
#' @export
#'
#' @examples
#' \dontrun{
#' round_df(data_frame, n = 0)
#' }
round_df <- function(data_frame, n = 0) {
  .cols <- vapply(data_frame, is.numeric, FUN.VALUE = logical(1))
  data_frame[, .cols] <- pcmh::round2(data_frame[, .cols], n)
  return(data_frame)
}
