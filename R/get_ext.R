#' Get Extension
#'
#' This function takes a filepath as input and returns the extension as a
#'   \code{character string}.
#'
#' @param .filepath A \code{filepath}.
#'
#' @return Returns a \code{character string} of the file extension of \code{.filepath}.
#' @export
#'
#' @examples
get_ext <- function(.filepath) {
  # Make sure .filepath is a character
  path <- as.character(.filepath)

  # Split the filepath into basename and extension
  ext <- strsplit(basename(path), split = "\\.")[[1]]

  # Return extension
  return(ext[-1])
}

