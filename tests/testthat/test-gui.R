test_that(".GUI exists", {
  expect_s3_class(.GUI, "gui")
  expect_true(is.gui(.GUI))
  expect_identical(.GUI$name, ".GUI")

  expect_true(length(gui_list()) > 0)
  expect_type(gui_list(), "character")
  expect_true(".GUI" %in% gui_list())
})

test_that(".GUI has NULL res, status, widgets, ask and call", {
  expect_null(.GUI$res)
  expect_null(.GUI$status)
  expect_null(.GUI$widgets)
  expect_null(.GUI$ask)
  expect_null(.GUI$call)
  expect_null(.GUI$nonexisting)
  expect_error(
    if (interactive()) dont_ask(gui = "noGUI") else
      stop("'gui' object 'noGUI' not found"),
    "'gui' object 'noGUI' not found",
    fixed = TRUE
  )
})

test_that("Objects can be added into .GUI", {
  .GUI$test_obj <- 1
  expect_equal(.GUI$test_obj, 1)
  .GUI$test_obj <- 2
  expect_equal(.GUI$test_obj, 2)
  .GUI$test_obj <- NULL
  expect_null(.GUI$test_obj)
})

test_that("Functions can be added into .GUI", {
  .GUI$test_fun <- function(x, ..., gui) x
  expect_type(.GUI$test_fun, "closure")
  expect_equal(.GUI$test_fun(1), 1)

  # A function with missing gui argument
  .GUI$test_fun <- function(x) x
  expect_type(.GUI$test_fun, "closure")
  expect_error(
    .GUI$test_fun(1),
    "unused argument (gui = gui)",
    fixed = TRUE
  )

  .GUI$test_fun <- NULL
})

test_that("Print default .GUI information", {
  expect_output(print(.GUI), "The default SciViews GUI")
  expect_output(print(.GUI), "using widgets from:")
  expect_output(print(.GUI), "textCLI")
  # If call is defined, it should print additional information
  startUI("myfun", (function() match.call())())
  expect_output(print(.GUI), "Last status: ")
  # Remove comment on status and see if it is still displayed by print()
  .GUI$status <- as.character(.GUI$status)
  expect_output(print(.GUI), "Last status: ")
  setUI(status = "ok")
})

test_that("Print extended .GUI information for call", {
  test_gui <- function(message = "Test", default = "", ..., gui = .GUI) {
    gui$startUI("test_gui", call = match.call(), default = default,
      msg = "A simulated call to a GUI element",
      msg.no.ask = "The simulated GUI was by-passed")
    invisible(gui)
  }
  test_gui()
  # .GUI should contain information about a by-passed GUI modal item
  expect_output(print(.GUI), "Last call: test_gui\\(gui = \\.GUI\\)")
  expect_output(print(.GUI), "Last status: by-passed")
  expect_output(print(.GUI), "The simulated GUI was by-passed")

  test_error_gui <- function(msg = "An example error message", gui = .GUI) {
    gui$setUI(status = "error", msg = msg, widgets = "none")
  }
  test_error_gui()
  # Error should be reported correctly in .GUI
  expect_output(print(.GUI), "Last call: test_gui\\(gui = \\.GUI\\)")
  expect_output(print(.GUI), "Last widgets used: none")
  expect_output(print(.GUI), "Last status: error")
  expect_output(print(.GUI), "An example error message")

  test_close_gui <- function(res = "Some fake results", gui = .GUI) {
    gui$setUI(res = res, status = NULL)
  }
  test_close_gui()
  # .GUI should indicate the GUI modal item is closed and return its result
  expect_output(print(.GUI), "Last call: test_gui\\(gui = \\.GUI\\)")
  expect_output(print(.GUI), "Last status: ok")
  expect_output(print(.GUI), "\\[1\\] \"Some fake results\"")
})

test_that("Cannot remove .GUI or non existing GUIs", {
  expect_error(
    gui_remove(".GUI"),
    "You cannot delete the default GUI named '.GUI'!",
    fixed = FALSE
  )
  expect_false(gui_remove("non_existing_GUI"))
})

test_that("setUI correctly handles (wrong) arguments", {
  expect_error(
    setUI(ls, call = "wrong_call_object"),
    "'call' must be a call expression (use match.call)",
    fixed = TRUE
  )
  # If call = is provided, fun = must also be provided
  expect_error(
    setUI(call = (function() match.call())()),
    "'fun' must be provided with call'"
  )
  # Args added (should be a lit, but for now, accepts anything)
  test_args <- "some arguments"
  setUI(args = test_args)
  expect_identical(.GUI$args, test_args)
  # Remove args
  rm("args", envir = .GUI)
  # It is an error to provide msg without status
  expect_error(
    setUI(msg = "A message..."),
    "You must provide 'status' at the same time as 'msg'"
  )
  # Test it again with status = "ok"
  saved_status <- .GUI$status
  setUI(status = "ok", msg = "A message...")
  expect_identical(.GUI$status, structure("ok", comment = "A message..."))
  # Reset previous status
  .GUI$status <- saved_status
  # Test if one can add items in .GUI through ... in setUI()
  setUI(a_test_item = "Some value")
  expect_identical(.GUI$a_test_item, "Some value")
  # Reset the item
  rm("a_test_item", envir = .GUI)
  expect_null(.GUI$a_test_item)
})

test_that("startUI works as expected", {
  oask <- gui_ask(.GUI)
  # startUI() when dont_ask(.GUI) is TRUE (should return FALSE)
  gui_ask(.GUI) <- FALSE
  .GUI$res <- NULL
  expect_false(startUI())
  # res must be NULL
  expect_null(.GUI$res)
  # status must be "by-passed", with default comment
  expect_identical(.GUI$status,
     structure("by-passed", comment = "A modal dialog box was by-passed"))
  # widgets must be "none"
  expect_identical(.GUI$widgets, "none")
  expect_output(print(.GUI),
    "(it is currently inactivated - ask == FALSE)",
    fixed = TRUE
  )

  # startUI() when dont_ask() is forced to FALSE
  gui_ask(.GUI) <- TRUE
  .GUI$res <- NULL
  # We are probably in non interactive() mode, this forces the mode
  # (don't use it outside pure testing and controlled conditions!)
  options(SciViews.force.interactive = TRUE)
  # startUI() must now return TRUE
  expect_true(startUI())
  # res must now contain NA
  expect_identical(.GUI$res, NA)
  # status must be "busy-modal", with default comment
  expect_identical(.GUI$status,
    structure("busy-modal", comment = "Displaying a modal dialog box"))
  # widgets must be NULL, since it was not provided
  expect_null(.GUI$widgets)

  # Restore the system
  setUI(status = "ok", msg = "Done testing")
  options(SciViews.force.interactive = NULL)
  gui_ask(.GUI) <- oask
})
