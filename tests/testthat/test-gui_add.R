context("Adding and managing GUIs")

test_that("GUI creation", {
  gui_add("myGUI", widgets = "textCLI", ask = FALSE)
  expect_is(myGUI, "textCLI")
  expect_is(myGUI, "gui")
  expect_is(myGUI, "environment")
  expect_true(is.gui(myGUI))
  expect_identical(myGUI$name, "myGUI")
  expect_true("myGUI" %in% gui_list())

  expect_output(print(myGUI), "Graphical User Interface: myGUI")
  expect_output(print(myGUI), "using widgets from: textCLI")
  expect_output(print(myGUI), "currently inactivated")
})

test_that("GUI deletion", {
  expect_true(gui_remove("myGUI"))
  expect_false("myGUI" %in% gui_list())
})
