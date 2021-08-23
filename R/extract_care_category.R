#' Extract Care Category
#'
#' This function uses \code{\link[furrr]{future_pmap_dfc}} to map
#'   \code{\link[pcmh]{.filter_pdf_data}} to extract the columns of data from
#'   the care category section of a \code{.pdf} PCMH report and arranges them
#'   into a \code{tibble}.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.
#'
#' @return Returns a \code{tibble} of care category data from a \code{.pdf}
#'   PCMH report.
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom stringr str_detect
#' @importFrom furrr future_pmap_dfc
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .extract_care_categry(.data_frame)
#' }
.extract_care_categry <- function(.data_frame) {
  .care_categories <- c(
    "Anesthesia",
    "Durable Medical Equipment",
    "Emergency Department",
    "Inpatient Hospital Facility",
    "Inpatient Professional",
    "Outpatient Imaging",
    "Outpatient Lab",
    "Outpatient Procedures",
    "Outpatient Professional",
    "Outpatient Surgery Facility",
    "Outpatient Surgery Professional",
    "Pharmaceuticals",
    "Other",
    "OVERALL"
  )
  .params <- dplyr::filter(
    .data_frame,
    .data_frame$page > 11,
    stringr::str_detect(.data_frame$text, "Beneficiar")
  )[2:4,]
  .params <- list(.params$page,
                  .params$x,
                  .params$y)
  out <- furrr::future_pmap_dfc(.params,
                                ~ .filter_pdf_data(.data_frame,
                                                   ..1,
                                                   ..2,
                                                   ..2+50,
                                                   ..3+13,
                                                   ..3+225))
  out <-
    tibble::tibble(
      "Provider Number" = .data_frame$prvdr_num[1],
      "Care Category" = .care_categories,
      "Claim Count" = readr::parse_number(out$text...1),
      "Claim Avg" = readr::parse_number(out$text...2),
      "Bene Avg" = readr::parse_number(out$text...3)
    )
  return(tibble::as_tibble(out))
}
