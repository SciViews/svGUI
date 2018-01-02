# Because gui_change() can manage all cases where the GUI already exists or not
# and gui_add() must also manage the case where the GUI already exists,
# the two functions are pretty much interchangeable!
gui_add <- function(gui.name = ".GUI", widgets = c("nativeGUI", "textCLI"), ask)
  gui_change(gui.name = gui.name, widgets = widgets, ask = ask, reset = FALSE)

# Backward compatibility
guiAdd <- gui_add

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
    if (is.na(gui.name))
      stop("Wrong 'gui.name', provide a length 1 character string")
    gui_obj <- new.env(parent = .GlobalEnv)
    gui_obj$name <- gui.name
    gui_obj$ask <- NULL
    gui_obj$call <- NULL
    gui_obj$res <- NULL
    gui_obj$status <- NULL
    gui_obj$widgets <- NULL
    # Define initial inheritance
    class(gui_obj) <- unique(c(widgets, "gui", "environment"))
    assign(gui.name, gui_obj, envir = .TempEnv())
  }
  # Do we change the ask value?
  if (!missing(ask))
    if (is.null(ask)) gui_obj$ask <- NULL else
      gui_obj$ask <- isTRUE(as.logical(ask))
  gui_obj
}

# Backward compatibility
guiChange <- gui_change

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

# Backward compatibility
guiRemove <- gui_remove

# List all GUI objects found in SciViews:TempEnv
gui_list <- function() {
  lst <- ls(envir = .TempEnv(), all.names = TRUE)
  if (!length(lst))
    return(character(0))

  # Check which item inherits from 'gui'
  lst[sapply(lst, function(x)
    is.gui(get(x, envir = .TempEnv(), inherits = FALSE)))]
}

# Backward compatibility
guiList <- gui_list

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

# Backward compatibility
guiWidgets <- gui_widgets

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

# Backward compatibility
`guiWidgets<-` <- `gui_widgets<-`

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

# Backward compatibility
guiAsk <- gui_ask

`gui_ask<-` <- function(x, value) {
  if (!is.gui(x))
    stop("gui_ask must be applied to a 'gui' object")
  if (is.null(value)) x$ask <- NULL else
    x$ask <- isTRUE(as.logical(value))
  x
}

# Backward compatibility
`guiAsk<-` <- `gui_ask<-`
