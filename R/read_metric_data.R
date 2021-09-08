#' Read Metric Data
#'
#' This function uses \code{\link[vroom]{vroom}} to read in the \code{.csv}
#'   oracle data to be checked against the \code{.pdf} PCMH report data.
#'
#' @param .path Filepath to the directory of metric data.
#' @param ... Extra parameters to be passed to \code{\link[fs]{dir_ls}}.
#'
#' @return Returns a \code{tibble} of the \code{.csv} oracle data
#' @export
#'
#' @importFrom openxlsx read.xlsx
#' @importFrom fs dir_ls
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .read_metric_data(.path)
#' }
.read_metric_data <- function(.path, ...) {
  # Get filepath from directory
  filepath <- fs::dir_ls(.path, ...)

  # Check that length of file = 1
  if(length(filepath) == 0) {
    return("Inputs didn't return a filepath")
  } else if(length(filepath) > 1) {
    return("Inputs returned more than 1 filepath")
  } else if(length(filepath) == 1) {
    # Check for file extension
    ext <- pcmh::get_ext(filepath)
  }

  # Read in data based on file extension
  if(ext == "csv") {
    out <-
      vroom::vroom(filepath)
  } else if(ext == "xlsx") {
    out <-
      openxlsx::read.xlsx(filepath)
  } else {
    return("File extension not supported")
  }


  return(tibble::as_tibble(out))
}
