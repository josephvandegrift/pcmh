#' Clean pdf_data
#'
#' This function takes a \code{list} of \code{dataframes} and adds an \code{index}
#'   and \code{page} column then reduces them into a single \code{tibble}. This
#'   function is a wrapper around \code{\link[pcmh]{.add_page_numbers}} and
#'   \code{\link[pcmh]{.add_index}} and is meant to be used after you have read
#'   in the PCMH reports using \code{\link[pcmh]{read_pdf_data}}.
#'
#' @param .list A \code{list} of \code{dataframes} read in with
#'   \code{\link[pcmh]{read_pdf_data}}.
#'
#' @return Returns \code{.list} as a single \code{tibble} with a \code{page} and
#'   \code{index} column added to it.
#' @export
#'
#' @importFrom furrr future_map_dfr
#' @importFrom furrr future_map2
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' clean_pdf_data(.list)
#' }
clean_pdf_data = function(.list) {
  page_numbers <- 1:length(.list)
  out <- furrr::future_map2(.list, page_numbers, pcmh::.add_page_numbers)
  out <- furrr::future_map_dfr(out, pcmh::.add_index)
  return(tibble::as_tibble(out))
}
