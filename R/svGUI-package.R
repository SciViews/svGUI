#' SciViews - Manage GUIs in R
#'
#' The 'SciViews' 'svGUI' package eases the management of Graphical User
#' Interfaces (GUI) in R. It is independent from any particular GUI widgets
#' ('Tk', 'Gtk2', native, ...). It centralizes info about GUI elements currently
#' used, and it dispatches GUI calls to the particular toolkits in use in
#' function of the context (is R run at the terminal, within a 'Tk' application,
#' a HTML page?).
#'
#' The `gui` object defines a succession of GUI (or non-GUI) `widgets` to use.
#' These could be `tcltk` (with the **'tcltk'** or **'tcltk2'** R packages),
#' `gtk2` (with the **'RGtk2'** R package), `shiny`, etc. You are in charge of
#' managing these different variants of your GUI. The `gui` object just defines
#' the order of preference for those different variants, and to get a fallback
#' mechanism in case your GUI is not implemented with given `widgets`. `.GUI`
#' uses, by default, `widgets = c("nativeGUI", "textCLI")`. `"nativeGUI"` is,
#' as you figure it out, a native version of the GUI element. A good example is
#' `base::file.choose()` that displays a native dialog box to select a file.
#' `"textCLI"` is **not** a GUI version, but a way to ask the same information
#' to the user at the terminal (or Command Line, CLI). In the example, it could
#' be `base::readline("File to use? ")`. You GUI should consider the proposed
#' `widgets` in turn and use the first one on the list that is implemented. It
#' is advised to implement also a version of `"textCLI"`, in case R is run in a
#' text-only context. Finally, if none of the `widgets` can be run, your code
#' should fall back to use a default value for the file, or to stop gracefully.
#' This is required for non-interactive use or testing of your code, are when
#' your GUI `ask` is set to `FALSE`.
#'
#' Basic GUI items, like message boxes, input box, file or directory selectors,
#' etc. could easily be implemented with different `widgets` and in a
#' `"textCLI"` version (see the **'svDialogs'** package). So, if your GUI uses
#' the present mechanisms, your end-user could choose the version of the dialog
#' boxes he prefers to use, given the context (R run at the terminal, in 'RGui',
#' in 'RStudio' or 'RStudio Server'; under Windows, Mac OS, or Linux, ...). The
#' choice is easy: just change the sequence of `widgets` in the corresponding
#' `gui` object. Of course, several `gui` objects can live together at the same
#' time, providing different and independent contexts (say, one GUI build with
#' **'RGtk2'** would favor `"gtk2"`, but another GUI using **'tcltk'** would
#' either favor `"tcltk"` of course, or `c("nativeGUI", "tcltk")` just because
#' native dialog boxes may look better, for instance, under macOS or Linux.
#'
#' Finally, the `gui` object is basically a separate environment where you could
#' also store various GUI-related objects. On one hand, it does not "pollute"
#' other environments (the worse practice being to put **'tcltk'**-related
#' variables in the global environment), and on the other hand, it is very easy
#' to get rid of all the GUI-related objects, just by `gui_remove("myGUI")`.
#' Also, GUI-related items should not be `save.image()`d and re`load()`ed with
#' the other objects, and the `gui`, being located outside of `.GlobalEnv`
#' prevents it.
#'
#' @section Methods:
#'
#' svGUI implements four methods for the S3 `gui` object:
#'
#' \describe{
#' \item{`print()`}{Give information about the current state of the GUI}
#' \item{`$`}{Give access to various GUI properties or objects.}
#' \item{`startUI()`}{Start an UI action that requires to interrupt R (for
#'    instance, display an input dialog box) and manage to inform the `gui`
#'    object about it.}
#'  \item{`setUI()`}{Change the `status` of the UI action currently running.}
#' }
#' @section Important functions:
#' [gui_add()] and [gui_change()] for construction and management of `gui`s,
#' [gui_remove()] to cleanly eliminate all GUI elements,
#' [gui_list()] to list all `gui` objects currently loaded in the R session,
#' [gui_widgets()] to manage the widgets this GUI can use, and in which order,
#' [gui_ask()] allows to (temporary) disable UI actions to avoid any code
#' that would require input from the user (e.g., to run in batch mode),
#' [dont_ask()] to determine if the GUI cannot interrupt R to ask something to
#' the user, and should proceed differently (say, just use a default value for
#' an input).
#'
#' @details Methods for `gui` objects can dispatch as usual using
#' `amethod(...., gui = agui)` but note that these methods do not dispatch on
#' the first provided argument, but to the named argument `gui`. There is
#' another way to call `gui` methods: `agui$amethod(...)`. This may be a
#' convenient alternative for those who prefer this style of calling object's
#' methods (also used in reference classes, **'proto'** or **'R6'** objects).
#'
#' @docType package
#' @name svGUI-package
NULL
