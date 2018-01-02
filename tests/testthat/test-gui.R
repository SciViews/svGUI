context("GUI")

test_that(".GUI exists", {
  expect_is(.GUI, "gui")
  expect_true(is.gui(.GUI))
  expect_identical(.GUI$name, ".GUI")

  expect_true(length(gui_list()) > 0)
  expect_is(gui_list(), "character")
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
  expect_is(.GUI$test_fun, "function")
  expect_equal(.GUI$test_fun(1), 1)

  # A function with missing gui argument
  .GUI$test_fun <- function(x) x
  expect_is(.GUI$test_fun, "function")
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
})

test_that("Cannot remove .GUI or non existing GUIs", {
  expect_error(
    gui_remove(".GUI"),
    "You cannot delete the default GUI named '.GUI'! Maybe use ?gui_change.",
    fixed = TRUE
  )
  expect_false(gui_remove("non_existing_GUI"))
})
