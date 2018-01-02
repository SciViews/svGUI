#' SciViews - Functions to Manage GUIs in R
#'
#' The SciViews svGUI package provides function to implement GUI
#' (Graphical User Interface) in R. It is independent from any particular GUI
#' toolkit, centralize info about GUI elements currently used, and dispatch GUI
#' functions to the particular toolkits used. It use the S3 object `gui`.
#'
#' @section Methods:
#'
#' `gui` implements two methods:
#'
#' \describe{
#' \item{`print`}{Give information about the current state of the GUI}
#' \item{`$`}{Give access to various GUI properties.}
#' }
#' @section Important functions:
#' [gui_add()] and [gui_change()] for construction and management,
#' [dont_ask()] to determine if the GUI can interrupt R to ask something to the
#' user.
#'
#' @docType package
#' @name svGUI-package
NULL
