% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_metric.R
\name{.get_metric}
\alias{.get_metric}
\title{Get metric}
\usage{
.get_metric(.data_frame, .page, .x, .y)
}
\arguments{
\item{.data_frame}{A \code{dataframe} read in by \code{\link[pcmh]{import_pdf_data}}.}

\item{.page}{Page number of fraction line of metric.}

\item{.x}{X value of fraction line of metric.}

\item{.y}{Y value of fraction line of metric.}
}
\value{
Returns a 1 x 5 \code{tibble} of the metric data.
}
\description{
This function uses logic to seach for the fraction line in each metric then
extracts the \code{dnmtr_num}, \code{nmrtr_num}, \code{rate}, \code{avg},
and \code{state} values.
}
\examples{
\dontrun{
.get_mettic(.data_frame, .page, .x, .y)
}
}
