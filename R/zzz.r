.onLoad <- function(libname, pkgname) {
  
  # option: preferred font?
  op <- options()
  op.themes360info <- list(
    # one of "itc", "libre" or "none"
    themes360info.franklin <- "itc"
  )

  # add any options that haven't been set by the user
  toset <- !(names(op.themes360info) %in% names(op))
  if(any(toset)) options(op.themes360info[toset])
  
  # register fonts on package load (it can be called manually to re-register!)
  font_choice <- getOption("themes360info.franklin")
  if ((!is.null(font_choice)) && font_choice != "none") {
    register_360fonts()
  }
}