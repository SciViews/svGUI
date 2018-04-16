#' Creation and management of GUI objects.
#'
#' Create and manipulate `gui` objects to manage SciViews-compatible GUIs
#' (Graphical User Interfaces).
#'
#' @param gui.name The name of the GUI. It is also the name of the object stored
#' in `SciViews:TempEnv` where you can access it.
#' @param widgets The list of widgets that GUI uses, listed in a priority order.
#' @param ask Logical indicating if modal dialog boxes should be display
#' (`ask = TRUE`), or if those dialog boxes are by-passed, using default values
#' to simulate script running in non interactive mode, or to test scripts
#' without interruption, using only provided default values (useful for
#' automated tests).
#' @export
#' @seealso [gui], [setUI()], [dont_ask()]
#' @keywords misc
#' @concept GUI API implementation
#' @examples
#' # A 'gui' object named .GUI is automatically created in 'SciViews:TempEnv'
#' gui_list()
#'
#' # Create a new GUI object to manage a separate GUI in the same R session
#' gui_add("myGUI")
#' gui_list()
#'
#' # Change general properties of this GUI
#' gui_ask(myGUI) <- FALSE
#' # Add widgets to this GUI (you must provide methods for them)
#' # see the svDialogs package for examples
#' gui_widgets(myGUI) <- "tcltkWidgets"
#' gui_widgets(myGUI) # Added to existing ones if reset is FALSE
#'
#' # Remove this new GUI
#' gui_remove("myGUI")
gui_add <- function(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"), ask)
  gui_change(gui.name = gui.name, widgets = widgets, ask = ask, reset = FALSE)

#' @export
#' @rdname gui_add
guiAdd <- gui_add # Backward compatibility

#' @export
#' @rdname gui_add
#' @param reset Should the GUI's main parameters (widgets, ask) be reset to
#' default values?
gui_change <- function(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"),
reset = FALSE, ask) {
  gui.name <- as.character(gui.name)[1]
  # Do the object already exists in SciViews:TempEnv?
  if (exists(gui.name, envir = .TempEnv(), inherits = FALSE)) {
    gui_obj <- get(gui.name, envir = .TempEnv(), inherits = FALSE)
    if (!is.gui(gui_obj))
      stop("'gui.name' must be a character string naming a 'gui' object in SciViews:TempEnv")
    gui_widgets(gui_obj, reset = reset) <- widgets
    if (isTRUE(reset)) {
      # Make sure name is correct
      gui_obj$name <- gui.name
      # Use default for ask, if not provided
      if (missing(ask)) gui_obj$ask <- NULL
    }
  } else {# Create a new 'gui' object in SciViews:TempEnv
    if (is.na(gui.name) || nchar(gui.name) < 1)
      stop("Wrong 'gui.name', provide a non empty character string")
    gui_obj <- new.env(parent = .GlobalEnv)
    gui_obj$name <- gui.name
    gui_obj$ask <- NULL
    gui_obj$call <- NULL
    gui_obj$res <- NULL
    gui_obj$status <- NULL
    gui_obj$widgets <- NULL
    # In order to allow access to these function when svGUI is not imported
    gui_obj$startUI <- function(...) svGUI::startUI(...)
    gui_obj$setUI <- function(...) svGUI::setUI(...)
    class(gui_obj) <- unique(c(widgets, "gui", "environment"))
    assign(gui.name, gui_obj, envir = .TempEnv())
  }
  # Do we change the ask value?
  if (!missing(ask))
    if (is.null(ask)) gui_obj$ask <- NULL else
      gui_obj$ask <- isTRUE(as.logical(ask))
  gui_obj
}

#' @export
#' @rdname gui_add
guiChange <- gui_change # Backward compatibility

#' @export
#' @rdname gui_add
gui_remove <- function(gui.name) {
  # Eliminate the corresponding variable, after some housekeeping
  if (gui.name == ".GUI")
    stop("You cannot delete the default GUI named '.GUI'! Maybe use ?gui_change.")

  if (!exists(gui.name, envir = .TempEnv(), inherits = FALSE))
    return(invisible(FALSE))

  # TODO: housekeeping here!
  rm(list = gui.name, envir = .TempEnv(), inherits = FALSE)
  invisible(TRUE)
}

#' @export
#' @rdname gui_add
guiRemove <- gui_remove # Backward compatibility

#' @export
#' @rdname gui_add
gui_list <- function() {
  lst <- ls(envir = .TempEnv(), all.names = TRUE)
  # This should never happen (default .GUI should always be there)
  if (!length(lst)) # nocov
    return(character(0)) # nocov

  # Check which item inherits from 'gui'
  lst[sapply(lst, function(x)
    is.gui(get(x, envir = .TempEnv(), inherits = FALSE)))]
}

#' @export
#' @rdname gui_add
guiList <- gui_list # Backward compatibility

#' @export
#' @rdname gui_add
#' @param gui A `gui` object. If provided, it supersedes any value provided in
#' `gui.name`.
gui_widgets <- function(gui, gui.name = ".GUI") {
  if (missing(gui)) {
    if (exists(gui.name, envir = .TempEnv(), inherits = FALSE)) {
      gui <- get(gui.name, envir = .TempEnv(), inherits = FALSE)
    } else {
      stop("'gui' object '", gui.name, "' not found")
    }
  }
  if (!is.gui(gui))
    stop("Provide a 'gui' object or its name")

  classes <- class(gui)
  # Keep only all classes before 'gui'
  classes <- classes[!cumsum(classes == "gui")]
  classes
}

#' @export
#' @rdname gui_add
guiWidgets <- gui_widgets # Backward compatibility

#' @export
#' @rdname gui_add
#' @param x A `gui` object.
#' @param value The list of widgets to add to this GUI, in priority order, or
#' should we change ask to `TRUE`, `FALSE` or `NULL` (then, use the default
#' value stored in `getOption("gui.ask")`).
`gui_widgets<-` <- function(x, reset = FALSE, value) {
  value <- as.character(value)
  if (isTRUE(as.logical(reset))) {
    # Change completely class
    class(x) <- unique(c(value, "gui", "environment"))
  } else {
    # Add 'value' items to current classes
    classes <- class(x)
    value <- value[!value %in% classes]
    if (length(value))
      class(x) <- c(value, classes)
  }
  x
}

#' @export
#' @rdname gui_add
`guiWidgets<-` <- `gui_widgets<-` # Backward compatibility

#' @export
#' @rdname gui_add
#' @param gui.or.name A `gui` object or its name.
gui_ask <- function(gui.or.name, ask) {
  if (missing(gui.or.name)) {
    # Query or change the default value in 'gui.ask' option
    if (missing(ask)) {
      res <- getOption("gui.ask", default = NULL)
      if (is.null(res))
        res <- structure(TRUE, comment = "default")
      return(res)
    }
    if (!is.null(ask))
      ask <- isTRUE(as.logical(ask))
    res <- options(gui.ask = ask)$gui.ask
    if (!is.null(res))
      res <- as.logical(res)
  } else {
    if (is.gui(gui.or.name)) {
      gui_obj <- gui.or.name
    } else {
      if (!exists(gui.or.name, envir = .TempEnv(), inherits = FALSE))
        stop("'gui' object '", gui.or.name, "' not found")
      gui_obj <- get(gui.or.name, envir = .TempEnv(), inherits = FALSE)
      if (!is.gui(gui_obj))
        stop("'gui.or.name' must be a 'gui' object in SciViews:TempEnv or its name")
    }

    if (missing(ask)) {
      res <- gui_obj$ask
      if (is.null(res)) # Look at default value
        res <- structure(getOption("gui.ask", default = TRUE),
          comment = "default")
      return(res)
    }

    # Change the value for this GUI
    res <- gui_obj$ask
    if (is.null(ask)) {
      gui_obj$ask <- NULL
    } else {
      gui_obj$ask <- isTRUE(as.logical(ask))
    }
  }
  invisible(res)
}

#' @export
#' @rdname gui_add
guiAsk <- gui_ask # Backward compatibility

#' @export
#' @rdname gui_add
`gui_ask<-` <- function(x, value) {
  if (!is.gui(x))
    stop("gui_ask must be applied to a 'gui' object")
  if (is.null(value)) x$ask <- NULL else
    x$ask <- isTRUE(as.logical(value))
  x
}

#' @export
#' @rdname gui_add
`guiAsk<-` <- `gui_ask<-` # Backward compatibility
