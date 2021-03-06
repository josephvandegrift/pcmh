% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_pdf_data.R
\name{read_pdf_data}
\alias{read_pdf_data}
\title{Read pdf_data}
\usage{
read_pdf_data(path, ...)
}
\arguments{
\item{path}{Filepath to a directory of  \code{.pdf} PCMH Reports.}

\item{...}{Extra parameters to be passed to \code{\link[fs]{dir_ls}}.}
}
\value{
Returns a \code{list} of \code{lists}. Each \code{element} of the
\code{list} refers to a PCMH Report and is a \code{list} of \code{dataframes},
each of which refers to a single page from the PCMH Report.
}
\description{
Uses \code{\link[fs]{dir_ls}} to create a \code{list} of the \code{.pdf} PCMH
Report filepaths.
Then uses \code{\link[furrr]{future_map}} to map \code{\link[pdftools]{pdf_data}}
to read in each PCMH Report.
}
\examples{
\dontrun{
read_pdf_data(hi)
}
}
