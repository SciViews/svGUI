.onLoad <- function(lib, pkg) {# nocov start
  # Create .GUI that contains information about the default GUI
  gui_add(".GUI")
}# nocov end

#.onUnload <- function(libpath) {
#  # We do nothing, because other packages may also use .GUI
#  # So, we leave it there!
#}

.packageName <- "svGUI" # nocov

# A copy of TempEnv() from svMisc to avoid a useless dependency
# (only internally used)
.TempEnv <- function() {
  name <- "SciViews:TempEnv"
  srch <- search()
  pos <-  match(name, srch)
  if (is.na(pos)) { # Must create it
    pos <- length(srch) - 1
    `SciViews:TempEnv` <- list()
    Attach <- function(...) get("attach", mode = "function")(...)
    Attach(`SciViews:TempEnv`, pos = pos)
  }
  pos.to.env(pos)
}
