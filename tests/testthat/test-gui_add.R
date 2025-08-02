test_that("GUI creation", {
  gui_add("myGUI", widgets = "textCLI", ask = FALSE)
  expect_s3_class(myGUI, "textCLI")
  expect_s3_class(myGUI, "gui")
  expect_type(myGUI, "environment")
  expect_true(is.gui(myGUI))
  expect_identical(myGUI$name, "myGUI")
  expect_true("myGUI" %in% gui_list())

  expect_output(print(myGUI), "Graphical User Interface: myGUI")
  expect_output(print(myGUI), "using widgets from: textCLI")
  expect_output(print(myGUI), "currently inactivated")

  # Challenge gui_add()/gui_change() with wrong arguments
  expect_error(gui_add(NA),
    "Wrong 'gui.name', provide a non empty character string",
    fixed = TRUE
  )
  expect_error(gui_add(character(0)),
    "Wrong 'gui.name', provide a non empty character string",
    fixed = TRUE
  )
  expect_error(gui_add(NULL),
    "Wrong 'gui.name', provide a non empty character string",
    fixed = TRUE
  )
})

test_that("GUI change widgets", {
  gui_add("myGUI", widgets = c("nativeGUI", "textCLI"))
  expect_output(print(myGUI), "using widgets from: nativeGUI, textCLI")
  expect_identical(gui_widgets(myGUI), c("nativeGUI", "textCLI"))
  gui_change("myGUI", widgets = "nativeGUI", reset = TRUE)
  expect_identical(gui_widgets(myGUI), "nativeGUI")
  expect_identical(gui_widgets(gui.name = "myGUI"), "nativeGUI")
  expect_identical(gui_widgets(myGUI, reset = TRUE) <- "textCLI", "textCLI")
  expect_identical(gui_widgets(myGUI), "textCLI")
  expect_error(gui_widgets(gui.name = "non_existing_gui"),
    "'gui' object 'non_existing_gui' not found",
    fixed = TRUE
  )
  expect_error(gui_widgets(gui = NULL),
    "Provide a 'gui' object or its name",
    fixed = TRUE
  )
})

test_that("GUI change and ask", {
  # The returned value is the previous one
  gui_ask(myGUI) <- FALSE
  expect_false(gui_ask(myGUI))
  expect_false(gui_ask(myGUI, ask  = TRUE))
  expect_true(gui_ask(myGUI))
  gui_ask(myGUI) <- FALSE
  expect_false(gui_ask(myGUI))
  expect_false(gui_ask("myGUI"))
  gui_ask(myGUI) <- NULL
  expect_identical(gui_ask(myGUI), gui_ask())
  gui_ask(myGUI) <- TRUE
  expect_true(gui_ask(myGUI))
  gui_ask(myGUI, ask = NULL)
  expect_identical(gui_ask("myGUI"), gui_ask())
  gui_change(".GUI", ask = TRUE)
  expect_true(.GUI$ask)
  gui_change(".GUI", ask = FALSE)
  expect_false(.GUI$ask)
  gui_change(".GUI", ask = NULL)
  expect_null(.GUI$ask)
  gui_ask(ask = FALSE)
  # In case of wrong gui
  assign(".nonGUI", list(a = 1, b = 2), envir = .TempEnv())
  expect_error(gui_ask(.nonGUI) <- TRUE,
    "gui_ask must be applied to a 'gui' object",
    fixed = TRUE
  )
  expect_error(gui_ask("non_existing_gui"),
    "'gui' object 'non_existing_gui' not found",
    fixed = TRUE
  )
  # Create a fake object in SciViews:TempEnv and try use it
  TempEnv <- get(".TempEnv", envir = getNamespace("svGUI"))
  assign("fake_test_object", 1, envir = TempEnv())
  expect_error(gui_ask("fake_test_object"),
    "'gui.or.name' must be a 'gui' object",
    fixed = TRUE
  )
  rm("fake_test_object", envir = TempEnv())
})

test_that("Global change of ask", {
  gui_ask(ask = TRUE)
  expect_true(gui_ask())
  # When changing value, it returns old one
  gui_ask(ask  = TRUE)
  expect_true(gui_ask(ask  = FALSE))
  expect_false(gui_ask(ask  = NULL))
  expect_null(gui_ask(ask  = TRUE))
  expect_true(gui_ask(ask  = NULL))
})

test_that("Cannot overwrite an existing object in SciViews:TempEnv", {
  expect_error(gui_add(".nonGUI"),
    "'gui.name' must be a character string naming a 'gui' object",
    fixed = FALSE
  )
})

test_that("GUI deletion", {
  expect_true(gui_remove("myGUI"))
  expect_false("myGUI" %in% gui_list())
  # Return FALSE, if the GUI does not exists
  expect_false(gui_remove("myGUI"))
  # Return TRUE, if not GUI is provided
  expect_true(gui_remove(character(0)))
  expect_true(gui_remove(NULL))
  # Issue a warning if more than one GUI name is provided
  expect_warning(gui_remove(c("myGUI1", "myGUI2")),
    "more than one item in 'gui.name', only the first one is removed",
    fixed = TRUE
  )
})
