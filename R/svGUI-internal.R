.onLoad <- function(lib, pkg) {# nocov start
  # Create .GUI that contains information about the default GUI
  gui_add(".GUI")
}# nocov end

#.onUnload <- function(libpath) {
#  # We do nothing, because other packages may also use .GUI
#}

.packageName <- "svGUI" # nocov

# A copy of TempEnv() from svMisc to avoid a useless dependency
# (only internally used)
.TempEnv <- function() {
  pos <-  match("SciViews:TempEnv", search())
  if (is.na(pos)) { # Must create it
    `SciViews:TempEnv` <- list()
    Attach <- function(...) get("attach", mode = "function")(...)
    Attach(`SciViews:TempEnv`, pos = length(search()) - 1)
    pos <- match("SciViews:TempEnv", search())
  }
  pos.to.env(pos)
}
