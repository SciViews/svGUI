dont_ask <- function(gui = .GUI)
  return(!interactive() || !gui_ask(gui))

# Backward compatibility
dontAsk <- dont_ask
