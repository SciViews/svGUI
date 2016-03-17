\name{dontAsk}
\alias{dontAsk}

\title{ Don't we ask something though the GUI? }

\description{
  Determine if R code execution can be interrupted by the GUI, e.g., a modal
  dialog box.
}

\usage{
dontAsk(gui = .GUI)
}

\arguments{
  \item{gui}{ a 'gui' object. }
}

\details{
  Methods for 'gui' objects can dispatch as usual using
  \code{amethod(...., gui = agui)} but note that these methods do not dispatch
  on first provided argument, but to the named argument \code{gui}. There is
  another way to call 'gui' methods: \code{agui$amethod(....)}. This may be a
  convenient alternative for those who prefer this style of calling object's
  methods.
}

\value{
  \code{TRUE} if the GUI cannot interupt. The function triggering the dialog box
  should then not display it and should return the default value as the result.
  The function returns \code{TRUE} if R is run in a non interactive session, or
  if \code{ask} is se to \code{FALSE} for the GUI, or if it is not specified,
  that is, its value is \code{NULL}, if \code{getOptions("gui.ask")} is
  \code{FALSE}.
}

\author{
  Philippe Grosjean <phgrosjean@sciviews.org>
}

\seealso{ \code{\link{guiAsk}}, \code{\link{gui}} }

\examples{
## Wat's the current state for the default GUI
dontAsk()
}

\keyword{ misc }

\concept{ GUI API implementation }
