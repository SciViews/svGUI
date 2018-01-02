\name{gui_add}
\alias{gui_add}
\alias{gui_ask}
\alias{gui_ask<-}
\alias{gui_change}
\alias{gui_list}
\alias{gui_remove}
\alias{gui_widgets}
\alias{gui_widgets<-}

\alias{guiAdd}
\alias{guiAsk}
\alias{guiAsk<-}
\alias{guiChange}
\alias{guiList}
\alias{guiRemove}
\alias{guiWidgets}
\alias{guiWidgets<-}

\title{ Creation and management of GUI objects }
\description{
  Create and manipulate 'gui' object to manage SciViews-compatible GUIs
  (Graphical User Interfaces).
}

\usage{
gui_add(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"), ask)
gui_change(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"),
    reset = FALSE, ask)
gui_remove(gui.name)
gui_list()
gui_widgets(gui, gui.name = ".GUI")
gui_widgets(x, reset = FALSE) <- value
gui_ask(gui.or.name, ask)
gui_ask(x) <- value

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
    in \code{SciViews:TempEnv} where you can access it. }
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
  The 'gui' object just created or changed for \code{gui_add()},
  \code{gui_change()}, \code{gui_widgets(agui) <- value} or
  \code{gui_ask(agui) <- value}. For \code{gui_remove()}, \code{TRUE} if an
  object was removed, or \code{FALSE} if the object was not there, invisibly.
  For \code{gui_list()}, the list of current 'gui' objects in
  \code{SciViews:TempEnv}, or a zero-length character if none (should not
  happen, since \code{.GUI}, the default GUI, cannot be removed).
}

\author{Philippe Grosjean (\email{phgrosjean@sciviews.org})}

\seealso{ \code{\link{gui}}, \code{\link{setUI}}, \code{\link{dont_ask}} }

\examples{
# A 'gui' object named .GUI is automatically created in 'SciViews:TempEnv'
gui_list()

# Create a new GUI object to manage a separate GUI in the same R session
gui_add("myGUI")
gui_list()

# Change general properties of this GUI
gui_ask(myGUI) <- FALSE
# Add widgets to this GUI (you must provide methods for them)
# see the svDialogstcltk package for examples
gui_widgets(myGUI) <- "tcltkWidgets"
gui_widgets(myGUI) # Added to existing ones if reset is FALSE

# Remove this new GUI
gui_remove("myGUI")
}

\keyword{ misc }

\concept{ GUI API implementation }
