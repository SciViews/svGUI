\name{setUI}
\alias{setUI}
\alias{setUI.gui}
\alias{startUI}
\alias{startUI.gui}

\title{ Set a property in the UI (User Interface), or start an action }

\description{
  This is the preferred way to set a property in a 'gui' object or to indicate
  that an UI action is about to start.
}

\usage{
setUI(\dots, gui = .GUI)
\method{setUI}{gui}(fun, call, args, res, widgets, status, msg = NULL,
    \dots, gui = .GUI)
startUI(\dots, gui = .GUI)
\method{startUI}{gui}(fun, call, default, widgets = NULL, status = "busy-modal",
    msg = "Displaying a modal dialog box",
    msg.no.ask = "A modal dialog box was by-passed", \dots, gui = .GUI)
}

\arguments{
  \item{fun}{ the name of the calling function. Only required if \code{call} is
    provided. }
  \item{call}{ the call in the generic as obtained by \code{match.call()} }
  \item{args}{ a list with checked and/or reworked arguments for a method. The
    generic can do this work, so that code does not need to be duplicated in
    all its methods. }
  \item{res}{ any data returned by the GUI (the results). }
  \item{default}{ the default value to return if the UI is by-passed because in
    non interactive mode, or ask is \code{FALSE}. }
  \item{widgets}{ the class name of the current widgets implementation. }
  \item{status}{ description of the current GUI status. Could be "ok", "busy",
    "busy-modal" (a modal dialog box ius currently displayed), "by-passed" (the
    GUI was by-passed because \code{dontAsk()} returns \code{TRUE}), "error",
    or any other status indicator suitable for the current state of your GUI. }
  \item{msg}{ the message expliciting the status. Cannot be provided without
    status. }
  \item{msg.no.ask}{ the message expliciting the status in cas the UI is
    by-passed. }
  \item{\dots}{ any other property of the GUI, provided as nammed arguments. }
  \item{gui}{ a 'gui' object. }

}

\value{
  The modified 'gui' object is returned invisibly by \code{setUI()}.
  For \code{startUI()} either \code{TRUE} (can start the UI), or \code{FALSE}
  if the Ui should be by-passed.
}

\author{
  Philippe Grosjean <phgrosjean@sciviews.org>
}

\seealso{ \code{\link{guiAdd}}, \code{\link{$.gui}} }

\examples{
## Imagine you implement a new input box
## In your function, you have this code:
myInput <- function (default = "an answer", gui = .GUI) {
    
    ## Start a GUI action... or by-pass it!
    if (gui$startUI("myInput", call = match.call(), default = default,
        msg = "Displaying an imput dialog box",
        msg.no.ask = "An input dialog box was by-passed")) {

        ## Here the input dialog box is displayed and R waits from user's action
        ## ... [your code here]
        res <- "some results" # Imagine this is the text typed in the box
     
        ## When the dialog box is closed, the function should do:
        setUI(res = res, status = NULL)
    }
    return(invisible(gui))
}
}

\keyword{ misc }

\concept{ GUI API implementation }
