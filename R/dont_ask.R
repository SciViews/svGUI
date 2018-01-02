dont_ask <- function(gui = .GUI)
  !interactive() || !gui_ask(gui)

# Backward compatibility
dontAsk <- dont_ask
