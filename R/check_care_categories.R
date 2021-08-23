#' Check Care Categories
#'
#' This function checks the care category section from a PCMH report against the
#'   data pulled from oracle.
#'
#' @param .care_categories A \code{dataframe} from \code{\link[pcmh]{.extract_care_category}}
#' @param .care_categories_data A \code{dataframe} from \code{\link[pcmh]{import_cc_data}}.
#' @param .prvdr_num An \code{intiger}.
#'
#' @return Returns a \code{tibble} of \code{TRUE}/\code{FALSE}.
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom tibble tribble
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{
#' .check_care_categories(.care_categories, .care_categories_data)
#' }
.check_care_categories <- function(.care_categories, .care_categories_data, .prvdr_num) {
  care_categories <- dplyr::filter(.care_categories,
                                   .care_categories$`Provider Number` == .prvdr_num)
  care_categories_data <- dplyr::filter(.care_categories_data,
                                        .care_categories_data$PRVDR_NUM == .prvdr_num)
  #Claim Counts
  c1 <-
    tibble::tribble(
    ~x,
    care_categories_data$ANSTHSA_BENE_CNT,
    care_categories_data$DME_BENE_CNT,
    care_categories_data$ER_DEPT_BENE_CNT,
    care_categories_data$IP_FAC_BENE_CNT,
    care_categories_data$IP_PROFNL_BENE_CNT,
    care_categories_data$OP_IMGNG_BENE_CNT,
    care_categories_data$OP_LAB_BENE_CNT,
    care_categories_data$OP_PRCDR_BENE_CNT,
    care_categories_data$OP_PROFNL_BENE_CNT,
    care_categories_data$OP_SRGRY_FAC_BENE_CNT,
    care_categories_data$OP_SRGRY_PROFNL_BENE_CNT,
    care_categories_data$RX_BENE_CNT,
    care_categories_data$OTHR_BENE_CNT,
    care_categories_data$ALL_BENE_CNT
  )
  #Claim Averages
  c2 <-
    tibble::tribble(
      ~y,
      care_categories_data$ANSTHSA_AVG_CLM_AMT,
      care_categories_data$DME_AVG_CLM_AMT,
      care_categories_data$ER_DEPT_AVG_CLM_AMT,
      care_categories_data$IP_FAC_AVG_CLM_AMT,
      care_categories_data$IP_PROFNL_AVG_CLM_AMT,
      care_categories_data$OP_IMGNG_AVG_CLM_AMT,
      care_categories_data$OP_LAB_AVG_CLM_AMT,
      care_categories_data$OP_PRCDR_AVG_CLM_AMT,
      care_categories_data$OP_PROFNL_AVG_CLM_AMT,
      care_categories_data$OP_SRGRY_FAC_AVG_CLM_AMT,
      care_categories_data$OP_SRGRY_PROFNL_AVG_CLM_AMT,
      care_categories_data$RX_AVG_CLM_AMT,
      care_categories_data$OTHR_NONE_AVG_CLM_AMT,
      care_categories_data$ALL_AVG_CLM_AMT
    )
  c3 <-
    tibble::tribble(
      ~z,
      care_categories_data$ANSTHSA_AVG_ALL_AMT,
      care_categories_data$DME_AVG_ALL_AMT,
      care_categories_data$ER_DEPT_AVG_ALL_AMT,
      care_categories_data$IP_FAC_AVG_ALL_AMT,
      care_categories_data$IP_PROFNL_AVG_ALL_AMT,
      care_categories_data$OP_IMGNG_AVG_ALL_AMT,
      care_categories_data$OP_LAB_AVG_ALL_AMT,
      care_categories_data$OP_PRCDR_AVG_ALL_AMT,
      care_categories_data$OP_PROFNL_AVG_ALL_AMT,
      care_categories_data$OP_SRGRY_FAC_AVG_ALL_AMT,
      care_categories_data$OP_SRGRY_PROFNL_AVG_ALL_AMT,
      care_categories_data$RX_AVG_ALL_AMT,
      care_categories_data$OTHR_NONE_AVG_ALL_AMT,
      care_categories_data$ALL_AVG_ALL_AMT
    )
  out <- dplyr::near(care_categories[, 3:5], cbind(c1, c2, c3))
  out <- cbind(care_categories[, 1:2], out)
  return(tibble::as_tibble(out))
}
