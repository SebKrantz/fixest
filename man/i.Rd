% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MiscFuns.R
\docType{data}
\name{i}
\alias{i}
\alias{interact}
\title{Create, or interact variables with, factors}
\format{
An object of class \code{function} of length 1.
}
\usage{
i(var, f, ref, drop, keep)

interact
}
\arguments{
\item{var}{A vector to be interacted with \code{f}. If the other argument \code{f} is missing, then this vector will be treated as the argument \code{f}.}

\item{f}{A vector (of any type) that will be treated as a factor. Must be of the same length as \code{var} if \code{var} is not missing.}

\item{ref}{A single value that belongs to the interacted variable (\code{f}). Can be missing.}

\item{drop}{A vector of values that belongs to the factor variable (\code{f}). If provided, all values from \code{f} that match \code{drop} will be removed.}

\item{keep}{A vector of values that belongs to the factor variable (\code{f}). If provided, only the values from \code{f} that match \code{keep} will be kept.}
}
\value{
It returns a matrix with number of rows the length of \code{var}. The number of columns is equal to the number of cases contained in \code{f} minus the reference.
}
\description{
Treat a variable as a factor, or interacts a variable with another treated as a factor. Values to be dropped/kept from the factor can be easily set.
}
\section{Shorthand in \code{fixest} estimations}{

In \code{fixest} estimations, instead of using \code{i(var, f, ref)}, you can instead use the following writing \code{var::f(ref)}. Note that this way of doing interactions is not endorsed any more and will likely be deprecated in the future.
}

\examples{

#
# Simple illustration
#

x = 1:10
y = rep(1:4, 3)[1:10]

# interaction
cbind(x, y, i(x, y, 1))

# without interaction
cbind(x, y, i(y, ref = 1))

# You can interact factors too
z = rep(c("a", "b", "c"), c(5, 3, 2))
data.frame(z, y, i(z, y))

#
# In fixest estimations
#

data(base_did)
# We interact the variable 'period' with the variable 'treat'
est_did = feols(y ~ x1 + i(treat, period, 5) | id + period, base_did)

# => special treatment in coefplot
coefplot(est_did)

# Using i() for factors
est_bis = feols(y ~ x1 + i(period, keep = 3:6) + i(treat, period, 5) | id, base_did)

coefplot(est_bis, only.inter = FALSE)

# => special treatment in etable
etable(est_bis, dict = c("6" = "six"))


}
\seealso{
\code{\link[fixest]{coefplot}} to plot interactions, \code{\link[fixest]{feols}} for OLS estimation with multiple fixed-effects.
}
\author{
Laurent Berge
}
\keyword{datasets}
