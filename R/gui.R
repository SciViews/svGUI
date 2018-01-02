#' A GUI object.
#'
#' The `gui` object contains and manages GUI-related data.
#'
#' @param gui A `gui` object..
#' @param x A function for `$`, or an object for the others.
#' @param args Arguments to pass to the function.
#' @param ... Further arguments (not used yet).
#' @seealso [gui_add()]
#' @keywords misc
#' @concept GUI API implementation
#' @examples
#' # Create a GUI
#' gui_add("myGUI")
#' is.gui(myGUI)
#' myGUI
#' gui_remove("myGUI")
#' @name gui
NULL

#' @export
#' @rdname gui
`$.gui` <- function(gui, x, args) {
  if (!exists(x, envir = gui))
    return(NULL)

  res <- get(x, envir = gui)
  if (is.function(res)) {
    res <- function(...)
      get(x, envir = gui)(..., gui = gui)

    if (!missing(args))
      res <- do.call(res, args, envir = parent.frame())
  }
	res
}
#' @export
#' @rdname gui
print.gui <- function(x, ...) {
  if (x$name == ".GUI") {
    cat("The default SciViews GUI (.GUI)\n")
  } else {
    cat("A SciViews user interface named ", x$name, "\n", sep = "")
  }
  cat("using widgets from: ", paste(gui_widgets(x), collapse = ", "),
    "\n", sep = "")
  if (!gui_ask(x))
    cat("(it is currently inactivated - ask == FALSE)\n")
  if (!is.null(x[["call"]])) {
    cat("* Last call: ", deparse(x[["call"]]), "\n" , sep = "")
    cat("* Last widgets used: ", x$widgets, "\n", sep = "")
    cmt <- comment(x$status)
    if (is.null(cmt)) {
      if (is.null(x$status)) {
        cat("* Last status: ok\n")
      } else {
        cat("* Last status: ", x$status, "\n", sep = "")
      }
    } else cat("* Last status: ", x$status, " (", cmt, ")\n", sep = "")
    cat("* Last result:\n")
    print(x$res)
  }
  invisible(x)
}

#' @export
#' @rdname gui
is.gui <- function(x)
	inherits(x, "gui")
