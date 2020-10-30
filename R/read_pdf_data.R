#' Test Function
#'
#' Placeholder for future function
#'
#' @param path Filepath to the \code{.pdf} PCMH Reports
#'
#' @return Returns a \code{list} of \code{lists}. Each \code{element} of the
#'   \code{list} refers to a PCMH Report and is a \code{list} of \code{dataframes},
#'   each of which refers to a single page from the PCMH Report.
#' @export
#'
#' @importFrom fs dir_ls
#' @examples
#' \dontrun{
#' read_pdf_data(hi)
#' }
read_pdf_data <- function(path) {
  files <-
    fs::dir_ls(path)
}
