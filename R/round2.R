#' Round2
#'
#' This function works the same as \code{\link[base]{round}} but always rounds
#'   x.5 up and not to even.
#'
#' @param x A \code{numeric} value.
#' @param n An \code{integer} representing the decimal to round \code{x} to.
#'
#' @return Returns a \code{double}.
#' @export
#'
#' @examples
#' \dontrun{
#' round2(x, n)
#' }
round2 = function(x, n) {
  posneg = sign(x)
  z = abs(x)*10^n
  z = z + 0.5 + sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^n
  z = z*posneg
  return(z)
}
