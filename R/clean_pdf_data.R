#' Clean pdf_data
#'
#' This function is meant to be used in conjunction with \code{\link[pcmh.qa]{read_pdf_data}}
#'   to combine each page of the PCMH reports into a single \code{tibble} and
#'   to add a \code{page} and \code{index} variable to the \code{tibble}.
#'
#' @param .list A \code{list} that refers to a single PCMH report where each
#'   \code{element} is a single page of the report.
#'
#' @return Returns \code{.list} as a single \code{tibble} with an added
#'   \code{page} and \code{index} variable.
#' @export
#'
#' @examples
clean_pdf_data = function(.list) {

}
