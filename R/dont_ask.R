#' Can we interrupt R to ask something to the user though the GUI?
#'
#' Determine if R code execution can be interrupted by the GUI, e.g., using a
#' modal dialog box. It depends both on R being in `interactive()` mode and the
#' `ask` flag of the GUI being set to `TRUE`.
#'
#' `dontAsk` and `dont_ask` are aliases.
#'
#' @param gui A `gui` object.
#' @return `TRUE` if the GUI cannot interrupt R. The function triggering the
#' dialog box should then not be displayed and it should return the default
#' value as the result. The function returns `TRUE` if R is run in a non
#' interactive session, or if `ask` is set to `FALSE` for the GUI, or if it is
#' not specified (`ask` is `NULL`) then `getOptions("gui.ask")` is used.
#' @export
#' @seealso [gui_ask()], [gui]
#' @keywords misc
#' @concept GUI API implementation
#'
#' @examples
#' # What is the current state for the default GUI?
#' dont_ask()
dont_ask <- function(gui = .GUI) {
  is_interactive <- interactive()
  # One can fool R in non-interactive mode by setting SciViews.force.interactive
  # Note: use this carefully, and ONLY for your tests!
  if (isTRUE(getOption("SciViews.force.interactive", default = FALSE)))
    is_interactive <- TRUE
  !interactive() || !gui_ask(gui)
}

#' @export
#' @rdname dont_ask
dontAsk <- dont_ask # Backward compatibility
