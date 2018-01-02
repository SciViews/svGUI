#' Can we ask something to the user though the GUI?
#'
#' Determine if R code execution can be interrupted by the GUI, e.g., a modal
#' dialog box.
#'
#' `dontAsk` and `dont_ask` are aliases.
#'
#' @param gui a `gui` object.
#' @return `TRUE` if the GUI cannot interrupt R. The function triggering the
#' dialog box should then not be displayed and it should return the default
#' value as the result. The function returns `TRUE` if R is run in a non
#' interactive session, or if `ask` is set to `FALSE` for the GUI, or if it is
#' not specified (`NULL`) then `getOptions("gui.ask")` is used.
#' @export
#' @seealso [gui_ask()], [gui]
#' @keywords misc
#' @concept GUI API implementation
#'
#' @details Methods for `gui` objects can dispatch as usual using
#' `amethod(...., gui = agui)` but note that these methods do not dispatch on
#' first provided argument, but to the named argument `gui`. There is another
#' way to call `gui` methods: `agui$amethod(....)`. This may be a convenient
#' alternative for those who prefer this style of calling object's methods.
#'
#' @examples
#' # What's the current state for the default GUI?
#' dont_ask()
dont_ask <- function(gui = .GUI)
  !interactive() || !gui_ask(gui)

#' @export
#' @rdname dont_ask
dontAsk <- dont_ask # Backward compatibility
