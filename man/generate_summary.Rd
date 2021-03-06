% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_summary.R
\name{generate_summary}
\alias{generate_summary}
\title{Generate Summary}
\usage{
generate_summary(.detail, .prvdr_num)
}
\arguments{
\item{.detail}{A \code{dataframe} generated by \code{\link[pcmh]{generate_detail}}.}

\item{.prvdr_num}{A 9 digit \code{intiger}.}
}
\value{
Returns an nx2 \code{dataframe} for n \code{.prvdr_num}.
}
\description{
This function generates the summary page of a \code{PCMH} QA error report.
}
\examples{
\dontrun{
generate_summary(.detail, .prvdr_num)
}
}
