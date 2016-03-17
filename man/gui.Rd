\name{gui}
\alias{gui}
\alias{$.gui}
\alias{print.gui}
\alias{is.gui}

\title{A GUI object}

\description{
  The 'gui' object contains and manages GUI-related data.
}

\usage{
\method{$}{gui}(gui, x, args)
\method{print}{gui}(x, \dots)
is.gui(x)
}

\arguments{
  \item{x}{ a function for \code{$}, or an object for the others. }
  \item{gui}{ a 'gui' object. }
  \item{args}{ arguments to pass to the function. }
  \item{\dots}{ further arguments (not used yet). }
}

\details{
  Methods for 'gui' objects can dispatch as usuang using
  \code{amethod(...., gui = agui)} but note that these methods do not dispatch
  on first provided argument, but to the named argument \code{gui}. There is
  another way to call 'gui' methods: \code{agui$amethod(....)}. This may be a
  convenient alternative for those who prefer this style of calling object's
  methods.
}

\value{
  The result of the evaluation of the method of function applied for
  \code{agui$amethod(....)}.
  The 'gui' object, invisibly, for \code{print()}.
  \code{TRUE} for \code{is.gui(x)} if the object \code{x} inherits from 'gui',
  \code{FALSE} otherwise.
}

\note{
  The 'gui' objects are not terribly useful by themselve, but thay provide the
  fundation for a flexible organisation of GUI elements in R (see for instance
  svDialogs or svWidgets).
}

\author{
  Philippe Grosjean <phgrosjean@sciviews.org>
}

\seealso{ \code{\link{guiAdd}} }

\examples{
## Create a GUI
guiAdd("myGUI")
is.gui(myGUI)
myGUI
guiRemove("myGUI")
}

\keyword{ misc }

\concept{ GUI API implementation }
