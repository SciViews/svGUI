#' Set a property in the UI (User Interface), or start an action.
#'
#' Using `setUI()` is the preferred way to set a property in a `gui` object.
#' Similarly, `startUI()` should be used to indicate that an UI action requiring
#' user input is initiated (say, a modal input or file selection dialog box).
#'
#' @param gui A `gui` object.
#' @param ... Any other property of the GUI, provided as named arguments.
#' @export
#' @seealso [gui_add()], [$.gui()]
#' @keywords misc
#' @concept GUI API implementation
#' @examples
#' # Imagine you implement a new input box
#' # In your function, you have this code:
#' myInput <- function(default = "an answer", gui = .GUI) {
#'
#'   # Start a GUI action... or by-pass it!
#'   if (gui$startUI("myInput", call = match.call(), default = default,
#'     msg = "Displaying an input dialog box",
#'     msg.no.ask = "An input dialog box was by-passed")) {
#'
#'     # Here the input dialog box is displayed and R waits for user feedback
#'     # ... [your code here]
#'     res <- "some results" # Imagine this is the text typed in the box
#'
#'     # When the input dialog box is closed, the function should do:
#'     setUI(res = res, status = NULL)
#'   }
#'   invisible(gui)
#' }
setUI <- function(..., gui = .GUI)
  UseMethod("setUI", gui)

#' @export
#' @describeIn setUI Set an UI property for a `gui` object.
#' @param fun The name of the calling function. Only required if `call` is
#' provided.
#' @param call The call in the generic as obtained by `match.call()`.
#' @param args A list with checked and/or reworked arguments for a method. The
#' generic can do this work, so that code does not need to be duplicated in
#' all its methods.
#' @param res Any data returned by the GUI (the results).
#' @param widgets The class name of the current widgets implementation.
#' @param status Description of the current GUI status. Could be "ok", "busy",
#' "busy-modal" (a modal dialog box is currently displayed), "by-passed" (the
#' GUI was by-passed because `dont_ask()` returns `TRUE`), "error",
#' or any other status indicator suitable for the current state of your GUI.
#' @param msg The message that explains the status. Cannot be provided without
#' status.
setUI.gui <- function(fun, call, args, res, widgets, status, msg = NULL,
..., gui = .GUI) {
  if (!missing(call)) {
    if (!inherits(call, "call"))
      stop("'call' must be a call expression (use match.call)")
    if (missing(fun))
      stop("'fun' must be provided with call',
        ' (original name of the calling function)")
    fun <- as.character(fun)[1]
    # Rework call to make sure to have original name for function and gui
    call[1] <- call(fun)
    if (!is.null(gui$name))
      call["gui"] <- call(as.character(gui$name)[1])
    gui$call <- call
  }
  if (!missing(args)) gui$args <- args
  if (!missing(res)) gui$res <- res
  if (!missing(widgets)) gui$widgets <- widgets
  if (!missing(status)) {
    comment(status) <- msg
    gui$status <- status
  } else if (!is.null(msg))
    stop("You must provide 'status' at the same time as 'msg'")
  # Process ...
  more_args <- list(...)
  l <- length(more_args)
  n <- names(more_args)
  if (l) for (i in 1:l) {
    gui[[n[i]]] <- more_args[i]
  }
  invisible(gui)
}

#' @export
#' @rdname setUI
startUI <- function(..., gui = .GUI)
  UseMethod("startUI", gui)

#' @export
#' @describeIn setUI Start an UI for a `gui` object.
#' @param default The default value to return if the UI is by-passed because in
#' non interactive mode, or ask is `FALSE`.
#' @param msg.no.ask The message that explains the status in case the UI is
#' by-passed.
startUI.gui <- function(fun, call, default, widgets = NULL,
status = "busy-modal", msg = "Displaying a modal dialog box",
msg.no.ask = "A modal dialog box was by-passed", ..., gui = .GUI) {
  if (dont_ask(gui)) {# Just return default value
    gui$setUI(fun = fun, call = call, res = default,
      widgets = "none", status = "by-passed", msg = msg.no.ask)
    return(FALSE)
	} else {# Inform that we are about to display a modal dialog box
    gui$setUI(fun = fun, call = call, res = NA,
      widgets = NULL, status = status, msg = msg)
    return(TRUE)
  }
}
