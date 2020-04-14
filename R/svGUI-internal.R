.onLoad <- function(lib, pkg) {# nocov start
  # Create .GUI that contains information about the default GUI
  gui_add(".GUI")
  # In case svGUI is NOT loaded on the search path, I need a reference to
  # startUI() and setUI() anyway (for code like gui$startUI(....)).
  # So, create one on SciViews:TempEnv
  #assign("startUI", function(...) svGUI::startUI(...), envir = .TempEnv())
  #assign("setUI", function(...) svGUI::setUI(...), envir = .TempEnv())
}# nocov end

#.onUnload <- function(libpath) {
  # We do nothing, because other packages may also use .GUI
  # So, we leave it there!
#}

.packageName <- "svGUI" # nocov

# A copy of TempEnv() from svMisc to avoid a useless dependency
# (only internally used)
.TempEnv <- function() {
  name <- "SciViews:TempEnv"
  srch <- search()
  pos <-  match(name, srch)
  if (is.na(pos)) {# Must create it
    # This code is only executed when the package is loaded. So, it is not
    # possible to test it... but its correct execution is a preliminary or
    # we are unable to creat GUI objects in that environment. So, it is tested
    # indirectly!
    pos <- length(srch) - 1 # nocov start
    `SciViews:TempEnv` <- list()
    Attach <- function(...) get("attach", mode = "function")(...)
    Attach(`SciViews:TempEnv`, pos = pos)
  } # nocov end
  pos.to.env(pos)
}
