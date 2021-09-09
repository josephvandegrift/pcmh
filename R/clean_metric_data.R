#' Clean Metric Data
#'
#' This function takes the metric data read in by \code{\link[pcmh]{.read_metric_data}}
#'   and formats the data to be passed to \code{\link[pcmh]{generate_detail}}.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{.read_metric_data}}.
#'
#' @return Returns a clean version of \code{.data_frame}.
#' @export
#'
#'
#' @examples
#' \dontrun{
#' .clean_metric_data(.data_frame)
#' }
.clean_metric_data <- function(.data_frame) {
  # Initialize output
  out <- .data_frame

  # Update column names to be lowercase
  names(out) <-
    names(out) |>
    tolower()

  # Replace flags with correct letter
  out <-
    lapply(out,
           gsub,
           pattern = "^Pass$|^1-10$",
           replacement = "G") |>
    lapply(gsub,
           pattern = "^Fail$|^36\\+$",
           replacement = "R") |>
    lapply(gsub,
           pattern = "^N<25$|^[.]$",
           replacement = "A") |>
    lapply(gsub,
           pattern = "^11-35$",
           replacement = "Y")

  # Replace 1 and 0 with G and R only in flag columns
  out[grepl("flag", names(out))] <-
    lapply(out[grepl("flag", names(out))],
           gsub,
           pattern = "^1$",
           replacement = "G")

  out[grepl("flag", names(out))] <-
    lapply(out[grepl("flag", names(out))],
           gsub,
           pattern = "^0$",
           replacement = "R")

  # Return output
  return(as.data.frame(out))

}
