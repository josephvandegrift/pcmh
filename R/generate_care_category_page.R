#' Generate Care Category Page
#'
#' This fucntion maps \code{\link[pcmh]{.check_care_categories}} to generate an
#'   output for PCMH QA.
#'
#' @param .care_categories A \code{dataframe} read in by.
#' @param .care_categories_data A \code{dataframe} read in by \code{\link[pcmh]{import_cc_data}}.
#'
#' @return Returns a \code{tibble}.
#' @export
#'
#' @importFrom furrr future_pmap_dfr
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' generate_care_category_page(.care_categories, .care_categories_data)
#' }
generate_care_category_page <- function(.care_categories, .care_categories_data) {
  prvdr_nums <- unique(.care_categories$`Provider Number`)
  out <- furrr::future_pmap_dfr(
    list(prvdr_nums),
    ~ pcmh::.check_care_categories(.care_categories,
                                   .care_categories_data,
                                   ..1))
  return(tibble::as_tibble(out))
}
