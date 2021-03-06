% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_page_numbers.R
\name{.add_page_numbers}
\alias{.add_page_numbers}
\title{Add Page Number}
\usage{
.add_page_numbers(.data_frame, .page)
}
\arguments{
\item{.data_frame}{A \code{dataframe}.}

\item{.page}{An \code{integer}.}
}
\value{
Returns \code{.data_frame} as a \code{tibble} with a \code{page}
column added.
}
\description{
Adds a \code{page} column to a \code{dataframe}. Helper function to be used
to clean the \code{.pdf} PCMH reports data.
}
\examples{
\dontrun{
.add_page_numbers(dataframe)
}
}
