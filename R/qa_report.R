#' Qa Report
#'
#' This function generates the output for PCMH/Shared Savings report QA.
#'
#' @param .path_pdf \code{Filepath} to the directory for reports.
#' @param .path_metric \code{Filepath} to the directory of metric data/descriptions.
#' @param .report_type A \code{character} string of either "PCMH" or "Shared".
#'
#' @return Returns a \code{list} of sheets for writing to excel.
#' @export
#'
#' @examples
#' \dontrun{
#' qa_report(.path_pdf, .path_metric, .report_type = "PCMH")
#' }
qa_report <- function(.path_pdf, .path_metric, .report_type = "PCMH") {
  reports <-
    pcmh::import_pdf_data(.path_pdf, regexp = .report_type)
  metric_data <-
    pcmh::import_metric_data(.path_metric, regexp = paste0("\\/", .report_type, "_", "metrics"))
  metric_descriptions <-
    pcmh::.read_metric_data(.path_metric, regexp = paste0("\\/", .report_type, "_", "desc"))
  care_category_data <-
    pcmh::import_cc_data(.path_metric, regexp = paste0("\\/", .report_type, "_", "cc"))
  metrics <-
    furrr::future_pmap_dfr(list(reports),
                           ~ extract_metrics(..1, metric_descriptions))
  care_categories <- furrr::future_map_dfr(reports, .extract_care_category)
  detail <- pcmh::check_metrics(metrics, metric_data)
  summary <- pcmh::.generate_summary_page(detail)
  overview <- pcmh::.generate_overview_page(summary, .report_type)
  care_category <- pcmh::generate_care_category_page(care_categories, care_category_data)
  names(detail) <- c("Provider Number",
                     "Metric Type",
                     "Metric Descriptions",
                     "Metric Variable",
                     "Page #",
                     "Denominator",
                     "Numerator",
                     "Metric Value",
                     "Graphic Value")
  names(summary) <- c("Provider Number", "Pass/Fail")
  names(overview) <- c("Report Type",
                       "Pass #",
                       "Fail #",
                       "Total Reports",
                       "Pass %",
                       "Fail %")
  out <- list("Overview Statistics" = overview,
              "Summary" = summary,
              "Detail" = detail,
              "Care Categories" = care_category)
  return(out)
}
