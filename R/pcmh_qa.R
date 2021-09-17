#' PCMH QA
#'
#' This function is meant to complete an entire PCMH QA run in a single function.
#'
#' @param .pcmh_report_dir A \code{filepath} to the directory of PCMH
#'   \code{.pdf} reports.
#' @param .metric_data_dir A \code{filepath} to the directory for metric data.
#' @param .metric_data_regexp A \code{regexp} for which metric data file to be
#'   read in.
#' @param .report_type One of \code{"pcmh20"}, \code{"pool20"}, or
#'   \code{"pcmh21"}.
#' @param .out_path A \code{filepath} to the location output will be saved.
#'   Only supports \code{.xlsx} files and only writes if an input is supplied.
#'   Defaults to \code{NA}.
#'
#' @return Retrurns a \code{list} of 2 \code{dataframes}.
#' @export
#'
#' @importFrom openxlsx write.xlsx
#' @importFrom future plan
#' @importFrom future multisession
#' @importFrom furrr future_map_dfr
#'
#' @examples
#' \dontrun{
#' pcmh_qa(.pcmh_report_dir,
#'   .metric_data_dir,
#'   .metric_data_regexp,
#'   .report_type,
#'   .out_path = NA)
#' }
pcmh_qa <- function(.pcmh_report_dir,
                    .metric_data_dir,
                    .metric_data_regexp,
                    .report_type,
                    .out_path = NA) {
  # If .out_path supplied, get file extension
  if (!is.na(.out_path)) {
    if (pcmh::get_ext(.out_path) != "xlsx") {
      stop(".out_path only supports .xlsx documents")
    }
  }

  # Check that .report_type is supported
  if (.report_type != "pcmh20" &
      .report_type != "pcmh21" &
      .report_type != "pool20") {
    stop(".report_type must be one of 'pcmh20', 'pcmh21', or 'pool20'")
  }

  # Initialize crosswalks
  crosswalk <-
    list(pcmh20 = pcmh20_crosswalk,
         pool20 = pool20_crosswalk,
         pcmh21 = pcmh21_crosswalk)

  # Select crosswalk based on .report_type
  crosswalk <-
    crosswalk[[eval(.report_type)]]

  # Remove metrics that don't have a variable/coordinates
  crosswalk <-
    crosswalk[which(
      !is.na(crosswalk$variable) &
        !is.na(crosswalk$x) &
        !is.na(crosswalk$x_min) &
        !is.na(crosswalk$x_max) &
        !is.na(crosswalk$y) &
        !is.na(crosswalk$y_min) &
        !is.na(crosswalk$y_max)
    ), ]

  # Read in/clean metric data
  metric_data <-
    pcmh::import_metric_data(.metric_data_dir,
                             .metric_data_regexp,
                             col_types = c(.default = "c"))

  # Read in PCMH reports
  future::plan(future::multisession)

  reports <-
    pcmh::import_pdf_data(.pcmh_report_dir,
                          regexp = ".pdf$")

  # Generate Detail
  detail <-
    furrr::future_map_dfr(reports,
                          ~ {
                            report <- .x
                            furrr::future_map_dfr(1:nrow(crosswalk),
                                                  ~ pcmh::generate_detail(report,
                                                                          metric_data,
                                                                          crosswalk[.,]))
                          })

  # Generate Summary
  summary <-
    furrr::future_map_dfr(detail$prvdr_num |>
                            unique(),
                          ~ pcmh::generate_summary(detail, .))

  # Filter summary/detail to only missing/mismatches
  out <-
    list(Summary =
           summary[which(summary$mismatch_type != "Match"),],
         Detail =
           detail[which(detail$mismatch_type %in% c("Missing", "Mismatch")),])

  # Rename output column names
  names(out[[1]]) <-
    c("Provider Number",
      "Mismatch Type")

  names(out[[2]]) <-
    c(
      "Provider Number",
      "Report Section",
      "Metric Description",
      "Variable",
      "Page Number",
      "Report Value",
      "Data Value",
      "Mismatch Type"
    )


  # Save output to file if applicable
  if (!is.na(.out_path) &
      pcmh::get_ext(.out_path) == "xlsx") {
    openxlsx::write.xlsx(out,
                         .out_path)

  }

  # Return output
  return(out)
}
