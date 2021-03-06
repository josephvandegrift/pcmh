% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_metric2.R
\name{.get_metric2}
\alias{.get_metric2}
\title{Get metric2}
\usage{
.get_metric2(.data_frame, .page, .x, .y)
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
This function is an alternate of \code{\link[pcmh]{.get_metric}} used to
extract metrics without a bar graph from a \code{PCMH} report.
}
\examples{
\dontrun{
.get_mettic(.data_frame, .page, .x, .y)
}
}
