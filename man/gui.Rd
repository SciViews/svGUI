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
  Methods for 'gui' objects can dispatch using \code{amethod(...., gui = agui)}.
  Note that these methods do not dispatch on the first argument, but to the
  named argument \code{gui}. There is another way to call 'gui' methods:
  \code{agui$amethod(....)}.
}

\value{
  The result of the evaluation of the method of function applied for
  \code{agui$amethod(....)}. The 'gui' object, invisibly, for \code{print()}.
  \code{TRUE} for \code{is.gui(x)} if the object \code{x} inherits from 'gui',
  \code{FALSE} otherwise.
}

\note{
  The 'gui' objects are not terribly useful by themselve, but they provide the
  fundation for a flexible organisation of GUI elements in R (see for instance
  svDialogs or svWidgets).
}

\author{
  Philippe Grosjean <phgrosjean@sciviews.org>
}

\seealso{ \code{\link{gui_add}} }

\examples{
# Create a GUI
gui_add("myGUI")
is.gui(myGUI)
myGUI
gui_remove("myGUI")
}

\keyword{ misc }

\concept{ GUI API implementation }
