#' Returns a CSS `@import` declaration for the 360 fonts. Used by `save_plot`
#' when saving SVG files so that other users viewing them on the web can see
#' 360info fonts without having them installed.
#'
#' @importFrom svglite font_face
#' @importFrom rlang warn
#' @importFrom cli format_warning cli_bullets
fontfaces_360fonts <- function() {

  loaded_font_name <- getOption("themes360info.franklin.loaded")

  if (is.null(loaded_font_name)) {
    abort(format_warning(cli_bullets(c(
      "x" = paste0(
        "The 360info font wasn't successfully loaded, so the package ",
        "can't write font information to the SVG file.",
      "i" = "Install the Libre Franklin font on your system and reload.")
    ))))
  }

  loaded_font_spec <- switch(loaded_font_name,
    "libre" = list(paste0(
      "https://fonts.googleapis.com/css2?family=Libre+Franklin:",
      "ital,wght@0,400;0,700;0,900;1,400&display=swap")),
    list())

  return(loaded_font_spec)
}