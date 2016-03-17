\name{guiAdd}
\alias{guiAdd}
\alias{guiAsk}
\alias{guiAsk<-}
\alias{guiChange}
\alias{guiList}
\alias{guiRemove}
\alias{guiWidgets}
\alias{guiWidgets<-}

\title{ Creation of GUI objects }
\description{
  Create 'gui' object to manage SciViews-compatible GUIs (Graphical User
  Interfaces).
}

\usage{
guiAdd(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"), ask)
guiChange(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"),
    reset = FALSE, ask)
guiRemove(gui.name)
guiList()
guiWidgets(gui, gui.name = ".GUI")
guiWidgets(x, reset = FALSE) <- value
guiAsk(gui.or.name, ask)
guiAsk(x) <- value
}

\arguments{
  \item{gui.name}{ the name of the GUI. It is also the name of the object stored
    in SciViews:TempEnv where you can access it. Although not required,
    you are better to use short, syntactically correct names. }
  \item{widgets}{ the list of widgets that GUI uses, listed in a priority
    order. }
  \item{ask}{ logical indicating if simple dialog boxes should be display
    (\code{ask = TRUE}), or if those dialog boxes are by-passed, using default
    values to simulate script running in non interactive mode, or to test
    scripts without interruption, using only provided default values (useful for
    automated tests). }
  \item{reset}{ should the GUI's main parameters (widgets, ask) be reset to
    default values? }
  \item{gui}{ a 'gui' object. If provided, it supersedes any value provided in
    \code{gui.name}. }
  \item{x}{ a 'gui' object. }
  \item{value}{ the list of widgets to add to this GUI, in priority order, or
    should we change ask to \code{TRUE}, \code{FALSE} or \code{NULL} (then, use
    default value stored in \code{getOption("gui.ask")}). }
  \item{gui.or.name}{ a 'gui' object or its name. }
}

\value{
  The 'gui' object just created or changed for \code{guiAdd()},
  \code{guiChange()}, \code{guiWidgets(agui) <- value} or
  \code{guiAsk(agui) <- value}. For \code{guiRemove()}, \code{TRUE} if an object
  was removed, or \code{FALSE} if the object was not there, invisibly. For
  \code{guiList()}, the list of current 'gui' objects in SciViews:TempEnv, or a
  zero-length character if none (should not happen, since \code{.GUI}, the
  default GUI, cannot be removed).
}

\author{Philippe Grosjean (\email{phgrosjean@sciviews.org})}

\seealso{ \code{\link{gui}}, \code{\link{setUI}}, \code{\link{dontAsk}} }

\examples{
## A 'gui' object named .GUI is automatically created in SciViews:TempEnv
guiList()

## Create a new GUI object to manage a separate GUI in the same R session
guiAdd("myGUI")
guiList()

## Change general properties of this GUI
guiAsk(myGUI) <- FALSE
## Add widgets to this GUI (you must provide methods for them)
## see the svDialogstcltk package for examples hox to do this
guiWidgets(myGUI) <- "tcltkWidgets"
guiWidgets(myGUI) # Added to existing ones if reset is FALSE

## Remove this new GUI
guiRemove("myGUI")
}

\keyword{ misc }

\concept{ GUI API implementation }
