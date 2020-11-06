#' Read pdf_data
#'
#' Uses \code{\link[fs]{dir_ls}} to create a \code{list} of the \code{.pdf} PCMH
#'   Report filepaths.
#'   Then uses \code{\link[furrr]{future_map}} to map \code{\link[pdftools]{pdf_data}}
#'   to read in each PCMH Report.
#'
#' @param path Filepath to a directory of  \code{.pdf} PCMH Reports.
#'
#' @return Returns a \code{list} of \code{lists}. Each \code{element} of the
#'   \code{list} refers to a PCMH Report and is a \code{list} of \code{dataframes},
#'   each of which refers to a single page from the PCMH Report.
#' @export
#'
#' @importFrom fs dir_ls
#' @importFrom furrr future_map
#' @importFrom pdftools pdf_data
#' @examples
#' \dontrun{
#' read_pdf_data(hi)
#' }
read_pdf_data <- function(path) {
  files <- fs::dir_ls(path)
  out <- furrr::future_map(files, pdftools::pdf_data)
  return(out)
}
