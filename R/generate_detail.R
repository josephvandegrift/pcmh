#' Generate Detail
#'
#' This function uses inputs from a crosswalk to generate the \code{detail}
#'   section of a \code{PCMH} QA report.
#'
#' @param .data_frame A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.
#' @param .clean_data Cleaned \code{dataframe} of metric data.
#' @param .crosswalk A \code{dataframe} of crosswalk for specific \code{PCMH} report type.
#'
#' @return Returns an \code{nx8} \code{dataframe} for \code{n} number of variables
#'   extraced from a \code{PCMH} report.
#' @export
#'
#' @importFrom readr parse_character
#'
#' @examples
#' \dontrun{
#' qa_report(data_frame, clean_data, crosswalk)
#' }
generate_detail <-
  function(.data_frame, .clean_data, .crosswalk) {
    # Initialize parameters
    params <-
      .crosswalk


    # Make sure variable is in lower case
    params["variable"] <-
      tolower(params["variable"])

    # Initialize detail
    detail <-
      cbind(.data_frame[1, "prvdr_num"],
            .crosswalk[c("page_name",
                        "metric",
                        "variable",
                        "page")])


    # Extract metric
    metric <-
      .data_frame[.data_frame$page == params$page + 1 &
                   .data_frame$x > params$x_min &
                   .data_frame$x < params$x_max &
                   .data_frame$y > params$y_min &
                   .data_frame$y < params$y_max, "text"]


    # Handle special cases and cases when nrow(metric) != 1
    if (params$variable %in% c("qual_pass_cnt",
                               "qual_pass_ss_count") &
        params$y > 500 &
        nrow(metric) == 2) {
      detail["text"] <-
        metric[1, "text"]
    } else if (params$variable %in% c("qual_elig_cnt - qual_pass_cnt",
                                      "qual_fail_ss_count") &
               params$y > 500 &
               nrow(metric) == 2) {
      detail["text"] <-
        metric[2, "text"]
    } else if (nrow(metric) == 0) {
      detail["text"] <-
        "Missing"
    } else if (nrow(metric) > 1) {
      detail["text"] <-
        "More than 1 metric returned"
    } else {
      detail["text"] <-
        metric["text"]
    }


    # Handle special cases for pctl_groups
    if (params$variable == "awc_pctl_group" &
        detail["text"] == "A") {
      params["variable"] <-
        "awc_text"
    } else if (params$variable == "edu_pctl_group" &
               detail["text"] == "A") {
      params["variable"] <-
        "edu_text"
    } else if (params$variable == "ahu_pctl_group" &
               detail["text"] == "A") {
      params["variable"] <-
        "ahu_text"
    }


    # Extract expected value from clean_data
    if (params$variable %in% names(.clean_data) == TRUE) {
      detail["expected_value"] <-
        as.character(.clean_data[which(.clean_data$reportid %in% .data_frame$prvdr_num),
                                 params$variable])
      # Special case of a calculated value
    } else if (params$variable %in% c("qual_elig_cnt - qual_pass_cnt")) {
      detail["expected_value"] <-
        (as.numeric(.clean_data[which(.clean_data$reportid %in% .data_frame$prvdr_num),
                                "qual_elig_cnt"]) -
           as.numeric(.clean_data[which(.clean_data$reportid %in% .data_frame$prvdr_num),
                                  "qual_pass_cnt"])) |>
        as.character()

    } else {
      detail["expected_value"] <-
        "Variable not in data"
    }



    # Handle special cases when qual_elig/pass_cnt == 0
    if (params$variable %in% c("qual_pass_cnt",
                               "qual_pass_ss_count") &
        params$y > 500 &
        detail["expected_value"] == 0) {
      detail["text"] <-
        "0"
    } else if (params$variable %in% c("qual_elig_cnt - qual_pass_cnt",
                                      "qual_fail_ss_count") &
               params$y > 500 &
               detail["expected_value"] == 0) {
      detail["text"] <-
        "0"
    }


    # Check for mismatch/missing
    if (detail["expected_value"] == "Variable not in data") {
      detail["mismatch_type"] <-
        detail["expected_value"]
    } else if (detail["text"] == "More than 1 metric returned") {
      detail["mismatch_type"] <-
        detail["text"]
    } else if (detail["text"] == "Missing") {
      detail["mismatch_type"] <-
        detail["text"]
    } else if (detail["text"] == "Medicaid") {
      detail["mismatch_type"] <-
        "Variable not captured"
    } else if (detail["text"] %in% c("A", "G", "R", "Y")) {
      detail["mismatch_type"] <-
        ifelse(as.character(detail["text"]) ==
                 as.character(detail["expected_value"]),
               "Match",
               "Mismatch")
    } else if (grepl("[[:digit:]]", detail["text"])) {
      detail["mismatch_type"] <-
        ifelse(
          readr::parse_number(as.character(detail["text"])) ==
            readr::parse_number(as.character(detail["expected_value"])),
          "Match",
          "Mismatch"
        )
    } else {
      detail["mismatch_type"] <-
        detail["text"]
    }

    # Construct output
    out <-
      detail

    # Return out
    return(out)
  }
