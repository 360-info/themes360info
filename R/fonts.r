#' Returns a CSS `@import` declaration for the 360 fonts. Used by `save_plot`
#' when saving SVG files so that other users viewing them on the web can see
#' 360info fonts without having them installed.
fontfaces_360fonts <- function() {
  list(paste0(
    "https://fonts.googleapis.com/css2?family=Public+Sans:",
    "ital,wght@0,400;0,700;0,900;1,400&display=swap"))
}