\name{dont_ask}
\alias{dont_ask}
\alias{dontAsk}

\title{ Are we asking something to the user though the GUI? }

\description{
  Determine if R code execution can be interrupted by the GUI, e.g., a modal
  dialog box.
}

\usage{
dont_ask(gui = .GUI)
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
  \code{TRUE} if the GUI cannot interrupt R. The function triggering the dialog
  box should then not be displayed and it should return the default value as the
  result. The function returns \code{TRUE} if R is run in a non interactive
  session, or if \code{ask} is set to \code{FALSE} for the GUI, or if it is not
  specified (\code{NULL}) then \code{getOptions("gui.ask")} is used.
}

\author{
  Philippe Grosjean <phgrosjean@sciviews.org>
}

\seealso{ \code{\link{gui_ask}}, \code{\link{gui}} }

\examples{
# What's the current state for the default GUI?
dont_ask()
}

\keyword{ misc }

\concept{ GUI API implementation }
